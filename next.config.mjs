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
  remarkImageOptions: {
    enabled: false,
    external: false,
    useImport: false, // <-- Crucial: evita que Next.js intente procesar los archivos PNG
  }
});

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  allowedDevOrigins: ['192.168.5.227', 'localhost:3001'],
  images: {
    unoptimized: true,
    remotePatterns: [{ protocol: 'https', hostname: '**' }],
  },
};

export default withMDX(config);
