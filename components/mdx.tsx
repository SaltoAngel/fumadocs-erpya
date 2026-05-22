import { ImageZoom } from "fumadocs-ui/components/image-zoom";
import defaultMdxComponents from "fumadocs-ui/mdx";
import * as TabsComponents from 'fumadocs-ui/components/tabs';
import type { MDXComponents } from "mdx/types";
import { LeaderCards } from "./LeaderCards";
import { Releases } from "./Releases";

export function getMDXComponents(components?: MDXComponents) {
  return {
    ...defaultMdxComponents,
    ...TabsComponents,
    Releases,
    LeaderCards,
    // Forzamos el uso de ImageZoom para permitir zoom en imágenes
    img: (props: React.ImgHTMLAttributes<HTMLImageElement>) => (
      <ImageZoom
        // biome-ignore lint/suspicious/noExplicitAny: props shape from MDX/React varies
        {...(props as any)}
        style={{ maxWidth: "100%", height: "auto" }}
      />
    ),
    ...components,
  } satisfies MDXComponents;
}

export const useMDXComponents = getMDXComponents;

declare global {
  type MDXProvidedComponents = ReturnType<typeof getMDXComponents>;
}
