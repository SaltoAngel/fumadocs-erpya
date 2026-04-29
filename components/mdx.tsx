import defaultMdxComponents from 'fumadocs-ui/mdx';
import type { MDXComponents } from 'mdx/types';
import { Releases } from './Releases';

export function getMDXComponents(components?: MDXComponents) {
  return {
    ...defaultMdxComponents,
    Releases,
    // Forzamos el uso de la etiqueta img nativa pero manejamos objetos de Next.js
    img: (props: React.ImgHTMLAttributes<HTMLImageElement>) => {
      // Si src es un objeto, extraemos la URL real
      const src = typeof props.src === 'object' && props.src !== null ? (props.src as any).src : props.src;
      return (
        // eslint-disable-next-line @next/next/no-img-element
        <img 
          {...props} 
          src={src}
          loading="lazy" 
          style={{ maxWidth: '100%', height: 'auto' }} 
          alt={props.alt || ''} 
        />
      );
    },
    ...components,
  } satisfies MDXComponents;
}

export const useMDXComponents = getMDXComponents;

declare global {
  type MDXProvidedComponents = ReturnType<typeof getMDXComponents>;
}
