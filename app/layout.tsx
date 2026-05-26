import { RootProvider } from 'fumadocs-ui/provider/next';
import './global.css';
import { Inter } from 'next/font/google';
import { Navbar } from '@/components/Navbar';
import AuthProvider from '@/components/AuthProvider';
import { getPublicPaths } from '@/lib/source';

const inter = Inter({
  subsets: ['latin'],
});

export const metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'https://docs.erpya.com'),
  title: {
    template: '%s | ERPyA Docs',
    default: 'ERPyA Documentation',
  },
  description: 'Documentación oficial de ERPyA y ADempiere ERP.',
};

export default function Layout({ children }: { children: React.ReactNode }) {
  const publicPaths = getPublicPaths();
  
  return (
    <html lang="es" className={inter.className} suppressHydrationWarning>
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&family=Geist:wght@400;600;700;800&display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&display=swap" rel="stylesheet" />
      </head>
      <body className="flex flex-col min-h-screen">
        <AuthProvider>
          <RootProvider>
            <Navbar publicPaths={publicPaths} />
            <div className="flex-1 pt-[60px]">
              {children}
            </div>
          </RootProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
