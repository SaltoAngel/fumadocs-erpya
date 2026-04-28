import Link from 'next/link';
import Image from 'next/image';

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
      color: 'rgba(128, 40, 0, 0.4)',
    },
    {
      name: 'Discord',
      desc: 'Estamos en Discord!',
      link: 'https://discord.gg/UWcyn7DEzV',
      icon: '/assets/img/discord-logo.png',
      color: 'rgba(80, 60, 0, 0.4)',
    },
  ];

  return (
    <main className="flex flex-col min-h-screen bg-[#0a0c10]">
      {/* Hero Section */}
      <div 
        className="relative h-[70vh] flex flex-col items-center justify-center text-white overflow-hidden"
        style={{
          backgroundImage: 'url("/background.jpg")',
          backgroundPosition: 'center',
          backgroundSize: 'cover',
          backgroundAttachment: 'fixed',
        }}
      >
        <div className="absolute inset-0 hero-background opacity-50" />
      </div>

      {/* Projects Section */}
      <div className="max-w-7xl mx-auto px-4 py-20 w-full">
        <h2 className="text-3xl font-bold mb-12 text-center tracking-tight text-white">Novedades y Enlaces</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {projects.map((project) => (
            <a
              key={project.name}
              href={project.link}
              target="_blank"
              rel="noopener noreferrer"
              className="group p-8 rounded-2xl border border-white/5 transition-all hover:border-fd-primary/30 flex flex-col items-center text-center relative overflow-hidden"
              style={{ backgroundColor: project.color }}
            >
              <div className="mb-6 relative w-16 h-16 transition-transform group-hover:scale-110">
                <Image
                  src={project.icon}
                  alt={project.name}
                  fill
                  sizes="64px"
                  className="object-contain"
                />
              </div>
              <h3 className="text-xl font-bold mb-3 text-white">{project.name}</h3>
              <p className="text-white/70 text-sm leading-relaxed">{project.desc}</p>
              <div className="absolute inset-0 bg-white/5 opacity-0 group-hover:opacity-100 transition-opacity" />
            </a>
          ))}
        </div>
      </div>

      {/* Footer */}
      <footer className="mt-auto py-12 border-t border-white/5 bg-black/40">
        <div className="max-w-7xl mx-auto px-4 text-center text-white/50">
          <p className="text-lg">
            <a href="https://erpya.com" className="hover:text-fd-primary transition-colors">ERP Consultores y Asociados, C.A.</a>
            {' | '}
            <Link href="/docs/about" className="hover:text-fd-primary transition-colors">Nosotros</Link>
          </p>
          <p className="mt-4 text-xs uppercase tracking-[0.2em]">
            Copyright © 2022-present ERP Consultores y Asociados, C.A.
          </p>
        </div>
      </footer>
    </main>
  );
}
