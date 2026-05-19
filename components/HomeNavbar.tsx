'use client';

import React, { useState, useEffect, useRef } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { useSession, signIn, signOut } from 'next-auth/react';
import { useTheme } from 'next-themes';
import { useSearchContext } from 'fumadocs-ui/contexts/search';
import { source } from '../lib/source';
import { 
  FaHouse, 
  FaCircleInfo, 
  FaUser, 
  FaNewspaper, 
  FaRocket, 
  FaListCheck, 
  FaBox, 
  FaMicrochip, 
  FaDiagramProject, 
  FaBolt, 
  FaFileCode, 
  FaBook, 
  FaBookmark, 
  FaFingerprint, 
  FaDatabase, 
  FaLayerGroup, 
  FaUsers, 
  FaPeopleGroup, 
  FaFileContract, 
  FaShieldHalved, 
  FaDownload, 
  FaBoxArchive, 
  FaFileZipper, 
  FaArrowsRotate,
  FaChevronDown,
  FaMagnifyingGlass,
  FaMoon,
  FaSun,
  FaIdCardClip,
  FaKey,
  FaDesktop,
  FaIcons,
  FaWrench,
  FaBoltLightning,
  FaAddressCard,
  FaWarehouse,
  FaFileLines,
  FaWeightHanging,
  FaPrint,
  FaFingerprint as FaFinger,
  FaFileImport,
  FaGear,
  FaChartLine,
  FaTruck,
  FaCartShopping,
  FaHandHoldingHeart,
  FaCashRegister,
  FaBagShopping,
  FaRotateLeft,
  FaScaleBalanced,
  FaUserTie,
  FaBuilding,
  FaCalculator,
  FaCity,
  FaHandHoldingDollar,
  FaFlag,
  FaCircleExclamation,
  FaLaptopCode,
  FaRightToBracket,
  FaRightFromBracket,
  FaBars,
  FaXmark
} from 'react-icons/fa6';

interface NavChild {
  text: string;
  url: string;
  Icon?: any;
}

interface NavGroup {
  text: string;
  children: NavChild[];
}

interface NavItem {
  text: string;
  url: string;
  Icon: any;
  groups?: NavGroup[];
  children?: NavChild[];
}

const navLinks: NavItem[] = [
  { text: 'Inicio', url: '/', Icon: FaHouse },
  { 
    text: 'Nosotros', 
    url: '/docs/about', 
    Icon: FaCircleInfo,
    groups: [
      {
        text: 'NOSOTROS',
        children: [
          { text: 'Acerca de', url: '/docs/about', Icon: FaUser },
        ]
      },
      {
        text: 'NOTICIAS',
        children: [
          { text: 'ADempiere 3.9.4', url: '/docs/about/news/2023-01-01-adempiere-394', Icon: FaNewspaper },
          { text: 'Seguridad Cloud', url: '/docs/about/news/security-improvements-in-adempiere-cloud', Icon: FaShieldHalved },
        ]
      },
      {
        text: 'NUESTROS SERVICIOS',
        children: [
          { text: 'Servicios', url: '/docs/about/services/', Icon: FaRocket },
          { text: 'Soporte Funcional', url: '/docs/about/advanced-functional-support-scheme/', Icon: FaUsers },
          { text: 'Procedimientos Estándar', url: '/docs/about/standard-procedures/', Icon: FaListCheck },
        ]
      }
    ]
  },
  { 
    text: 'Producto', 
    url: '/docs/product', 
    Icon: FaBox,
    groups: [
      {
        text: 'PRODUCTO',
        children: [
          { text: 'Producto', url: '/docs/product', Icon: FaBox },
        ]
      },
      {
        text: 'TECNOLOGÍA',
        children: [
          { text: 'Tecnología', url: '/docs/product/technology', Icon: FaMicrochip },
          { text: 'Procesos de Negocio', url: '/docs/product/business-process', Icon: FaDiagramProject },
          { text: 'Beneficios', url: '/docs/product/benefits', Icon: FaBolt },
          { text: 'Código Fuente', url: '/docs/product/code', Icon: FaFileCode },
        ]
      }
    ]
  },
  { 
    text: 'Documentación', 
    url: '/docs', 
    Icon: FaBook,
    groups: [
      {
        text: 'ESTÁNDAR',
        children: [
          { text: 'ADempiere Estándar', url: '/docs', Icon: FaBook },
        ]
      },
      {
        text: 'GESTIÓN BÁSICA',
        children: [
          { text: 'Inicio de Sesión', url: '/docs/basic-rules/login', Icon: FaKey },
          { text: 'Interfaz de Usuario', url: '/docs/basic-rules/user-interface', Icon: FaDesktop },
          { text: 'Iconos de la Interfaz', url: '/docs/basic-rules/icons-interface', Icon: FaIcons },
          { text: 'Barra de Herramientas', url: '/docs/basic-rules/toolbar', Icon: FaWrench },
          { text: 'Accesos Rápidos', url: '/docs/basic-rules/quick-access', Icon: FaBoltLightning },
          { text: 'Utilería', url: '/docs/basic-rules/props', Icon: FaGear },
        ]
      },
      {
        text: 'DATOS MAESTROS',
        children: [
          { text: 'Socio del Negocio', url: '/docs/master-data/business-partner', Icon: FaAddressCard },
          { text: 'Producto', url: '/docs/master-data/product', Icon: FaBox },
          { text: 'Almacén', url: '/docs/master-data/warehouse', Icon: FaWarehouse },
          { text: 'Reportes de Maestros', url: '/docs/master-data/reports', Icon: FaFileLines },
        ]
      },
      {
        text: 'APLICACIONES',
        children: [
          { text: 'Lectura de Peso', url: '/docs/devices/record-weight/', Icon: FaWeightHanging },
          { text: 'Impresoras', url: '/docs/devices/printers', Icon: FaPrint },
          { text: 'Control de Asistencia', url: '/docs/devices/attendance-control', Icon: FaFinger },
        ]
      },
      {
        text: 'INICIO DE SESIÓN CON KEYCLOAK',
        children: [
          { text: 'Acceso Seguro con Keycloak', url: '/docs/basic-rules/login-keycloak', Icon: FaShieldHalved },
          { text: 'Keycloak con Autenticación 2FA', url: '/docs/basic-rules/login-2fa', Icon: FaFingerprint },
        ]
      },
      {
        text: 'GESTIONES',
        children: [
          { text: 'Gestión de Materiales', url: '/docs/material-management/', Icon: FaLayerGroup },
          { text: 'Gestión de Producción', url: '/docs/production-management/', Icon: FaDiagramProject },
          { text: 'Gestión de Distribución', url: '/docs/distribution-management/', Icon: FaTruck },
          { text: 'Gestión de Ventas', url: '/docs/sales-management/', Icon: FaCartShopping },
          { text: 'Gestión de Relaciones', url: '/docs/customer-relationship-management/', Icon: FaHandHoldingHeart },
          { text: 'Gestión de PDV', url: '/docs/pdv-management/', Icon: FaCashRegister },
          { text: 'Gestión de Compras', url: '/docs/purchase-management/', Icon: FaBagShopping },
          { text: 'Gestión de Devoluciones', url: '/docs/return-management/', Icon: FaRotateLeft },
          { text: 'Gestión de Saldos', url: '/docs/balance-management/', Icon: FaScaleBalanced },
          { text: 'Gestión Humana', url: '/docs/human-management/', Icon: FaUserTie },
          { text: 'Gestión de Activos', url: '/docs/asset-management/', Icon: FaBuilding },
          { text: 'Gestión Contable', url: '/docs/accounting-management/', Icon: FaCalculator },
        ]
      }
    ]
  },
  { 
    text: 'Comunidad', 
    url: '/docs/community', 
    Icon: FaUsers,
    groups: [
      {
        text: 'COMUNIDAD',
        children: [
          { text: 'Comunidad', url: '/docs/community', Icon: FaPeopleGroup },
        ]
      },
      {
        text: 'ADEMPIERE ERP',
        children: [
          { text: 'Código de Conducta', url: '/docs/community/code-of-conduct', Icon: FaFileContract },
          { text: 'Derechos y Deberes', url: '/docs/community/duties-and-rigths', Icon: FaShieldHalved },
        ]
      }
    ]
  },
  { 
    text: 'Descargas', 
    url: '/docs/downloads', 
    Icon: FaDownload,
    groups: [
      {
        text: 'DESCARGAS',
        children: [
          { text: 'Descargas', url: '/docs/downloads', Icon: FaDownload },
        ]
      },
      {
        text: 'BINARIOS',
        children: [
          { text: 'Docker', url: '/docs/downloads/docker', Icon: FaBoxArchive },
          { text: 'Descarga Binaria', url: '/docs/downloads/binary', Icon: FaFileZipper },
        ]
      },
      {
        text: 'ACTUALIZACIONES',
        children: [
          { text: 'Versiones de Aplicaciones', url: '/docs/downloads/updates', Icon: FaArrowsRotate },
          { text: 'ADempiere 3.9.4', url: '/docs/downloads/updates/adempiere-3.9.4', Icon: FaLaptopCode },
          { text: 'Rs-5.x', url: '/docs/downloads/updates/rs-5.x', Icon: FaLaptopCode },
          { text: 'Rs-4.x', url: '/docs/downloads/updates/rs-4.x', Icon: FaLaptopCode },
          { text: 'Rs-3.x', url: '/docs/downloads/updates/rs-3.x', Icon: FaLaptopCode },
          { text: 'Rs-2.x', url: '/docs/downloads/updates/rs-2.x', Icon: FaLaptopCode },
          { text: 'Rs-1.x', url: '/docs/downloads/updates/rs-1.x', Icon: FaLaptopCode },
          { text: 'Dispositivos', url: '/docs/downloads/updates/devices', Icon: FaLaptopCode },
        ]
      }
    ]
  }
];

export function HomeNavbar({ publicPaths = [] }: { publicPaths?: string[] }) {
  const { data: session } = useSession();
  const pathname = usePathname();
  const { theme, setTheme } = useTheme();
  const { setOpenSearch } = useSearchContext();
  const [mounted, setMounted] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const [activeMenu, setActiveMenu] = useState<string | null>(null);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [expandedMobileMenu, setExpandedMobileMenu] = useState<string | null>(null);
  
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const userRoles = (session?.user as any)?.roles || [];
  const [hoveredChild, setHoveredChild] = useState<{ text: string; url: string } | null>(null);

  // Obtener artículos específicos de una sección
  const getSubArticles = (sectionUrl: string) => {
    try {
      const normSection = sectionUrl.endsWith('/') ? sectionUrl.slice(0, -1) : sectionUrl;
      // Evitar que la raíz de la documentación traiga absolutamente todos los artículos de la web
      if (normSection === '/docs' || normSection === '' || normSection === '/') {
        return [];
      }
      const allPages = source.getPages();
      const sectionSlashes = normSection.split('/').length;
      
      return allPages
        .filter(page => {
          const normPage = page.url.endsWith('/') ? page.url.slice(0, -1) : page.url;
          // Debe empezar con la ruta de la sección y ser una sub-ruta directa
          if (!normPage.startsWith(normSection) || normPage.length <= normSection.length) {
            return false;
          }
          const pageSlashes = normPage.split('/').length;
          return pageSlashes === sectionSlashes + 1;
        })
        .map(page => {
          let text = page.data.title;
          text = text.replace(/^Lista de Versiones /, "Versiones ");
          text = text.replace(/^Versiones de ADempiere /, "");
          return {
            text,
            url: page.url,
          };
        });
    } catch (e) {
      return [];
    }
  };

  useEffect(() => {
    setMounted(true);
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const handleMouseEnter = (name: string) => {
    if (timeoutRef.current) clearTimeout(timeoutRef.current);
    setActiveMenu(name);
  };

  const handleMouseLeave = () => {
    timeoutRef.current = setTimeout(() => {
      setActiveMenu(null);
    }, 150);
  };

  // Función para verificar acceso a un enlace basado en roles de Keycloak
  const checkAccess = (url: string) => {
    if (userRoles.includes('admin')) return true;
    
    // Normalizar URLs para evitar problemas con la barra diagonal final (trailing slash)
    const normalizedUrl = url.endsWith('/') ? url.slice(0, -1) : url;
    
    // Si la ruta está en la lista de rutas públicas, permitimos el acceso
    const isPublic = publicPaths.some(p => {
      const normalizedP = p.endsWith('/') ? p.slice(0, -1) : p;
      return normalizedP === normalizedUrl;
    });

    if (isPublic) return true;

    if (!url.startsWith('/docs')) return true;

    const pathParts = url.split('/').filter(Boolean).slice(1);
    const possibleRoles: string[] = ["docs"];
    let currentPath = "docs";
    for (const part of pathParts) {
      currentPath += `:${part}`;
      possibleRoles.push(currentPath);
    }

    return possibleRoles.some(role => userRoles.includes(role) || role === 'public');
  };

  // Filtrar los enlaces del Navbar
  const filteredNavLinks = navLinks.map(link => {
    // Si el link principal no tiene acceso, lo marcamos para eliminar
    if (!checkAccess(link.url)) return null;

    // Filtrar grupos si existen
    if (link.groups) {
      const filteredGroups = link.groups.map(group => {
        const filteredChildren = group.children.filter(child => checkAccess(child.url));
        if (filteredChildren.length === 0) return null;
        return { ...group, children: filteredChildren };
      }).filter(Boolean) as NavGroup[];

      if (filteredGroups.length === 0) return null;
      return { ...link, groups: filteredGroups };
    }

    // Filtrar hijos directos si existen
    if (link.children) {
      const filteredChildren = link.children.filter(child => checkAccess(child.url));
      if (filteredChildren.length === 0) return null;
      return { ...link, children: filteredChildren };
    }

    return link;
  }).filter(Boolean) as NavItem[];

  return (
    <header className={`fixed top-0 left-0 right-0 z-[175] w-full px-6 transition-all duration-500 flex items-center h-[60px] ${
      isScrolled 
        ? 'bg-[#020716]/60 backdrop-blur-md border-b border-white/[0.08] shadow-lg shadow-[#000]/40' 
        : 'bg-transparent'
    }`}>
      <div className="w-full max-w-7xl mx-auto flex items-center justify-between">
        
        {/* Logo Section */}
        <Link href="/" className="flex items-center gap-3 group">
          <Image
            src="/logo.svg"
            alt="ERPyA Logo"
            width={36}
            height={36}
            priority
            style={{ width: 'auto', height: '28px' }}
            className="group-hover:scale-110 transition-transform duration-300 h-[28px] w-auto block"
          />
        </Link>

        {/* Dynamic Center Navigation Links (Exact Same as Original Docs Navbar) */}
        <nav className="hidden lg:flex items-center gap-1 text-sm font-medium">
          {filteredNavLinks.map((link) => {
            const hasSubmenu = link.groups || link.children;
            
            const isMegaMenu = !!link.groups;
            return (
              <div 
                key={link.text}
                className={`h-[60px] flex items-center ${isMegaMenu ? '' : 'relative'}`}
                onMouseEnter={() => hasSubmenu && handleMouseEnter(link.text)}
                onMouseLeave={hasSubmenu ? handleMouseLeave : undefined}
              >
                {hasSubmenu ? (
                  <Link 
                    href={link.url}
                    className="flex items-center gap-1 px-3 py-2 rounded-lg transition-all duration-300 text-zinc-300 hover:text-white hover:bg-white/[0.04]"
                  >
                    {link.text}
                    <FaChevronDown className={`text-[10px] transition-transform duration-300 ${activeMenu === link.text ? 'rotate-180' : ''}`} />
                  </Link>
                ) : (
                  <Link 
                    href={link.url}
                    className="flex items-center gap-1.5 px-3 py-2 rounded-lg text-zinc-300 hover:text-white hover:bg-white/[0.04] transition-all duration-300"
                  >
                    {link.text}
                  </Link>
                )}

                {/* Mega Glassmorphic Dropdown Panel */}
                {activeMenu === link.text && hasSubmenu && (
                  <div 
                    className={`absolute top-[100%] left-1/2 -translate-x-1/2 bg-[#030712]/95 backdrop-blur-xl border border-white/[0.08] rounded-xl shadow-[0_20px_50px_rgba(0,0,0,0.6)] py-4 px-5 animate-in fade-in slide-in-from-top-1 duration-200 ${
                      link.groups
                        ? 'w-[980px] grid grid-cols-4 gap-6 max-h-[80vh] overflow-hidden' 
                        : 'min-w-[240px] flex flex-col gap-1.5'
                    }`}
                    onMouseLeave={() => setHoveredChild(null)}
                  >
                    {link.groups ? (
                      <>
                        {/* Left 3 Columns for Documentation Groups */}
                        <div className="col-span-3 grid grid-cols-3 gap-6 max-h-[70vh] overflow-y-auto pr-4 border-r border-white/[0.08] custom-scrollbar">
                          {link.groups.map((group) => (
                            <div key={group.text} className="flex flex-col gap-2">
                              <span className="text-[10px] font-bold text-zinc-500 tracking-wider uppercase border-b border-white/[0.05] pb-1">
                                {group.text}
                              </span>
                              <div className="flex flex-col gap-1">
                                {group.children.map((child) => {
                                  const childActive = pathname === child.url;
                                  return (
                                    <Link
                                      key={child.text}
                                      href={child.url}
                                      className={`flex items-center gap-2.5 px-2 py-1.5 rounded-lg text-xs font-semibold transition-all duration-200 ${
                                        childActive 
                                          ? 'bg-[#1AAAD4]/10 text-[#1AAAD4]' 
                                          : 'text-zinc-300 hover:text-[#1AAAD4] hover:bg-white/[0.04]'
                                      }`}
                                      onMouseEnter={() => setHoveredChild({ text: child.text, url: child.url })}
                                    >
                                      {child.Icon && <child.Icon className="text-xs text-[#1AAAD4] w-[13px] shrink-0" />}
                                      <span className="truncate">{child.text}</span>
                                    </Link>
                                  );
                                })}
                              </div>
                            </div>
                          ))}
                        </div>

                        {/* Right 1 Column for Dynamic Article Explorer */}
                        <div className="col-span-1 flex flex-col gap-3 pl-2 max-h-[70vh] overflow-hidden">
                          <span className="text-[10px] font-bold text-zinc-500 tracking-wider uppercase border-b border-white/[0.05] pb-1">
                            Artículos Relacionados
                          </span>
                          {hoveredChild ? (
                            <div className="flex flex-col gap-2 animate-in fade-in duration-200">
                              <div className="text-xs font-bold text-[#1AAAD4] mb-1 truncate">
                                {hoveredChild.text}
                              </div>
                              {(() => {
                                const subArticles = getSubArticles(hoveredChild.url).filter(art => checkAccess(art.url));
                                return subArticles.length > 0 ? (
                                  <div className="flex flex-col gap-2 max-h-[55vh] overflow-y-auto pr-1 custom-scrollbar">
                                    {subArticles.map((art) => {
                                      const artActive = pathname === art.url;
                                      return (
                                        <Link
                                          key={art.url}
                                          href={art.url}
                                          className={`text-xs transition-all duration-150 py-1.5 border-b border-white/[0.03] last:border-b-0 truncate hover:text-[#1AAAD4] ${
                                            artActive ? 'text-[#1AAAD4] font-bold' : 'text-zinc-450'
                                          }`}
                                          title={art.text}
                                        >
                                          • {art.text}
                                        </Link>
                                      );
                                    })}
                                  </div>
                                ) : (
                                  <div className="text-[11px] text-zinc-500 italic">
                                    No hay sub-artículos en esta sección.
                                  </div>
                                );
                              })()}
                            </div>
                          ) : (
                            <div className="flex flex-col items-center justify-center h-full py-8 text-center gap-2 opacity-50">
                              <FaBook className="text-2xl text-white/20 animate-pulse" />
                              <span className="text-[11px] text-zinc-500 leading-relaxed">
                                Pasa el cursor sobre una sección para explorar sus artículos
                              </span>
                            </div>
                          )}
                        </div>
                      </>
                    ) : (
                      link.children?.map((child) => {
                        const childActive = pathname === child.url;
                        return (
                          <Link
                            key={child.text}
                            href={child.url}
                            className={`flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs font-semibold transition-all duration-200 ${
                              childActive 
                                ? 'bg-[#1AAAD4]/10 text-[#1AAAD4]' 
                                : 'text-zinc-300 hover:text-[#1AAAD4] hover:bg-white/[0.04]'
                            }`}
                          >
                            {child.Icon && <child.Icon className="text-xs text-[#1AAAD4] w-[13px] shrink-0" />}
                            <span>{child.text}</span>
                          </Link>
                        );
                      })
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </nav>

        {/* Right Tools Section */}
        <div className="flex items-center gap-3">
          
          {/* Search Button */}
          <button 
            onClick={() => setOpenSearch(true)}
            className="flex items-center gap-2 bg-white/[0.04] hover:bg-white/[0.08] border border-white/[0.08] rounded-full px-4 py-1.5 text-xs font-semibold text-zinc-400 hover:text-white transition-all duration-300"
          >
            <FaMagnifyingGlass className="text-xs" />
            <span>Buscar...</span>
          </button>

          {/* Theme Toggle */}
          <button 
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
            className="p-2 rounded-full text-zinc-400 hover:text-white hover:bg-white/[0.04] transition-all duration-300"
            aria-label="Cambiar tema"
          >
            {mounted && (theme === 'dark' ? <FaSun className="text-base" /> : <FaMoon className="text-base" />)}
            {!mounted && <FaMoon className="text-base" />}
          </button>

          {/* Authentication State */}
          <div className="flex items-center gap-3 border-l border-white/[0.08] pl-3 ml-1">
            {session ? (
              <div className="flex items-center gap-3">
                <div className="flex flex-col items-end hidden sm:flex">
                  <span className="text-[11px] font-bold text-white leading-tight">
                    {session.user?.name}
                  </span>
                  <span className="text-[9px] text-zinc-500 leading-tight uppercase tracking-tighter">
                    {session.user?.email}
                  </span>
                </div>
                <button 
                  onClick={() => {
                    const clientId = 'nextjs-app';
                    const postLogoutRedirect = window.location.origin;
                    const issuer = 'http://localhost:8080/realms/ERP%20Docs';
                    const logoutUrl = `${issuer}/protocol/openid-connect/logout?client_id=${clientId}&post_logout_redirect_uri=${encodeURIComponent(postLogoutRedirect)}`;
                    
                    signOut({ callbackUrl: logoutUrl });
                  }}
                  className="group flex items-center justify-center w-8 h-8 bg-red-500/10 text-red-400 hover:bg-red-500/20 border border-red-500/20 rounded-full transition-all duration-300"
                  title="Cerrar sesión"
                >
                  <FaRightFromBracket className="text-xs group-hover:scale-110 transition-transform" />
                </button>
              </div>
            ) : (
              <button 
                onClick={() => signIn('keycloak')}
                className="flex items-center gap-1.5 bg-[#1AAAD4]/10 text-[#1AAAD4] hover:bg-[#1AAAD4]/20 border border-[#1AAAD4]/20 px-3.5 py-1.5 rounded-full text-[10px] font-extrabold uppercase tracking-wider transition-all duration-300"
              >
                <FaRightToBracket className="text-xs" />
                <span className="hidden sm:inline">Acceder</span>
              </button>
            )}
          </div>

          {/* Mobile Menu Toggle Button */}
          <button 
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="lg:hidden p-2 rounded-full text-zinc-400 hover:text-white hover:bg-white/[0.04] transition-all duration-300"
            aria-label="Menú móvil"
          >
            {mobileMenuOpen ? <FaXmark className="text-lg" /> : <FaBars className="text-lg" />}
          </button>

        </div>
      </div>

      {/* Mobile Drawer Overlay */}
      {mobileMenuOpen && (
        <div className="fixed inset-0 top-[60px] z-[160] bg-[#030712] border-t border-white/[0.08] lg:hidden flex flex-col p-6 gap-4 overflow-y-auto animate-in fade-in duration-300 custom-scrollbar">
          {filteredNavLinks.map((link) => {
            const hasSubmenu = link.groups || link.children;
            const isExpanded = expandedMobileMenu === link.text;
            
            return (
              <div key={link.text} className="flex flex-col gap-2 pb-2 border-b border-white/[0.03]">
                {hasSubmenu ? (
                  <button 
                    onClick={() => setExpandedMobileMenu(isExpanded ? null : link.text)}
                    className="flex items-center justify-between w-full py-1 text-base font-bold text-white hover:text-[#1AAAD4] transition-all"
                  >
                    <span>{link.text}</span>
                    <FaChevronDown className={`text-xs transition-transform duration-300 ${isExpanded ? 'rotate-180' : ''}`} />
                  </button>
                ) : (
                  <Link 
                    href={link.url}
                    onClick={() => setMobileMenuOpen(false)}
                    className="py-1 text-base font-bold text-white hover:text-[#1AAAD4] transition-all"
                  >
                    {link.text}
                  </Link>
                )}

                {/* Submenu Drawer Content */}
                {hasSubmenu && isExpanded && (
                  <div className="flex flex-col gap-3 pl-3 border-l border-white/[0.08] mt-2 py-1 animate-in slide-in-from-top-1 duration-200">
                    {link.groups ? (
                      link.groups.map((group) => (
                        <div key={group.text} className="flex flex-col gap-1.5">
                          <span className="text-[10px] font-bold text-zinc-500 tracking-wider uppercase">
                            {group.text}
                          </span>
                          {group.children.map((child) => (
                            <Link
                              key={child.text}
                              href={child.url}
                              onClick={() => setMobileMenuOpen(false)}
                              className="flex items-center gap-2 py-1 text-xs font-semibold text-zinc-300 hover:text-[#1AAAD4] transition-all"
                            >
                              {child.Icon && <child.Icon className="text-xs text-[#1AAAD4] w-[13px]" />}
                              <span>{child.text}</span>
                            </Link>
                          ))}
                        </div>
                      ))
                    ) : (
                      link.children?.map((child) => (
                        <Link
                          key={child.text}
                          href={child.url}
                          onClick={() => setMobileMenuOpen(false)}
                          className="flex items-center gap-2 py-1 text-xs font-semibold text-zinc-300 hover:text-[#1AAAD4] transition-all"
                        >
                          {child.Icon && <child.Icon className="text-xs text-[#1AAAD4] w-[13px]" />}
                          <span>{child.text}</span>
                        </Link>
                      ))
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}

      <style jsx global>{`
        .custom-scrollbar::-webkit-scrollbar {
          width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
          background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
          background: rgba(255, 255, 255, 0.1);
          border-radius: 10px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
          background: #1AAAD4;
        }
      `}</style>
    </header>
  );
}
