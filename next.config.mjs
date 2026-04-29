import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX({
  mdxOptions: {
    remarkPlugins: [],
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
