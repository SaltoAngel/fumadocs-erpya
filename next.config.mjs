import { createMDX } from 'fumadocs-mdx/next';
import { visit } from 'unist-util-visit';

function remarkNativeImages() {
  return (tree) => {
    visit(tree, 'image', (node) => {
      node.type = 'html';
      node.value = `<img src="${node.url}" alt="${node.alt || ''}" loading="lazy" style="max-width: 100%; height: auto;" />`;
    });
  };
}

const withMDX = createMDX({
  mdxOptions: {
    remarkPlugins: [remarkNativeImages],
  },
  // Intentamos anular el plugin pasando parámetros que lo dejen inoperante
  remarkImageOptions: {
    enabled: false,
    external: false,
    publicDir: 'non-existent-folder'
  }
});

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  // CORRECCIÓN: allowedDevOrigins va en la raíz, no en experimental
  allowedDevOrigins: ['192.168.5.227', 'localhost:3001'],
  images: {
    unoptimized: true,
    remotePatterns: [{ protocol: 'https', hostname: '**' }],
  },
};

export default withMDX(config);
