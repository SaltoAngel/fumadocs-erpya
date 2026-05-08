# ERPyA Documentation Site

Este es el sitio de documentación oficial de **ERPyA**, migrado de VuePress a **Fumadocs** (basado en Next.js). El sitio ofrece una experiencia moderna, rápida y con soporte nativo para modo oscuro/claro.

## 🚀 Inicio Rápido

### Requisitos Previos

Asegúrate de tener instalado:
*   [Node.js](https://nodejs.org/) (Versión 18 o superior recomendada).
*   [pnpm](https://pnpm.io/) (Gestor de paquetes recomendado).

### Instalación

1.  Clona el repositorio.
2.  Instala las dependencias:
    ```bash
    pnpm install
    ```

### Desarrollo

Para iniciar el servidor de desarrollo:
```bash
pnpm dev
```
El sitio estará disponible en `http://localhost:3001`.

## 🐳 Inicio Rápido con Keycloak y Docker

Si no tienes una instancia de Keycloak, puedes levantar una rápidamente con Docker para pruebas locales.

### 1. Iniciar Keycloak
Ejecuta el siguiente comando en tu terminal para iniciar un contenedor de Keycloak en el puerto 8080:

```bash
docker run -p 127.0.0.1:8080:8080 \
  -e KC_BOOTSTRAP_ADMIN_USERNAME=admin \
  -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:26.6.1 start-dev
```
*Esto creará un usuario administrador inicial con el nombre `admin` y la contraseña `admin`.*

### 2. Crear un Realm (Dominio)
1.  Entra a la [Consola de Administración](http://localhost:8080).
2.  Haz clic en **Manage realms** (columna izquierda) -> **Create realm**.
3.  Ingresa un nombre (ej: `Prueba`) y haz clic en **Create**.

### 3. Crear un Usuario Admin Permanente
1.  Dentro de tu Realm, ve a **Users** -> **Create new user**.
2.  Ingresa un **Username** (ej: `myuser`) y haz clic en **Create**.
3.  Ve a la pestaña **Credentials** -> **Set password**.
4.  Ingresa una contraseña y desactiva la opción **Temporary** para que no pida cambiarla al primer inicio.

### 4. Registrar la Aplicación (Client)
1.  Ve a **Clients** -> **Create client**.
2.  **Client ID**: `fumadocs` (Debe ser el mismo que el de la variable de entorno `KEYCLOAK_ID`).
3.  Haz clic en **Next**, asegúrate de que **Standard flow** esté activo.
4.  En **Login settings**, configura:
    *   **Valid redirect URIs**: `http://localhost:3001/api/auth/callback/keycloak` (Debe ser el mismo que el de la variable de entorno `NEXTAUTH_URL` seguido de `/api/auth/callback/keycloak`).
    *   **Web origins**: `http://localhost:3001` (Debe ser el mismo que el de la variable de entorno `NEXTAUTH_URL`).
5.  Haz clic en **Save**.

---

## Configuración de Seguridad (Keycloak)

Este proyecto utiliza **Keycloak** para gestionar el acceso jerárquico a la documentación.

### 1. Configuración en el Panel de Keycloak

1.  **Crear un Realm**: (Ej: `Prueba`).
2.  **Configurar el Client**:
    *   **Client ID**: `fumadocs`.
    *   **Client Protocol**: `openid-connect`.
    *   **Capability Config**: 
        *   **Client Authentication**: `ON` (Access Type: Confidential).
        *   **Authorization**: `OFF`.
        *   **Authentication Flow**: `Standard Flow` y `Direct Access Grants` (opcional) activos.
    *   **Login Settings**:
        *   **Valid Redirect URIs**: `http://localhost:3001/api/auth/callback/keycloak`
        *   **Web Origins**: `http://localhost:3001`
        (el puerto se puede cambiar acorde a las necesidades del entorno)
    *   **Credenciales**: Una vez guardado, ve a la pestaña **Credentials** y copia el `Client Secret`.
3.  **Configurar Roles**:
    *   Ve a **Realm Roles** (en el menú lateral izquierdo).
    *   Haz clic en **Create role**.
    *   **Realm Roles**: Crea los roles necesarios siguiendo la convención.
    *   **Convención de nombres**: El sistema usa rutas jerárquicas separadas por dos puntos.
        *   `admin`: Superusuario (acceso a todo).
        *   `docs:about`: Acceso a toda la sección "Nosotros".
        *   `docs:product:technology`: Acceso específico a la subsección "Tecnología" de Producto.
4.  **Configurar Mappers (¡CRÍTICO!)**:
    *   Para que NextAuth reciba los roles, deben estar en el Token.
    *   Ve a **Client Scopes** (en el menú lateral izquierdo, fuera de la configuración del cliente).
    *   Busca el scope llamado **`roles`** (suele venir predefinido por Keycloak). Si no existe, créalo.
    *   Entra en el scope `roles` -> Pestaña **Mappers** -> Selecciona el mapper **`realm roles`**.
    *   Asegúrate de que:
        *   **Add to ID token**: `ON`.
        *   **Add to access token**: `ON`.
        *   **Add to userinfo**: `ON`.
        *   **Token Claim Name**: `realm_access.roles` (o simplemente `roles` si prefieres simplificar, pero el proyecto está configurado para buscar en ambos).

### 4. Asignar Roles a Usuarios

1.  Ve a **Users** (menú lateral izquierdo).
2.  Busca y haz clic en el usuario al que quieres dar permisos.
3.  Ve a la pestaña **Role Mapping**.
4.  Haz clic en **Assign role**.
5.  Filtra por "Filter by realm roles" y selecciona los roles deseados (ej: `admin`, `docs:about`, etc.).
6.  Haz clic en **Assign**.

> [!IMPORTANT]
> **Refresco de Permisos**: Para que los cambios de roles se vean reflejados en la aplicación, el usuario **debe cerrar sesión y volver a entrar**.
>
> **¿Por qué?**: El sistema utiliza tokens (JWT) que se generan en el momento del inicio de sesión. Estos tokens contienen la "fotografía" de los permisos del usuario en ese instante y se guardan de forma cifrada en la sesión del navegador. Por seguridad y rendimiento, el sistema no consulta a Keycloak en cada clic, sino que confía en la información del token hasta que este expira o el usuario vuelve a autenticarse.

### 2. Variables de Entorno (`.env.local`)

Crea un archivo `.env.local` en la raíz. Puedes generar una clave aleatoria fuerte para `NEXTAUTH_SECRET` con este comando:

```bash
openssl rand -base64 32
```

Contenido del archivo:

```bash
# NextAuth
NEXTAUTH_URL=http://localhost:3001
NEXTAUTH_SECRET=tu-clave-secreta-generada-aleatoriamente-aqui

# Keycloak
KEYCLOAK_ID=fumadocs
KEYCLOAK_SECRET=tu-secret-de-keycloak
KEYCLOAK_ISSUER=http://localhost:8080/realms/Prueba
```

**Descripción de las variables:**

*   **`NEXTAUTH_URL`**: La URL base de tu aplicación. Se usa para construir las URLs de redirección de autenticación.
*   **`NEXTAUTH_SECRET`**: Una clave aleatoria usada para cifrar las cookies de sesión y firmar los tokens JWT. **Es crítica para la seguridad**.
*   **`KEYCLOAK_ID`**: El **Client ID** que configuraste en Keycloak (ej: `fumadocs`).
*   **`KEYCLOAK_SECRET`**: El **Secret** que copiaste de la pestaña *Credentials* en el panel de Keycloak.
*   **`KEYCLOAK_ISSUER`**: La URL completa del Realm en Keycloak. Sirve para que la app descubra automáticamente los puntos de conexión (login, logout, token, etc.).

### 3. Modelo de Seguridad

*   **Privado por defecto**: Si una carpeta o archivo no tiene permiso explícito, hereda la restricción de su padre.
*   **Roles Automáticos**: El sistema genera automáticamente el rol necesario basado en la ruta. Por ejemplo, para ver `/docs/accounting-management/configuration`, el usuario debe tener el rol `docs:accounting-management` o `docs:accounting-management:configuration`.
*   **Acceso Público**: Para que una página sea visible sin login, añade `role: public` al frontmatter del archivo `.mdx`:
    ```markdown
    ---
    title: Mi Página Pública
    role: public
    ---
    ```

---

## 🛠️ Automatización de Roles (Keycloak)

Para evitar tener que crear manualmente cada rol en Keycloak, el proyecto incluye un script de gestión automatizada.

### ¿Qué hace el script?
1.  **Sincronización**: Escanea tus carpetas en `content/docs` y crea los roles necesarios (ej: `docs:mi-seccion`) si no existen.
2.  **Limpieza**: Elimina roles obsoletos o de archivos individuales (para mantener el Token JWT ligero y eficiente).

### Cómo usarlo
Asegúrate de tener el entorno de desarrollo o los contenedores encendidos y ejecuta:

```bash
node scripts/manage-roles.mjs
```

> [!IMPORTANT]
> El script utiliza las credenciales definidas en tu `.env.local`. Por defecto, solo crea roles para **carpetas**. Los archivos dentro de esas carpetas heredan automáticamente el permiso, lo que optimiza el rendimiento de Keycloak.

---

## 🐳 Despliegue con Docker

El proyecto está preparado para ser ejecutado en contenedores usando el modo `standalone` de Next.js.

### 1. Construir la imagen manualmente
```bash
docker build -t fumadocs-erpya -f docker/Dockerfile .
```

### 2. Ejecutar con Docker Compose (Recomendado)
Asegúrate de tener tu archivo `.env.local` configurado y luego ejecuta:
```bash
docker compose -f docker/docker-compose.yml up -d
```

### 3. Ejecutar con Docker Run (Pasando variables por comando)
Si prefieres no usar un archivo de entorno, puedes pasar las variables directamente con el flag `-e`:

```bash
docker run -p 3001:3000 \
  -e NEXTAUTH_URL=http://localhost:3001 \
  -e NEXTAUTH_SECRET=tu_clave_secreta \
  -e KEYCLOAK_ID=fumadocs \
  -e KEYCLOAK_SECRET=tu_keycloak_secret \
  -e KEYCLOAK_ISSUER=http://tu-servidor:8080/realms/Prueba \
  fumadocs-erpya
```

El sitio estará disponible en `http://localhost:3001`.

---

## 🗄️ Persistencia y Producción (PostgreSQL)

Por defecto, los ejemplos anteriores de Keycloak usan una base de datos interna volátil (H2). **Para producción, es obligatorio usar PostgreSQL** para no perder usuarios ni roles.

### Uso de la plantilla completa
He preparado el archivo `docker/docker-compose.yml` que levanta todo el stack (App + Keycloak + Postgres) con persistencia:

```bash
docker compose -f docker/docker-compose.yml up -d
```

### Configuración manual de Keycloak con Postgres
Si ya tienes un Postgres y quieres conectar Keycloak, debes pasar estas variables al contenedor de Keycloak:

*   **`KC_DB`**: `postgres`
*   **`KC_DB_URL`**: `jdbc:postgresql://<HOST>:<PUERTO>/<DB_NAME>`
*   **`KC_DB_USERNAME`**: El usuario de tu BD.
*   **`KC_DB_PASSWORD`**: La contraseña de tu BD.

> [!TIP]
> En el archivo `docker/docker-compose.yml`, verás que usamos un **Volume** de Docker (`postgres_data`) para la base de datos. Además, hemos incluido archivos de respaldo (`keycloak_backup.sql` y `realm-export.json`) que se importan automáticamente la primera vez que levantas el entorno. Esto asegura que los roles (`admin`, `docs:*`) y clientes ya estén preconfigurados.

---

## Producción

Para generar el sitio estático optimizado localmente (sin Docker):
```bash
pnpm build
pnpm start
```

## 📁 Estructura del Proyecto

*   `/content/docs`: Contiene todos los archivos Markdown (`.md`) y MDX (`.mdx`) de la documentación.
*   `/public/assets`: Directorio de recursos estáticos (imágenes, logos, etc.).
*   `/components`: Componentes React personalizados para el sitio.
*   `/app`: Rutas y lógica de Next.js (App Router).

## 🛠️ Solución de Problemas

### Puerto ocupado (EADDRINUSE)
Si ves un error indicando que el puerto 3000 ya está en uso, puedes forzar otro puerto usando:
```bash
PORT=3005 pnpm dev
```
