import Image from 'next/image';
import Link from 'next/link';
import { source } from '@/lib/source';
import { 
  FaGithub, 
  FaTwitter, 
  FaDiscord, 
  FaBookOpen,
  FaFolder,
  FaHashtag,
  FaHistory
} from 'react-icons/fa';

export function BloggerInfo() {
  const allPages = source.getPages();
  
  const featuredArticles = allPages
    .slice(0, 5)
    .map(page => ({
      title: page.data.title,
      url: page.url
    }));

  const stats = [
    { label: 'Artículos', count: allPages.length, link: '/article/', icon: <FaBookOpen /> },
    { label: 'Categoría', count: 7, link: '/category/', icon: <FaFolder /> },
    { label: 'Etiquetas', count: 441, link: '/tag/', icon: <FaHashtag /> },
    { label: 'Historial', count: 2, link: '/timeline/', icon: <FaHistory /> },
  ];

  return (
    <aside className="space-y-6">
      {/* Perfil */}
      <div className="p-6 rounded-2xl border border-fd-border bg-fd-card backdrop-blur-md">
        <div className="flex flex-col items-center text-center group cursor-pointer">
          <div className="relative w-20 h-20 mb-4 rounded-full overflow-hidden border-2 border-fd-primary/20 group-hover:border-fd-primary transition-all">
            <Image 
              src="/logo.png" 
              alt="Blogger Avatar" 
              fill 
              className="object-contain p-2 bg-fd-muted"
            />
          </div>
          <h3 className="text-lg font-bold text-fd-foreground group-hover:text-fd-primary transition-colors">
            ERP Consultores y Asociados, C.A.
          </h3>
          <p className="text-fd-muted-foreground text-xs mt-2 leading-relaxed">
            Documentación Oficial de ERP Consultores y Asociados, CA
          </p>
        </div>

        {/* Estadísticas */}
        <div className="grid grid-cols-4 gap-2 mt-8 border-t border-fd-border pt-6">
          {stats.map((stat) => (
            <Link key={stat.label} href={stat.link} className="flex flex-col items-center group">
              <span className="text-fd-primary text-sm mb-1 group-hover:scale-110 transition-transform">
                {stat.icon}
              </span>
              <span className="text-fd-foreground font-bold text-sm">{stat.count}</span>
              <span className="text-[10px] text-fd-muted-foreground uppercase tracking-tighter">{stat.label}</span>
            </Link>
          ))}
        </div>

        <Link 
          href="https://github.com/adempiere" 
          target="_blank"
          className="mt-6 flex items-center justify-center gap-2 w-full py-2 rounded-xl bg-fd-primary text-fd-primary-foreground font-bold text-sm hover:opacity-90 transition-all shadow-lg shadow-fd-primary/20"
        >
          <FaGithub /> Seguir
        </Link>

        {/* Social Links */}
        <div className="flex justify-center gap-4 mt-6 text-fd-muted-foreground">
          <a href="#" className="hover:text-fd-primary transition-colors"><FaGithub size={18} /></a>
          <a href="#" className="hover:text-fd-primary transition-colors"><FaTwitter size={18} /></a>
          <a href="https://discord.gg/UWcyn7DEzV" className="hover:text-fd-primary transition-colors"><FaDiscord size={18} /></a>
        </div>
      </div>

      {/* Artículos Destacados */}
      <div className="p-6 rounded-2xl border border-fd-border bg-fd-card backdrop-blur-md">
        <h4 className="text-fd-foreground font-bold mb-6 flex items-center gap-2 text-sm uppercase tracking-widest border-b border-fd-border pb-3">
          <span className="w-2 h-2 bg-fd-primary rounded-full animate-pulse"></span>
          Artículos Destacados
        </h4>
        <div className="space-y-4">
          {featuredArticles.map((article, idx) => (
            <Link 
              key={idx} 
              href={article.url} 
              className="flex items-start gap-3 group"
            >
              <div className="mt-1.5 w-1 h-1 rounded-full bg-fd-muted-foreground/30 group-hover:bg-fd-primary transition-all shrink-0"></div>
              <span className="text-sm text-fd-muted-foreground group-hover:text-fd-foreground transition-colors line-clamp-2 leading-tight">
                {article.title}
              </span>
            </Link>
          ))}
        </div>
      </div>
    </aside>
  );
}
