import { defineConfig, defineDocs } from 'fumadocs-mdx/config';
import { metaSchema, pageSchema } from 'fumadocs-core/source/schema';
import { z } from 'zod';

// Personalizamos el esquema para aceptar los campos de VuePress
export const docs = defineDocs({
  dir: 'content/docs',
  docs: {
    schema: pageSchema.extend({
      category: z.string().optional(),
      star: z.number().optional(),
      sticky: z.number().optional(),
      // Usamos coerce para convertir fechas o números en las etiquetas a string automáticamente
      tag: z.array(z.coerce.string()).optional(),
      article: z.boolean().optional(),
    }),
    postprocess: {
      includeProcessedMarkdown: true,
    },
  },
  meta: {
    schema: metaSchema,
  },
});

export default defineConfig({
  mdxOptions: {
    // MDX options
  },
});
