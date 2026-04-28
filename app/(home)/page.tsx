import Link from 'next/link';
import Image from 'next/image';
import { BloggerInfo } from '@/components/BloggerInfo';
import { source } from '@/lib/source';
import { FaCalendarAlt, FaTag, FaChevronRight } from 'react-icons/fa';

export default function HomePage() {
  const projects = [
    {
      name: 'Liberación de ADempiere 3.9.4',
      desc: 'La versión 3.9.4 ya está disponible',
      link: 'https://github.com/adempiere/adempiere/releases/tag/3.9.4',
      icon: '/logo.png',
      color: 'rgba(128, 0, 0, 0.4)',
    },
    {
      name: 'Nueva Interfaz para ADempiere',
      desc: 'Completamente desarrollada con Vue JS',
      link: 'https://github.com/adempiere/adempiere-vue',
      icon: '/assets/img/vue-logo.png',
      color: 'rgba(0, 128, 64, 0.4)',
    },
    {
      name: 'Discord',
      desc: 'Estamos en Discord!',
      link: 'https://discord.gg/UWcyn7DEzV',
      icon: '/assets/img/discord-logo.png',
      color: 'rgba(80, 60, 0, 0.4)',
    },
  ];

  // Obtener artículos dinámicamente de Fumadocs
  const allPages = source.getPages();
  // Tomar los últimos 8 artículos (puedes ajustar el número)
  const dynamicArticles = allPages
    .filter(page => !page.url.endsWith('index')) // Omitir índices de carpeta si se desea
    .slice(0, 8);

  return (
    <main className="flex flex-col min-h-screen bg-[#0a0c10]">
      {/* Hero Section */}
      <div 
        className="relative h-[40vh] flex flex-col items-center justify-center text-white overflow-hidden"
        style={{
          backgroundImage: 'url("/background.jpg")',
          backgroundPosition: 'center',
          backgroundSize: 'cover',
          backgroundAttachment: 'fixed',
        }}
      >
        <div className="absolute inset-0 bg-black/40 backdrop-blur-[1px]" />
      </div>

      {/* Main Content Layout */}
      <div className="max-w-7xl mx-auto px-4 py-12 w-full">
        <div className="flex flex-col lg:flex-row gap-12">
          
          {/* Main Column (Left) */}
          <div className="flex-1 order-2 lg:order-1">
            
            {/* Proyectos Destacados */}
            <section className="mb-16">
              <div className="flex items-center gap-4 mb-8">
                <div className="h-8 w-1.5 bg-fd-primary rounded-full"></div>
                <h2 className="text-3xl font-black text-white tracking-tight">Proyectos Destacados</h2>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {projects.map((project) => (
                  <a
                    key={project.name}
                    href={project.link}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="group p-6 rounded-2xl border border-white/5 transition-all hover:border-fd-primary/40 flex flex-col items-center text-center relative overflow-hidden bg-white/[0.02] h-full"
                    style={{ backgroundColor: project.color }}
                  >
                    <div className="relative w-16 h-16 mb-4 transition-transform group-hover:scale-110">
                      <Image src={project.icon} alt={project.name} fill className="object-contain" />
                    </div>
                    <div>
                      <h3 className="text-lg font-bold text-white mb-1">{project.name}</h3>
                      <p className="text-white/50 text-sm line-clamp-2">{project.desc}</p>
                    </div>
                  </a>
                ))}
              </div>
            </section>

            {/* Listado de Artículos Dinámico */}
            <section>
              <div className="space-y-6">
                {dynamicArticles.map((page) => (
                  <article 
                    key={page.url}
                    className="p-6 rounded-2xl border border-white/5 bg-white/[0.01] hover:bg-white/[0.03] transition-all group"
                  >
                    <Link href={page.url}>
                      <div className="flex justify-between items-start mb-3">
                        <span className="px-3 py-1 rounded-full bg-fd-primary/10 text-fd-primary text-[10px] font-bold uppercase tracking-wider">
                          {page.url.split('/')[2] || 'Documentación'}
                        </span>
                        <div className="flex items-center gap-2 text-white/30 text-xs">
                          <FaCalendarAlt />
                          Actualizado
                        </div>
                      </div>
                      <h3 className="text-2xl font-bold text-white mb-3 group-hover:text-fd-primary transition-colors">
                        {page.data.title}
                      </h3>
                      <p className="text-white/60 leading-relaxed mb-4 line-clamp-2 text-sm">
                        {page.data.description || 'Consulta la documentación oficial sobre este proceso de ADempiere.'}
                      </p>
                      <div className="flex items-center gap-2 text-fd-primary font-bold text-sm">
                        Explorar guía <FaChevronRight className="text-xs" />
                      </div>
                    </Link>
                  </article>
                ))}
              </div>

              {/* Botón ver más */}
              <div className="mt-10 text-center">
                <Link 
                  href="/docs" 
                  className="inline-flex items-center gap-3 px-8 py-3 rounded-full border border-white/10 text-white font-bold hover:bg-white/5 transition-all"
                >
                  Ver toda la documentación
                </Link>
              </div>
            </section>
          </div>

          {/* Sidebar Column (Right) */}
          <div className="w-full lg:w-80 shrink-0 order-1 lg:order-2">
            <div className="sticky top-24">
              <BloggerInfo />
              
              {/* Widget adicional: Categorías rápidas */}
              <div className="mt-8 p-6 rounded-2xl border border-white/5 bg-white/[0.02]">
                <h4 className="text-white font-bold mb-4 flex items-center gap-2">
                  <FaTag className="text-fd-primary text-sm" />
                  Categorías
                </h4>
                <div className="flex flex-wrap gap-2">
                  {['Producto', 'Técnico', 'Finanzas', 'Logística', 'Ventas'].map(cat => (
                    <span key={cat} className="px-3 py-1 rounded-lg bg-white/5 text-white/60 text-xs hover:bg-fd-primary/20 hover:text-white cursor-pointer transition-all">
                      {cat}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

      {/* Footer */}
      <footer className="mt-auto py-12 border-t border-white/5 bg-black/40">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p className="text-white/60 text-lg mb-4">
            <a href="https://erpya.com" target="_blank" rel="noopener noreferrer" className="hover:text-fd-primary transition-colors">
              ERP Consultores y Asociados, C.A.
            </a>
            <span className="mx-3 opacity-30">|</span>
            <Link href="/about" className="hover:text-fd-primary transition-colors">
              Nosotros
            </Link>
          </p>
          <div className="h-px w-16 bg-white/10 mx-auto mb-6"></div>
          <p className="text-white/30 text-xs uppercase tracking-[0.25em]">
            Copyright © 2022-present ERP Consultores y Asociados, C.A.
          </p>
        </div>
      </footer>
    </main>
  );
}
