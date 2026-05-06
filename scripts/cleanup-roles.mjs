import axios from 'axios';

const KEYCLOAK_URL = 'http://localhost:8080';
const ADMIN_USER = 'admin';
const ADMIN_PASS = '123';
const REALM_NAME = 'ERP Docs';

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
}

// Un rol es de "carpeta" (lo que queremos CONSERVAR) si tiene max 2 segmentos
// Ejemplos que se CONSERVAN: "docs", "docs:accounting-management"
// Ejemplos que se BORRAN:    "docs:accounting-management:combination", "docs:product:technology"
function isFolderRole(roleName) {
  const segments = roleName.split(':');
  return segments.length <= 2;
}

async function cleanupRoles() {
  console.log('🧹 Iniciando limpieza de roles de archivos individuales...\n');

  const token = await getAdminToken();
  const authHeader = { Authorization: `Bearer ${token}` };
  const encodedRealm = encodeURIComponent(REALM_NAME);

  // Obtener TODOS los roles del Realm (paginando de 50 en 50)
  let allRoles = [];
  let first = 0;
  const max = 100;

  console.log('📋 Obteniendo lista completa de roles...');
  while (true) {
    const response = await axios.get(
      `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles?first=${first}&max=${max}`,
      { headers: authHeader }
    );
    const batch = response.data;
    if (batch.length === 0) break;
    allRoles = [...allRoles, ...batch];
    first += max;
    process.stdout.write(`\r   Obtenidos ${allRoles.length} roles...`);
  }

  console.log(`\n\n✅ Total de roles encontrados: ${allRoles.length}`);

  // Filtrar los que debemos borrar
  const rolesToDelete = allRoles.filter(role => {
    if (SYSTEM_ROLES.includes(role.name)) return false;    // Nunca borrar del sistema
    if (!role.name.startsWith('docs:')) return false;       // Solo tocar los de 'docs:'
    return !isFolderRole(role.name);                        // Borrar si es de archivo (3+ niveles)
  });

  const rolesToKeep = allRoles.filter(role => 
    role.name.startsWith('docs:') && isFolderRole(role.name)
  );

  console.log(`\n📁 Roles de CARPETA que se conservarán: ${rolesToKeep.length}`);
  rolesToKeep.forEach(r => console.log(`   ✅ ${r.name}`));

  console.log(`\n🗑️  Roles de ARCHIVO que se borrarán: ${rolesToDelete.length}`);

  if (rolesToDelete.length === 0) {
    console.log('\nNo hay nada que borrar. ¡El sistema ya está limpio!');
    return;
  }

  let deleted = 0;
  let errors = 0;

  for (const role of rolesToDelete) {
    try {
      await axios.delete(
        `${KEYCLOAK_URL}/admin/realms/${encodedRealm}/roles/${encodeURIComponent(role.name)}`,
        { headers: authHeader }
      );
      deleted++;
      process.stdout.write(`\r   Borrados: ${deleted}/${rolesToDelete.length}...`);
    } catch (error) {
      errors++;
      console.error(`\n❌ Error borrando "${role.name}":`, error.response?.data?.error || error.message);
    }
  }

  console.log(`\n\n🏁 Limpieza finalizada.`);
  console.log(`   ✅ Borrados: ${deleted}`);
  if (errors > 0) console.log(`   ❌ Errores: ${errors}`);
  console.log(`\nAhora reinicia el servidor Keycloak para que libere la memoria.`);
}

cleanupRoles().catch(err => {
  console.error('Error fatal:', err.response?.data || err.message);
  process.exit(1);
});
