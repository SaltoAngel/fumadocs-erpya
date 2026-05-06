import axios from 'axios';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';

// Cargar variables de entorno
dotenv.config({ path: '.env.local' });

const KEYCLOAK_URL = 'http://localhost:8080';
const ADMIN_USER = 'admin';
const ADMIN_PASS = '123';
const REALM_NAME = 'ERP Docs';
const DOCS_PATH = 'content/docs';

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
    console.error('Error obteniendo token de administrador:', error.response?.data || error.message);
    process.exit(1);
  }
}

function getAllPossibleRoles(dir, roles = [], depth = 0) {
  const files = fs.readdirSync(dir);

  for (const file of files) {
    const fullPath = path.join(dir, file);
    const isDirectory = fs.statSync(fullPath).isDirectory();

    // SOLO generamos roles para CARPETAS (no archivos individuales)
    // Esto mantiene el token JWT pequeño.
    // El sistema jerárquico ya da acceso a todos los archivos dentro de una carpeta.
    if (isDirectory) {
      const relativePath = path.relative('content', fullPath);
      const roleName = relativePath.split(path.sep).join(':');
      // Solo roles de primer nivel: docs:carpeta (máximo 2 segmentos)
      if (roleName.split(':').length <= 2) {
        roles.push(roleName);
      }
      getAllPossibleRoles(fullPath, roles, depth + 1);
    }
  }
  return [...new Set(roles)];
}

async function syncRoles() {
  console.log('🚀 Iniciando sincronización de roles con Keycloak...');
  
  const token = await getAdminToken();
  const rolesNeeded = getAllPossibleRoles(DOCS_PATH);
  
  // Añadir rol 'admin' por defecto
  if (!rolesNeeded.includes('admin')) rolesNeeded.push('admin');
  // Añadir rol 'docs' base
  if (!rolesNeeded.includes('docs')) rolesNeeded.push('docs');

  console.log(`🔍 Se encontraron ${rolesNeeded.length} roles potenciales.`);

  const authHeader = { Authorization: `Bearer ${token}` };
  const encodedRealm = encodeURIComponent(REALM_NAME);

  // 1. Obtener roles existentes
  let existingRoles = [];
  try {
    const response = await axios.get(
      `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles`,
      { headers: authHeader }
    );
    existingRoles = response.data.map(r => r.name);
  } catch (error) {
    console.error('Error obteniendo roles existentes:', error.response?.data || error.message);
    return;
  }

  // 2. Crear roles que faltan
  for (const roleName of rolesNeeded) {
    if (existingRoles.includes(roleName)) {
      console.log(`✅ El rol "${roleName}" ya existe.`);
      continue;
    }

    try {
      await axios.post(
        `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles`,
        {
          name: roleName,
          description: `Rol automático para acceso a: ${roleName.replace(/:/g, ' > ')}`
        },
        { headers: authHeader }
      );
      console.log(`✨ Rol creado con éxito: "${roleName}"`);
    } catch (error) {
      console.error(`❌ Error creando rol "${roleName}":`, error.response?.data || error.message);
    }
  }

  console.log('🏁 Sincronización finalizada.');
}

syncRoles();
