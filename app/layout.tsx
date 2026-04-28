import { RootProvider } from 'fumadocs-ui/provider/next';
import './global.css';
import { Inter } from 'next/font/google';
import { Navbar } from '@/components/Navbar';

const inter = Inter({
  subsets: ['latin'],
});

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es" className={inter.className} suppressHydrationWarning>
      <body className="flex flex-col min-h-screen bg-[#0a0c10] text-white selection:bg-[#5c92d1]/30">
        <RootProvider>
          <Navbar />
          <div className="flex-1">
            {children}
          </div>
        </RootProvider>
      </body>
    </html>
  );
}
