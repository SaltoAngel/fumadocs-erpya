import Link from 'next/link';
import Image from 'next/image';

export default function HomePage() {
  const projects = [
    {
      name: 'Liberación de ADempiere 3.9.4',
      desc: 'La versión 3.9.4 ya está disponible',
      link: 'https://github.com/adempiere/adempiere/releases/tag/3.9.4',
      icon: '/logo.png',
    },
    {
      name: 'Nueva Interfaz para ADempiere',
      desc: 'Completamente desarrollada con Vue JS',
      link: 'https://github.com/adempiere/adempiere-vue',
      icon: '/assets/img/vue-logo.png',
    },
    {
      name: 'Discord',
      desc: 'Estamos en Discord!',
      link: 'https://discord.gg/UWcyn7DEzV',
      icon: '/assets/img/discord-logo.png',
    },
  ];

  return (
    <main className="flex flex-col min-h-screen">
      {/* Hero Section */}
      <div 
        className="relative h-[60vh] flex flex-col items-center justify-center text-white overflow-hidden"
        style={{
          backgroundImage: 'url("/background.jpg")',
          backgroundPosition: 'center',
          backgroundSize: 'cover',
          backgroundAttachment: 'fixed',
        }}
      >
        <div className="absolute inset-0 hero-background opacity-80" />
        <div className="relative z-10 text-center px-4">
          <Image
            src="/logo.svg"
            alt="Logo"
            width={150}
            height={150}
            className="mx-auto mb-6 drop-shadow-2xl"
          />
          <h1 className="text-4xl md:text-6xl font-bold tracking-tight mb-4 drop-shadow-lg">
            ERPyA
          </h1>
          <p className="text-xl md:text-2xl max-w-2xl mx-auto opacity-90 drop-shadow-md">
            Documentación Oficial de ERP Consultores y Asociados, CA
          </p>
          <div className="mt-10">
            <Link
              href="/docs"
              className="bg-fd-primary text-white px-8 py-3 rounded-full font-semibold hover:opacity-90 transition-opacity"
            >
              Comenzar lectura
            </Link>
          </div>
        </div>
      </div>

      {/* Projects Section */}
      <div className="max-w-7xl mx-auto px-4 py-16 w-full">
        <h2 className="text-3xl font-bold mb-10 text-center">Novedades y Enlaces</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {projects.map((project) => (
            <a
              key={project.name}
              href={project.link}
              target="_blank"
              rel="noopener noreferrer"
              className="p-6 rounded-2xl border bg-fd-card hover:shadow-lg transition-shadow flex flex-col items-center text-center"
            >
              <div className="mb-4 relative w-16 h-16">
                <Image
                  src={project.icon}
                  alt={project.name}
                  fill
                  sizes="64px"
                  className="object-contain"
                />
              </div>
              <h3 className="text-xl font-bold mb-2">{project.name}</h3>
              <p className="text-fd-muted-foreground">{project.desc}</p>
            </a>
          ))}
        </div>
      </div>

      {/* Footer */}
      <footer className="mt-auto py-10 border-t bg-fd-muted/50">
        <div className="max-w-7xl mx-auto px-4 text-center text-fd-muted-foreground">
          <p>
            <a href="https://erpya.com" className="hover:underline">ERP Consultores y Asociados, C.A.</a>
            {' | '}
            <Link href="/docs/about" className="hover:underline">Nosotros</Link>
          </p>
          <p className="mt-2 text-sm">
            Copyright © 2022-present ERP Consultores y Asociados, C.A.
          </p>
        </div>
      </footer>
    </main>
  );
}
