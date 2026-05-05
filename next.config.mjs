import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX({
  mdxOptions: {
    remarkPlugins: [],
  }
});

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  output: 'standalone',
  allowedDevOrigins: ['192.168.5.227', 'localhost:3001'],
  images: {
    unoptimized: true,
    remotePatterns: [{ protocol: 'https', hostname: '**' }],
  },
  // experimental: {
  //   // Aumenta el número de procesos para la generación estática
  //   cpus: 5, 
  //   workerThreads: true,
  // },
};

export default withMDX(config);
