import Link from 'next/link';
import Image from 'next/image';
import { BloggerInfo } from '@/components/BloggerInfo';
import { source } from '@/lib/source';
import { FaCalendarAlt, FaArrowRight, FaRocket, FaCode, FaDiscord } from 'react-icons/fa';
import { FaArrowUpRightFromSquare } from 'react-icons/fa6';

const projects = [
  {
    name: 'ADempiere 3.9.4',
    desc: 'Estabilidad y mejoras de rendimiento para el motor ERP principal.',
    link: 'https://github.com/adempiere/adempiere/releases/tag/3.9.4',
    icon: '/logo.png',
    accentColor: 'rgba(220, 38, 38, 0.15)',
    borderColor: 'rgba(220, 38, 38, 0.25)',
    iconBg: 'rgba(220, 38, 38, 0.2)',
    iconColor: '#f87171',
    Tag: FaRocket,
  },
  {
    name: 'Nueva Interfaz Vue',
    desc: 'Interfaz moderna y revolucionaria construida sobre Vue.js 3.',
    link: 'https://github.com/adempiere/adempiere-vue',
    icon: '/assets/img/vue-logo.png',
    accentColor: 'rgba(192, 193, 255, 0.08)',
    borderColor: 'rgba(192, 193, 255, 0.2)',
    iconBg: 'rgba(192, 193, 255, 0.15)',
    iconColor: '#c0c1ff',
    Tag: FaCode,
  },
  {
    name: 'Comunidad Discord',
    desc: 'Únete a más de 2000 desarrolladores y consultores de todo el mundo.',
    link: 'https://discord.gg/UWcyn7DEzV',
    icon: '/assets/img/discord-logo.png',
    accentColor: 'rgba(88, 101, 242, 0.12)',
    borderColor: 'rgba(88, 101, 242, 0.25)',
    iconBg: 'rgba(88, 101, 242, 0.2)',
    iconColor: '#818cf8',
    Tag: FaDiscord,
  },
];

const categories = [
  'Manufactura', 'Finanzas', 'Logística', 'CRM',
  'RRHH', 'E-Commerce', 'Open Source', 'Vue Interface',
];

export default function HomePage() {
  const allPages = source.getPages();
  const dynamicArticles = allPages
    .filter(page => !page.url.endsWith('index'))
    // Ordenar por fecha (descendente: más reciente primero)
    .sort((a, b) => {
      const dateA = new Date((a.data as any).date || 0).getTime();
      const dateB = new Date((b.data as any).date || 0).getTime();
      return dateB - dateA;
    })
    .slice(0, 6);

  return (
    <main className="flex flex-col min-h-screen bg-fd-background text-fd-foreground">

      {/* ── Hero ──────────────────────────────────────────────── */}
      <section className="relative w-full h-[480px] flex items-center justify-center overflow-hidden">
        {/* BG Image */}
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{ backgroundImage: 'url("/background.jpg")' }}
        />
        {/* Overlay - Se ajusta según el tema */}
        <div className="absolute inset-0 bg-fd-background/60 dark:bg-black/65 backdrop-blur-[2px]" />

        {/* Content */}
        <div className="relative z-10 text-center px-6 max-w-4xl">
          <span
            className="inline-block mb-4 text-xs font-bold tracking-[0.25em] uppercase text-fd-primary"
          >
            SOLUCIONES ERP DE NIVEL EMPRESARIAL
          </span>
          <h1 className="text-5xl md:text-6xl font-black mb-6 leading-tight tracking-tight text-fd-foreground">
            ERPyA
          </h1>
          <p className="text-lg mb-10 max-w-2xl mx-auto leading-relaxed text-fd-muted-foreground">
            Estrategias modernas de implementación ERP en código abierto.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <a
              href="https://discord.gg/UWcyn7DEzV"
              target="_blank"
              rel="noopener noreferrer"
              className="px-8 py-3 rounded-xl font-bold text-sm tracking-wide transition-all hover:bg-fd-primary/10 border border-fd-primary/20 bg-fd-background/40 backdrop-blur-xl"
            >
              UNIRSE A DISCORD
            </a>
          </div>
        </div>
      </section>

      {/* ── Body ──────────────────────────────────────────────── */}
      <div className="max-w-7xl mx-auto w-full px-6 py-16 flex flex-col md:flex-row gap-12">

        {/* ── Main Column ───────────────────────────────────────── */}
        <div className="flex-1 space-y-16">

          {/* Proyectos Destacados */}
          <section>
            <div className="flex items-center justify-between mb-8">
              <h2 className="text-3xl font-black tracking-tight">
                Proyectos Destacados
              </h2>
              <div className="h-px flex-1 ml-6 bg-fd-border" />
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
              {projects.map((project) => (
                <a
                  key={project.name}
                  href={project.link}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="group p-6 rounded-xl transition-all duration-300 hover:-translate-y-2 flex flex-col bg-fd-card border border-fd-border backdrop-blur-xl hover:border-fd-primary/30"
                >
                  <div
                    className="w-12 h-12 rounded-lg flex items-center justify-center mb-4 relative"
                    style={{ background: project.iconBg }}
                  >
                    <div className="relative w-6 h-6">
                      <Image src={project.icon} alt={project.name} fill className="object-contain" />
                    </div>
                  </div>
                  <h3 className="text-lg font-bold mb-2">{project.name}</h3>
                  <p className="text-sm text-fd-muted-foreground leading-relaxed flex-1">{project.desc}</p>
                  <div
                    className="mt-4 flex items-center gap-1 text-xs font-bold text-fd-primary"
                  >
                    Ver proyecto <FaArrowUpRightFromSquare className="text-[10px]" />
                  </div>
                </a>
              ))}
            </div>
          </section>

          {/* Artículos Recientes */}
          <section>
            <div className="flex items-center justify-between mb-8">
              <h2 className="text-3xl font-black tracking-tight">
                Artículos Recientes
              </h2>
              <div className="h-px flex-1 ml-6 bg-fd-border" />
            </div>

            <div className="space-y-4">
              {dynamicArticles.map((page) => {
                const section = page.url.split('/')[2] || 'docs';
                return (
                  <article
                    key={page.url}
                    className="group p-6 rounded-xl transition-all duration-300 hover:bg-fd-accent/50 bg-fd-card border border-fd-border"
                  >
                    <Link href={page.url} className="flex flex-col sm:flex-row gap-5">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-3">
                          <span
                            className="px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider bg-fd-primary/10 text-fd-primary"
                          >
                            {section.replace(/-/g, ' ')}
                          </span>
                          <div className="flex items-center gap-1.5 text-fd-muted-foreground text-xs">
                            <FaCalendarAlt className="text-[10px]" />
                            <span>Actualizado</span>
                          </div>
                        </div>
                        <h3 className="text-xl font-bold mb-2 group-hover:text-fd-primary transition-colors leading-snug">
                          {page.data.title}
                        </h3>
                        <p className="text-fd-muted-foreground text-sm leading-relaxed line-clamp-2 mb-4">
                          {(page.data as any).description || 'Consulta la documentación oficial sobre este proceso de ADempiere ERP.'}
                        </p>
                        <div className="flex items-center gap-1.5 text-fd-primary text-xs font-bold group-hover:gap-3 transition-all">
                          Explorar guía <FaArrowRight className="text-[10px]" />
                        </div>
                      </div>
                    </Link>
                  </article>
                );
              })}
            </div>

            <div className="mt-10 text-center">
              <Link
                href="/docs"
                className="inline-flex items-center gap-3 px-8 py-3 rounded-full font-bold text-sm transition-all hover:bg-fd-accent border border-fd-border"
              >
                Ver toda la documentación <FaArrowRight className="text-xs" />
              </Link>
            </div>
          </section>
        </div>

        {/* ── Sidebar ───────────────────────────────────────────── */}
        <aside className="w-full md:w-80 shrink-0 space-y-6">
          <div className="sticky top-20 space-y-6">

            <BloggerInfo />

            {/* Categories */}
            <div
              className="p-6 rounded-xl bg-fd-card border border-fd-border"
            >
              <h4
                className="text-xs font-bold uppercase tracking-[0.2em] mb-5 pb-3 text-fd-muted-foreground border-b border-fd-border"
              >
                CATEGORÍAS
              </h4>
              <div className="flex flex-wrap gap-2">
                {categories.map((cat) => (
                  <span
                    key={cat}
                    className="category-tag px-3 py-1.5 rounded-full text-xs font-bold uppercase tracking-wider cursor-pointer transition-all"
                  >
                    {cat}
                  </span>
                ))}
              </div>
            </div>

            {/* Latest Update Widget */}
            <div
              className="p-6 rounded-xl bg-fd-primary/5 border border-fd-primary/20"
            >
              <div className="flex items-center gap-2 mb-4 text-fd-primary">
                <FaRocket className="text-sm" />
                <span className="text-xs font-bold uppercase tracking-[0.15em]">ÚLTIMA NOVEDAD</span>
              </div>
              <p className="font-bold text-sm mb-2 leading-snug">
                ¡ADempiere 3.9.4 ya está disponible en producción!
              </p>
              <p className="text-fd-muted-foreground text-xs leading-relaxed mb-4">
                Descarga la última versión y disfruta del rendimiento mejorado en el motor financiero principal.
              </p>
              <a
                href="https://github.com/adempiere/adempiere/releases/tag/3.9.4"
                target="_blank"
                rel="noopener noreferrer"
                className="block w-full py-2 rounded-lg text-center text-xs font-bold uppercase tracking-wider transition-all hover:opacity-90 bg-fd-primary text-fd-primary-foreground"
              >
                VER NOTAS DE VERSIÓN
              </a>
            </div>

          </div>
        </aside>
      </div>

      {/* ── Footer ────────────────────────────────────────────── */}
      <footer
        className="mt-auto py-12 px-6 border-t border-fd-border bg-fd-muted/30"
      >
        <div className="max-w-7xl mx-auto flex flex-col items-center gap-5 text-center">
          <h2 className="text-xl font-black tracking-tight">ERPyA Hub</h2>
          <div className="flex flex-wrap justify-center gap-8">
            {[
              { label: 'Política de Privacidad', href: '/docs/about/services/erpplus/privacy-policy-es' },
              { label: 'Términos de Servicio', href: '/docs/about/services/erpplus/terms-of-service-es' },
              { label: 'GitHub', href: 'https://github.com/adempiere' },
              { label: 'Contacto', href: 'https://erpya.com' },
              { label: 'Nosotros', href: '/docs/about' },
            ].map((link) => (
              <Link
                key={link.label}
                href={link.href}
                className="text-sm transition-colors hover:text-fd-primary text-fd-muted-foreground"
              >
                {link.label}
              </Link>
            ))}
          </div>
          <p className="text-xs uppercase tracking-[0.25em] text-fd-muted-foreground/50">
            © 2022-present ERP Consultores y Asociados, C.A. Todos los derechos reservados.
          </p>
        </div>
      </footer>

    </main>
  );
}
