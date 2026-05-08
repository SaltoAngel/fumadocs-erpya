import axios from 'axios';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';

// Cargar variables de entorno
dotenv.config({ path: '.env.local' });

// Configuración (Priorizar variables de entorno si existen)
const KEYCLOAK_URL = process.env.KEYCLOAK_URL || 'http://localhost:8080';
const ADMIN_USER = process.env.KC_BOOTSTRAP_ADMIN_USERNAME || 'admin';
const ADMIN_PASS = process.env.KC_BOOTSTRAP_ADMIN_PASSWORD || '123';
const REALM_NAME = 'ERP Docs'; // Nombre del realm definido en realm-export.json
const DOCS_PATH = 'content/docs';

// Roles del sistema que NUNCA debemos borrar
const SYSTEM_ROLES = [
  'admin',
  'docs',
  'uma_authorization',
  'offline_access',
  'default-roles-erp docs',
  'create-realm',
  'view-realm',
  'view-users',
  'manage-users',
  'manage-realm',
  'query-realms',
  'query-users',
  'query-groups',
  'query-clients',
];

async function getAdminToken() {
  try {
    const params = new URLSearchParams();
    params.append('username', ADMIN_USER);
    params.append('password', ADMIN_PASS);
    params.append('grant_type', 'password');
    params.append('client_id', 'admin-cli');

    const response = await axios.post(
      `${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token`,
      params
    );
    return response.data.access_token;
  } catch (error) {
    console.error('❌ Error obteniendo token de administrador:', error.response?.data || error.message);
    process.exit(1);
  }
}

function getAllPossibleRoles(dir, roles = []) {
  if (!fs.existsSync(dir)) return roles;
  const files = fs.readdirSync(dir);

  for (const file of files) {
    const fullPath = path.join(dir, file);
    const isDirectory = fs.statSync(fullPath).isDirectory();

    if (isDirectory) {
      const relativePath = path.relative('content', fullPath);
      const roleName = relativePath.split(path.sep).join(':');
      
      // Solo roles de carpeta: docs:nombre-carpeta (max 2 segmentos)
      if (roleName.split(':').length <= 2) {
        roles.push(roleName);
      }
      getAllPossibleRoles(fullPath, roles);
    }
  }
  return [...new Set(roles)];
}

async function manageRoles() {
  console.log('🚀 Iniciando gestión unificada de roles...\n');
  
  const token = await getAdminToken();
  const authHeader = { Authorization: `Bearer ${token}` };
  const encodedRealm = encodeURIComponent(REALM_NAME);

  // 1. Obtener roles necesarios desde el sistema de archivos
  const rolesNeeded = getAllPossibleRoles(DOCS_PATH);
  if (!rolesNeeded.includes('admin')) rolesNeeded.push('admin');
  if (!rolesNeeded.includes('docs')) rolesNeeded.push('docs');

  console.log(`🔍 Carpetas encontradas: ${rolesNeeded.filter(r => r.startsWith('docs:')).length}`);

  // 2. Obtener roles actuales en Keycloak (paginado)
  let existingRoles = [];
  try {
    let first = 0;
    const max = 100;
    while (true) {
      const response = await axios.get(
        `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles?first=${first}&max=${max}`,
        { headers: authHeader }
      );
      if (response.data.length === 0) break;
      existingRoles = [...existingRoles, ...response.data];
      first += max;
    }
  } catch (error) {
    console.error('❌ Error obteniendo roles de Keycloak:', error.response?.data || error.message);
    return;
  }

  const existingRoleNames = existingRoles.map(r => r.name);
  console.log(`📋 Roles actuales en Keycloak: ${existingRoleNames.length}\n`);

  // --- FASE 1: SINCRONIZACIÓN (CREAR FALTANTES) ---
  console.log('✨ Fase 1: Sincronización de roles...');
  let created = 0;
  for (const roleName of rolesNeeded) {
    if (existingRoleNames.includes(roleName)) continue;

    try {
      await axios.post(
        `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles`,
        {
          name: roleName,
          description: `Rol automático para acceso a: ${roleName.replace(/:/g, ' > ')}`
        },
        { headers: authHeader }
      );
      console.log(`   ✅ Creado: "${roleName}"`);
      created++;
    } catch (error) {
      console.error(`   ❌ Error creando "${roleName}":`, error.response?.data || error.message);
    }
  }
  if (created === 0) console.log('   (Todos los roles necesarios ya existen)');

  // --- FASE 2: LIMPIEZA (BORRAR OBSOLETOS/INDIVIDUALES) ---
  console.log('\n🧹 Fase 2: Limpieza de roles innecesarios...');
  let deleted = 0;
  const rolesToDelete = existingRoles.filter(role => {
    // No borrar roles del sistema
    if (SYSTEM_ROLES.includes(role.name)) return false;
    // Solo tocar roles que empiecen por docs:
    if (!role.name.startsWith('docs:')) return false;
    // Borrar si no está en la lista de necesarios (ej: roles de archivos individuales o carpetas borradas)
    return !rolesNeeded.includes(role.name);
  });

  for (const role of rolesToDelete) {
    try {
      await axios.delete(
        `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles/${encodeURIComponent(role.name)}`,
        { headers: authHeader }
      );
      console.log(`   🗑️  Borrado: "${role.name}"`);
      deleted++;
    } catch (error) {
      console.error(`   ❌ Error borrando "${role.name}":`, error.response?.data || error.message);
    }
  }
  if (deleted === 0) console.log('   (No hay roles obsoletos que limpiar)');

  console.log(`\n🏁 Gestión finalizada. Creados: ${created}, Borrados: ${deleted}.`);
}

manageRoles().catch(err => {
  console.error('💥 Error fatal:', err.message);
  process.exit(1);
});
