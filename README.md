# ERPyA Documentation (React/Fumadocs)

This is the modernized documentation site for ERP Consultores y Asociados, C.A., migrated from VuePress to React using the Fumadocs framework.

## Project Structure

- `content/docs`: Documentation source files (.md and .mdx).
- `app/`: Next.js application routes.
- `components/`: Custom React components (e.g., `Releases.tsx`).
- `public/`: Static assets (images, logos, etc.).
- `docsVue/`: Reference to the original VuePress project (to be removed after verification).

## Development

Run the development server:

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Build

To build the production bundle:

```bash
pnpm build
```

## Migration Notes

- **Design**: The design strictly follows the original VuePress theme colors and layout.
- **Components**: Custom Vue components like `Releases` have been ported to React.
- **MDX**: VuePress containers (`::: tip`) have been converted to Fumadocs `<Callout>`.
