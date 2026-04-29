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
El sitio estará disponible en `http://localhost:3000` (o `3001` si el puerto 3000 está ocupado).

### Producción

Para generar el sitio estático optimizado:
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

### Imágenes rotas
Si añades nuevas imágenes, asegúrate de que estén en la carpeta `/public` y usa rutas absolutas desde la raíz (ej: `/assets/img/mi-imagen.png`). El sistema está configurado para manejar objetos de imagen de Next.js automáticamente.

---

Desarrollado con ❤️ por el equipo de ERPyA.
