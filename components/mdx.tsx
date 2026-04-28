import defaultMdxComponents from 'fumadocs-ui/mdx';
import type { MDXComponents } from 'mdx/types';
import { Releases } from './Releases';

export function getMDXComponents(components?: MDXComponents) {
  return {
    ...defaultMdxComponents,
    Releases,
    // Forzamos el uso de la etiqueta img nativa para evitar procesamientos de servidor
    img: (props: React.ImgHTMLAttributes<HTMLImageElement>) => (
      // eslint-disable-next-line @next/next/no-img-element
      <img {...props} loading="lazy" style={{ maxWidth: '100%', height: 'auto' }} alt={props.alt || ''} />
    ),
    ...components,
  } satisfies MDXComponents;
}

export const useMDXComponents = getMDXComponents;

declare global {
  type MDXProvidedComponents = ReturnType<typeof getMDXComponents>;
}
