import Link from 'next/link';
import Image from 'next/image';
import { BloggerInfo } from '@/components/BloggerInfo';
import { TechStackOrbit } from '@/components/TechStackOrbit';
import { source } from '@/lib/source';
import { FaCalendarAlt, FaArrowRight, FaRocket, FaCode, FaDiscord } from 'react-icons/fa';
import { FaArrowUpRightFromSquare } from 'react-icons/fa6';
import { getServerSession } from "next-auth/next";
import { authOptions } from "@/lib/auth";

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
  },
];

export default async function HomePage() {
  const session = await getServerSession(authOptions);
  const userRoles = (session?.user as any)?.roles || [];

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

  // --- Lógica para encontrar la ÚLTIMA VERSIÓN ---
  const updatePages = allPages.filter(p => p.url.includes('/downloads/updates/'));
  let latestUpdate = null;

  if (updatePages.length > 0) {
    const candidate = updatePages.reduce((prev, curr) => {
      const getVer = (url: string) => {
        const matches = url.match(/(\d+\.\d+\.\d+)/g);
        if (!matches) return [0, 0, 0];
        return matches[matches.length - 1].split('.').map(Number);
      };
      const vPrev = getVer(prev.url);
      const vCurr = getVer(curr.url);
      for (let i = 0; i < 3; i++) {
        if (vCurr[i] > vPrev[i]) return curr;
        if (vCurr[i] < vPrev[i]) return prev;
      }
      return prev;
    });

    // VERIFICAR PERMISOS para este candidato
    const pathParts = candidate.url.split('/').filter(Boolean); // ["docs", "downloads", "updates", ...]
    const requiredRole = pathParts.slice(0, 3).join(':'); // "docs:downloads:updates"
    
    const hasPermission = userRoles.includes(requiredRole) || userRoles.includes('docs');
    
    if (hasPermission) {
      latestUpdate = candidate;
    }
  }

  // --- Lógica para encontrar los DOCUMENTOS MÁS RECIENTES (Novedades) ---
  const checkPageAccess = (page: any, roles: string[]) => {
    const explicitRole = (page.data as any).role;
    if (explicitRole === 'public') return true;
    if (roles.includes('admin')) return true;
    if (explicitRole && roles.includes(explicitRole)) return true;

    const pathParts = page.url.split('/').filter(Boolean);
    const possibleRoles: string[] = ["docs"];
    let currentPath = "docs";
    for (const part of pathParts) {
      if (part === 'docs') continue;
      currentPath += `:${part}`;
      possibleRoles.push(currentPath);
    }

    return possibleRoles.some((pathRole: string) => roles.includes(pathRole));
  };

  // Helper de icono de página
  const getPageIcon = (title: string, url: string) => {
    const t = (title + ' ' + url).toLowerCase();
    if (t.includes('ia') || t.includes('inteligencia') || t.includes('gpt') || t.includes('openai') || t.includes('automatiz')) {
      return (
        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
        </svg>
      );
    }
    if (t.includes('seniat') || t.includes('fiscal') || t.includes('tasa') || t.includes('bcv') || t.includes('contable') || t.includes('precio') || t.includes('moneda') || t.includes('caja') || t.includes('pago')) {
      return (
        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M12 16v1M4.44 5.56l14.88 14.88" />
        </svg>
      );
    }
    if (t.includes('docker') || t.includes('infraestructura') || t.includes('kubernetes') || t.includes('k8s') || t.includes('servidor') || t.includes('cloud') || t.includes('descarga') || t.includes('binar')) {
      return (
        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
        </svg>
      );
    }
    if (t.includes('asistencia') || t.includes('human') || t.includes('usuario') || t.includes('empleado') || t.includes('socio') || t.includes('partner') || t.includes('perfil') || t.includes('nómina')) {
      return (
        <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
        </svg>
      );
    }
    return (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
      </svg>
    );
  };

  // Helper de badges y colores dinámicos basados en la sección
  const getSectionBadge = (url: string) => {
    const parts = url.split('/').filter(Boolean);
    if (parts.length <= 1) {
      return { 
        badge: "Documentación", 
        badgeStyle: "bg-zinc-500/10 text-zinc-400 border-zinc-500/20" 
      };
    }
    
    const category = parts[1]; // e.g. "about", "product", "downloads", "basic-rules", etc.
    const subcategory = parts[2]; // e.g. "updates"

    if (category === 'about') {
      return { 
        badge: "Nosotros", 
        badgeStyle: "bg-purple-500/10 text-purple-400 border-purple-500/20" 
      };
    }
    if (category === 'product') {
      return { 
        badge: "Producto", 
        badgeStyle: "bg-indigo-500/10 text-indigo-400 border-indigo-500/20" 
      };
    }
    if (category === 'downloads') {
      if (subcategory === 'updates') {
        return { 
          badge: "Versiones", 
          badgeStyle: "bg-blue-500/10 text-blue-400 border-blue-500/20" 
        };
      }
      return { 
        badge: "Descargas", 
        badgeStyle: "bg-cyan-500/10 text-cyan-400 border-cyan-500/20" 
      };
    }
    if (category === 'basic-rules') {
      return { 
        badge: "Guía Básica", 
        badgeStyle: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" 
      };
    }
    if (category === 'master-data') {
      return { 
        badge: "Datos Maestros", 
        badgeStyle: "bg-amber-500/10 text-amber-400 border-amber-500/20" 
      };
    }
    if (category === 'devices') {
      return { 
        badge: "Dispositivos", 
        badgeStyle: "bg-rose-500/10 text-rose-400 border-rose-500/20" 
      };
    }
    if (category === 'community') {
      return { 
        badge: "Comunidad", 
        badgeStyle: "bg-teal-500/10 text-teal-400 border-teal-500/20" 
      };
    }
    if (category.endsWith('-management')) {
      return { 
        badge: "Gestión", 
        badgeStyle: "bg-fuchsia-500/10 text-fuchsia-400 border-fuchsia-500/20" 
      };
    }
    
    // Fallback
    const formattedName = category.charAt(0).toUpperCase() + category.slice(1).replace(/-/g, ' ');
    return { 
      badge: formattedName, 
      badgeStyle: "bg-zinc-500/10 text-zinc-400 border-zinc-500/20" 
    };
  };

  const validPages = allPages.filter(page => !page.url.endsWith('index'));

  const sortedPages = [...validPages].sort((a, b) => {
    const dateA = new Date((a.data as any).date || 0).getTime();
    const dateB = new Date((b.data as any).date || 0).getTime();
    return dateB - dateA;
  });

  const privateAccessiblePages = sortedPages.filter(page => {
    const explicitRole = (page.data as any).role;
    const isPrivate = explicitRole && explicitRole !== 'public';
    return isPrivate && checkPageAccess(page, userRoles);
  });

  const publicPages = sortedPages.filter(page => {
    const explicitRole = (page.data as any).role;
    return !explicitRole || explicitRole === 'public';
  });

  // Tomar los 4 documentos prioritarios finales
  const finalDocs = [
    ...privateAccessiblePages.slice(0, 4),
    ...publicPages.slice(0, 4 - Math.min(4, privateAccessiblePages.length))
  ].slice(0, 4);

  // Cargar las descripciones de los documentos de forma asíncrona y paralela
  const novedadesDocs = await Promise.all(
    finalDocs.map(async (page) => {
      let desc = page.data.description || "";
      
      // Si el documento no tiene descripción explícita, extraemos las primeras líneas
      if (!desc && 'getText' in page.data) {
        try {
          const rawText = await page.data.getText('processed');
          // Limpiar el contenido de títulos, marcas de markdown, bloques de código, etc.
          const cleanText = rawText
            .replace(/^#+ .*/gm, '') // eliminar títulos h1, h2, h3
            .replace(/```[\s\S]*?```/g, '') // eliminar bloques de código completo
            .replace(/[\r\n]+/g, ' ') // convertir saltos de línea a espacios sencillos
            .replace(/\s+/g, ' ') // colapsar múltiples espacios contiguos
            .trim();
          
          if (cleanText) {
            // Cortamos a un tamaño elegante para la tarjeta (135 caracteres) más puntos suspensivos
            desc = cleanText.length > 135 ? cleanText.substring(0, 135) + '...' : cleanText;
          }
        } catch (err) {
          console.error("Error al leer texto del documento para Novedades:", err);
        }
      }

      if (!desc) {
        desc = "Sin descripción disponible.";
      }

      // Obtener el badge dinámico basado en la ruta de su categoría
      const { badge, badgeStyle } = getSectionBadge(page.url);

      return {
        title: page.data.title,
        desc,
        url: page.url,
        badge,
        badgeStyle,
      };
    })
  );

  return (
    <main 
      className="flex flex-col min-h-screen bg-[#020716] text-zinc-100 font-sans relative overflow-hidden mt-[-60px]"
      style={{
        backgroundImage: `
          radial-gradient(circle at 50% -20%, rgba(29, 78, 216, 0.38), transparent 60%),
          radial-gradient(circle at 80% 40%, rgba(30, 64, 175, 0.22), transparent 50%),
          radial-gradient(circle at 10% 70%, rgba(30, 58, 138, 0.15), transparent 45%)
        `
      }}
    >
      {/* Background Linear Mesh Grid */}
      <div 
        className="absolute inset-0 pointer-events-none"
        style={{
          backgroundImage: `
            linear-gradient(to right, rgba(255, 255, 255, 0.04) 1px, transparent 1px),
            linear-gradient(to bottom, rgba(255, 255, 255, 0.04) 1px, transparent 1px)
          `,
          backgroundSize: '48px 48px',
          maskImage: 'radial-gradient(circle at 50% 50%, white 20%, transparent 80%)',
          WebkitMaskImage: 'radial-gradient(circle at 50% 50%, white 20%, transparent 80%)',
          opacity: 0.85
        }}
      />

      {/* Hero Section */}
      <section className="relative w-full px-6 pt-28 pb-16 sm:px-8 lg:pt-36 lg:pb-24 max-w-7xl mx-auto z-10">
        <div className="grid grid-cols-1 lg:grid-cols-[minmax(0,1fr)_460px] gap-12 lg:gap-16 items-center">
          
          {/* Left Hero Column */}
          <div className="max-w-2xl">
            {/* Country/Region Badge */}
            <div className="mb-6 inline-flex items-center gap-2 rounded-md border border-white/[0.15] bg-white/[0.06] px-3.5 py-1.5 text-xs font-semibold text-white/[0.88] shadow-[0_14px_38px_rgba(0,0,0,0.14)] backdrop-blur-md">
              <span className="w-1.5 h-1.5 rounded-full bg-[#1AAAD4] animate-pulse" />
              Venezuela · Latinoamérica
            </div>

            {/* Glowing Big Headline */}
            <h1 className="mb-6 text-[clamp(32px,5.5vw,60px)] font-extrabold leading-[1.04] tracking-tight text-white">
              Tecnología empresarial. <br />
              <span className="bg-gradient-to-r from-[#1AAAD4] to-[#5BC8E5] bg-clip-text text-transparent">
                Implementada por expertos.
              </span>
            </h1>

            {/* Subtext description */}
            <p className="mb-8 text-base sm:text-lg leading-relaxed text-zinc-300 max-w-xl">
              ERP, CRM, BI e Infraestructura — implementados por expertos con más de 15 años de experiencia en Venezuela y Latinoamérica.
            </p>

            {/* CTAs */}
            <div className="mb-10 flex flex-wrap gap-4">
              <a 
                href="/docs" 
                className="inline-flex items-center gap-2 rounded-lg bg-[#1AAAD4] px-6 py-3 text-sm font-extrabold text-[#0D2167] shadow-[0_0_20px_rgba(26,170,212,0.3)] transition-all duration-300 hover:bg-[#24c0eb] hover:shadow-[0_0_30px_rgba(26,170,212,0.55)] hover:-translate-y-0.5"
              >
                Ver Documentación
                <FaArrowRight className="text-xs" />
              </a>
              <Link 
                href="/docs/about" 
                className="inline-flex items-center gap-2 rounded-lg border border-white/[0.2] px-5 py-3 text-sm font-semibold text-white/[0.88] transition-all duration-300 hover:bg-white/[0.08] hover:-translate-y-0.5"
              >
                Conócenos
              </Link>
            </div>

            {/* Features checkmarks list */}
            <div className="flex flex-wrap gap-x-6 gap-y-3 text-sm text-zinc-400">
              <span className="flex items-center gap-2">
                <span className="w-4 h-4 rounded-full bg-[#1AAAD4]/15 text-[#1AAAD4] flex items-center justify-center text-[10px] font-bold">✓</span>
                Implementación ERP
              </span>
              <span className="flex items-center gap-2">
                <span className="w-4 h-4 rounded-full bg-[#1AAAD4]/15 text-[#1AAAD4] flex items-center justify-center text-[10px] font-bold">✓</span>
                BI y analítica
              </span>
              <span className="flex items-center gap-2">
                <span className="w-4 h-4 rounded-full bg-[#1AAAD4]/15 text-[#1AAAD4] flex items-center justify-center text-[10px] font-bold">✓</span>
                Infraestructura cloud
              </span>
            </div>
          </div>

          {/* Right Hero Column: Technical Orbit stack */}
          <div className="w-full flex items-center justify-center">
            <TechStackOrbit />
          </div>

        </div>
      </section>

      {/* "Lo nuevo en ERPyA" Section */}
      <section id="novedades" className="border-t border-zinc-800 bg-[#040817]/60 backdrop-blur-md px-6 py-20 sm:px-8 relative z-10">
        <div className="max-w-7xl mx-auto">
          <div className="max-w-3xl mb-12">
            <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-[#1AAAD4]/20 text-[#1AAAD4] text-[11px] font-bold uppercase tracking-wider mb-3">
              NOVEDADES
            </span>
            <h2 className="text-3xl font-extrabold tracking-tight text-white mb-3">
              Lo nuevo en ERPyA
            </h2>
            <p className="text-zinc-400">
              Nuevas capacidades con IA e integraciones locales para hacer tu ERP más inteligente cada día.
            </p>
          </div>

          {/* Feature Grid */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {novedadesDocs.map((card, i) => (
              <Link 
                href={card.url}
                key={i} 
                className="relative block bg-[#090d22] border border-zinc-800/80 rounded-xl p-5 hover:border-[#1AAAD4] hover:-translate-y-1 hover:shadow-[0_12px_30px_rgba(26,170,212,0.14)] transition-all duration-300 overflow-hidden h-full flex flex-col group animate-in fade-in duration-300"
              >
                <div className="flex justify-between items-start mb-4">
                  <div className="w-10 h-10 rounded-lg bg-gradient-to-br from-[#0D2167] to-[#142d8d] text-[#1AAAD4] flex items-center justify-center">
                    {getPageIcon(card.title, card.url)}
                  </div>
                  <span className={`text-[10px] font-bold tracking-wide uppercase px-2.5 py-0.5 rounded-full border ${card.badgeStyle}`}>
                    {card.badge}
                  </span>
                </div>
                <h3 className="text-base font-bold text-white mb-2 leading-tight group-hover:text-[#1AAAD4] transition-colors line-clamp-2">
                  {card.title}
                </h3>
                <p className="text-zinc-400 text-sm leading-relaxed flex-1 mb-5 line-clamp-3">
                  {card.desc}
                </p>
                <div className="text-xs font-bold text-[#1AAAD4] flex items-center gap-1 group-hover:translate-x-1 transition-transform mt-auto">
                  Leer documento <span className="text-[10px]">→</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Statistics Section */}
      <section className="bg-[#030712] border-t border-zinc-800/80 py-16 px-6 relative z-10">
        <div className="max-w-4xl mx-auto flex flex-col md:flex-row gap-8 md:gap-0 justify-between items-center text-center">
          <div className="flex-1 w-full py-4 md:border-r border-zinc-800/60">
            <div className="text-3xl font-extrabold text-[#1AAAD4] tracking-tight">+1.200</div>
            <div className="text-xs text-zinc-400 mt-1 uppercase tracking-wider font-semibold">Artículos de Soporte</div>
          </div>
          <div className="flex-1 w-full py-4 md:border-r border-zinc-800/60">
            <div className="text-3xl font-extrabold text-[#1AAAD4] tracking-tight">+15</div>
            <div className="text-xs text-zinc-400 mt-1 uppercase tracking-wider font-semibold">Módulos ERP Documentados</div>
          </div>
          <div className="flex-1 w-full py-4 md:border-r border-zinc-800/60">
            <div className="text-3xl font-extrabold text-[#1AAAD4] tracking-tight">+50</div>
            <div className="text-xs text-zinc-400 mt-1 uppercase tracking-wider font-semibold">Guías de Configuración</div>
          </div>
          <div className="flex-1 w-full py-4">
            <div className="text-3xl font-extrabold text-[#1AAAD4] tracking-tight">20+</div>
            <div className="text-xs text-zinc-400 mt-1 uppercase tracking-wider font-semibold">Categorías de Consulta</div>
          </div>
        </div>
      </section>

      {/* Dynamic Hybrid Section: Featured Projects and Recent Articles (Desactivado) */}
      {false && (
        <section className="border-t border-zinc-800 bg-[#040817]/60 backdrop-blur-md py-20 px-6 sm:px-8 relative z-10">
          <div className="max-w-7xl mx-auto flex flex-col lg:flex-row gap-12">
            
            {/* Main left content: Projects & Articles */}
            <div className="flex-1 space-y-16">
              
              {/* Proyectos Destacados (Desactivado) */}
              {false && (
                <div id="proyectos">
                  <div className="flex items-center justify-between mb-8">
                    <h2 className="text-2xl font-black tracking-tight text-white">
                      Proyectos Destacados
                    </h2>
                    <div className="h-px flex-1 ml-6 bg-zinc-800/60" />
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    {projects.map((project) => (
                      <a
                        key={project.name}
                        href={project.link}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="group p-6 rounded-xl transition-all duration-300 hover:-translate-y-1.5 flex flex-col bg-[#090d22] border border-zinc-850 hover:border-[#1AAAD4]/30"
                      >
                        <div
                          className="w-12 h-12 rounded-lg flex items-center justify-center mb-4 relative"
                          style={{ background: project.iconBg || 'rgba(255, 255, 255, 0.05)' }}
                        >
                          <div className="relative w-6 h-6">
                            <Image src={project.icon} alt={project.name} fill className="object-contain" />
                          </div>
                        </div>
                        <h3 className="text-base font-bold text-white mb-2">{project.name}</h3>
                        <p className="text-xs text-zinc-400 leading-relaxed flex-1 mb-4">{project.desc}</p>
                        <div className="mt-auto flex items-center gap-1.5 text-xs font-bold text-[#1AAAD4]">
                          Ver proyecto <FaArrowUpRightFromSquare className="text-[10px]" />
                        </div>
                      </a>
                    ))}
                  </div>
                </div>
              )}

              {/* Artículos Recientes (Desactivado) */}
              {false && (
                <div>
                  <div className="flex items-center justify-between mb-8">
                    <h2 className="text-2xl font-black tracking-tight text-white">
                      Artículos Recientes
                    </h2>
                    <div className="h-px flex-1 ml-6 bg-zinc-800/60" />
                  </div>

                  <div className="space-y-4">
                    {dynamicArticles.map((page) => {
                      const section = page.url.split('/')[2] || 'docs';
                      return (
                        <article
                          key={page.url}
                          className="group p-6 rounded-xl transition-all duration-300 hover:bg-zinc-900/30 bg-[#090d22] border border-zinc-850"
                        >
                          <Link href={page.url} className="flex flex-col sm:flex-row gap-5">
                            <div className="flex-1">
                              <div className="flex items-center gap-3 mb-3">
                                <span className="px-2.5 py-0.5 rounded-full text-[9px] font-bold uppercase tracking-wider bg-[#1AAAD4]/10 text-[#1AAAD4] border border-[#1AAAD4]/20">
                                  {section.replace(/-/g, ' ')}
                                </span>
                                <div className="flex items-center gap-1.5 text-zinc-500 text-xs">
                                  <FaCalendarAlt className="text-[10px]" />
                                  <span>Actualizado</span>
                                </div>
                              </div>
                              <h3 className="text-lg font-bold text-white mb-2 group-hover:text-[#1AAAD4] transition-colors leading-snug">
                                {page.data.title}
                              </h3>
                              <p className="text-zinc-400 text-xs leading-relaxed line-clamp-2 mb-4">
                                {(page.data as any).description || 'Consulta la documentación oficial sobre este proceso de ADempiere ERP.'}
                              </p>
                              <div className="flex items-center gap-1.5 text-[#1AAAD4] text-xs font-bold group-hover:gap-3 transition-all">
                                Explororar guía <FaArrowRight className="text-[10px]" />
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
                      className="inline-flex items-center gap-3 px-8 py-3 rounded-full font-bold text-xs transition-all hover:bg-zinc-850 border border-zinc-850 text-zinc-300 hover:text-white"
                    >
                      Ver toda la documentación <FaArrowRight className="text-xs" />
                    </Link>
                  </div>
                </div>
              )}

            </div>

            {/* Right Sidebar */}
            <aside className="w-full lg:w-80 shrink-0 space-y-6">
              <div className="sticky top-24 space-y-6">
                
                {/* <BloggerInfo /> */}

                {/* Dynamic Latest Update Widget */}
                {latestUpdate && (
                  <div className="p-6 rounded-xl bg-[#090d22] border border-zinc-850 hover:border-[#1AAAD4]/20 transition-all duration-300">
                    <div className="flex items-center gap-2 mb-4 text-[#1AAAD4]">
                      <FaRocket className="text-sm animate-pulse" />
                      <span className="text-[10px] font-bold uppercase tracking-[0.15em]">ÚLTIMA NOVEDAD</span>
                    </div>
                    <p className="font-bold text-sm text-white mb-2 leading-snug">
                      {(() => {
                        const matches = latestUpdate.url.match(/(\d+\.\d+\.\d+)/g);
                        if (!matches) return '¡Nueva actualización disponible!';
                        const baseVer = matches[0];
                        const patchVer = matches[matches.length - 1];
                        return `La actualización ${patchVer} de ADempiere ${baseVer} ya está disponible`;
                      })()}
                    </p>
                    <p className="text-zinc-400 text-xs leading-relaxed mb-4 line-clamp-3">
                      {latestUpdate.data.title}: {latestUpdate.data.description || 'Descubre las mejoras en esta nueva versión de ADempiere.'}
                    </p>
                    <Link
                      href={latestUpdate.url}
                      className="block w-full py-2.5 rounded-lg text-center text-xs font-bold uppercase tracking-wider transition-all hover:bg-[#24c0eb] bg-[#1AAAD4] text-[#0D2167]"
                    >
                      VER NOTAS DE VERSIÓN
                    </Link>
                  </div>
                )}

              </div>
            </aside>

          </div>
        </section>
      )}

      {/* Footer Section */}
      <footer id="contacto" className="border-t border-zinc-850 bg-[#040817] text-zinc-400 relative z-10">
        <div className="max-w-7xl mx-auto px-6 py-16">
          
          {/* Top footer row */}
          <div className="mb-12 grid gap-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
            <div className="max-w-2xl">
              <p className="text-white text-lg font-extrabold mb-1 tracking-tight">ERPyA</p>
              <h2 className="text-xl font-bold tracking-tight text-white mb-2">
                Tecnología empresarial con soporte local.
              </h2>
              <p className="text-zinc-400 text-sm leading-relaxed">
                Un ERP de clase mundial escalable para los negocios de Venezuela y Latinoamérica.
              </p>
            </div>
            
            {/* Social media links */}
            <div className="flex gap-2">
              {[
                { icon: "instagram", href: "https://instagram.com" },
                { icon: "x", href: "https://x.com" },
                { icon: "github", href: "https://github.com/adempiere" }
              ].map((soc, idx) => (
                <a
                  key={idx}
                  href={soc.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex h-9 w-9 items-center justify-center rounded-md border border-zinc-800 hover:border-[#1AAAD4] hover:bg-zinc-800/30 text-zinc-400 hover:text-white transition-all duration-300"
                >
                  {soc.icon === "instagram" && (
                    <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.051.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z" />
                    </svg>
                  )}
                  {soc.icon === "x" && (
                    <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
                    </svg>
                  )}
                  {soc.icon === "github" && (
                    <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                      <path fillRule="evenodd" d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.166 6.839 9.489.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.603-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.464-1.11-1.464-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.831.092-.646.35-1.086.636-1.336-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.646.64.699 1.026 1.592 1.026 2.683 0 3.842-2.337 4.687-4.565 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.579.688.481C19.137 20.162 22 16.418 22 12c0-5.523-4.477-10-10-10z" clipRule="evenodd" />
                    </svg>
                  )}
                </a>
              ))}
            </div>
          </div>

          {/* Middle contact info cards row */}
          <div className="grid gap-6 md:grid-cols-3 mb-12">
            
            {/* Sedes Card */}
            <div className="flex gap-4 p-6 rounded-xl border border-zinc-850 bg-[#090d22]">
              <div className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-[#1AAAD4]/10 text-[#1AAAD4]">
                <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
              <div>
                <p className="text-white font-bold text-sm mb-2">Sedes</p>
                <div className="text-xs text-zinc-400 space-y-1">
                  <p><strong className="text-zinc-300">Araure:</strong> Edo. Portuguesa</p>
                  <p><strong className="text-zinc-300">Bello Monte:</strong> Caracas</p>
                </div>
              </div>
            </div>

            {/* Email Card */}
            <div className="flex gap-4 p-6 rounded-xl border border-zinc-850 bg-[#090d22]">
              <div className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-[#1AAAD4]/10 text-[#1AAAD4]">
                <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
              </div>
              <div>
                <p className="text-white font-bold text-sm mb-2">Email</p>
                <a href="mailto:info@erpya.com" className="text-[#1AAAD4] text-xs font-semibold hover:underline block mb-1">
                  info@erpya.com
                </a>
                <p className="text-[10px] text-zinc-500">Consultas comerciales y soporte</p>
              </div>
            </div>

            {/* Phone Card */}
            <div className="flex gap-4 p-6 rounded-xl border border-zinc-850 bg-[#090d22]">
              <div className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-md bg-[#1AAAD4]/10 text-[#1AAAD4]">
                <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.94.725l.548 2.2a1 1 0 01-.321.988l-1.305.98a10.582 10.582 0 004.872 4.872l.98-1.305a1 1 0 01.988-.321l2.2.548a1 1 0 01.725.94V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
              </div>
              <div>
                <p className="text-white font-bold text-sm mb-2">Teléfonos</p>
                <div className="text-xs space-y-1 flex flex-col font-semibold">
                  <a href="tel:+582556659470" className="hover:underline text-zinc-300 hover:text-white">+58 (255) 665 94 70</a>
                  <a href="https://wa.me/584122223824" target="_blank" rel="noopener noreferrer" className="hover:underline text-green-400 hover:text-green-300">+58 412-2223824 (WhatsApp)</a>
                  <a href="tel:+584121741773" className="hover:underline text-zinc-300 hover:text-white">+58 412-1741773</a>
                </div>
              </div>
            </div>

          </div>

          {/* Bottom link columns grid */}
          <div className="hidden md:grid grid-cols-4 gap-6 border-t border-zinc-850 pt-12 pb-8 text-xs">
            <div>
              <p className="text-white font-bold mb-3">Documentación ERP</p>
              <div className="flex flex-col gap-2">
                <Link href="/docs/basic-rules" className="hover:text-white transition-colors">ADempiere Estándar</Link>
                <Link href="/docs/sales-management" className="hover:text-white transition-colors">Ventas y Compras</Link>
              </div>
            </div>
            <div>
              <p className="text-white font-bold mb-3">Localización Venezuela</p>
              <div className="flex flex-col gap-2">
                <Link href="/docs/lve" className="hover:text-white transition-colors">Impuestos y Retenciones</Link>
                <Link href="/docs/lve" className="hover:text-white transition-colors">Reglas de Facturación</Link>
              </div>
            </div>
            <div>
              <p className="text-white font-bold mb-3">Control y Finanzas</p>
              <div className="flex flex-col gap-2">
                <Link href="/docs/balance-management" className="hover:text-white transition-colors">Caja y Bancos</Link>
                <Link href="/docs/accounting-management" className="hover:text-white transition-colors">Contabilidad General</Link>
              </div>
            </div>
            <div>
              <p className="text-white font-bold mb-3">Operaciones y Descargas</p>
              <div className="flex flex-col gap-2">
                <Link href="/docs/downloads/docker" className="hover:text-white transition-colors">Instalación Docker</Link>
                <Link href="/docs/data-importation" className="hover:text-white transition-colors">Importación de Datos</Link>
              </div>
            </div>
          </div>

          {/* Final legal copyrights */}
          <div className="mt-8 pt-8 border-t border-zinc-850 flex flex-col sm:flex-row justify-between items-center gap-4 text-[11px] text-zinc-500">
            <p>© 2026 ERPyA. Todos los derechos reservados.</p>
            <span>ADempiere ERP · ERPyA</span>
          </div>

        </div>
      </footer>

      {/* Floating WhatsApp Button */}
      <a
        href="https://wa.me/584122223824"
        target="_blank"
        rel="noopener noreferrer"
        className="fixed bottom-6 right-6 z-50 flex items-center justify-center w-14 h-14 bg-[#25D366] text-white rounded-full shadow-[0_4px_15px_rgba(37,211,102,0.4)] hover:bg-[#20ba5a] hover:scale-110 transition-all duration-300 group"
        aria-label="Contactar por WhatsApp"
      >
        {/* Pulsating green ring wave */}
        <span className="absolute inset-0 rounded-full bg-[#25D366]/40 animate-ping pointer-events-none" />
        
        {/* WhatsApp Icon */}
        <svg className="w-7 h-7 relative z-10" fill="currentColor" viewBox="0 0 24 24">
          <path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946C.06 5.348 5.397.01 12.008.01c3.202.001 6.212 1.246 8.477 3.513 2.266 2.268 3.507 5.28 3.505 8.484-.004 6.657-5.34 11.997-11.953 11.997-2.005-.001-3.973-.502-5.724-1.458L0 24zm6.59-4.846c1.62.962 3.21 1.464 4.887 1.465 5.45-.001 9.887-4.441 9.889-9.896.002-2.64-1.022-5.12-2.887-6.988C16.671 1.865 14.187 1.84 12.01 1.84c-5.452 0-9.89 4.44-9.892 9.896-.001 1.815.48 3.59 1.39 5.158l-1.002 3.66 3.789-.994zM16.52 14.7c-.244-.122-1.442-.712-1.666-.794-.223-.081-.385-.122-.547.122-.162.244-.629.794-.771.957-.142.163-.284.183-.528.061-.244-.122-1.03-.38-1.962-1.213-.725-.647-1.215-1.447-1.357-1.691-.142-.244-.015-.376.107-.497.11-.11.244-.285.365-.427.122-.142.162-.244.244-.407.081-.163.041-.305-.02-.427-.061-.122-.547-1.32-.75-1.812-.197-.475-.397-.41-.547-.417-.14-.007-.305-.007-.468-.007a.9.9 0 00-.65.305c-.223.244-.853.834-.853 2.034s.874 2.36 1.037 2.583c.163.224 1.72 2.625 4.168 3.682.582.252 1.036.402 1.39.515.585.186 1.117.16 1.537.098.467-.069 1.442-.59 1.646-1.16.204-.57.204-1.058.142-1.16-.062-.102-.224-.163-.468-.285z" />
        </svg>
      </a>

    </main>
  );
}
