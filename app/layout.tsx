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
      <body className="flex flex-col min-h-screen">
        <AuthProvider>
          <RootProvider>
            <Navbar publicPaths={publicPaths} />
            <div className="flex-1">
              {children}
            </div>
          </RootProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
