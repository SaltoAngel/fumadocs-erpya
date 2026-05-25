'use client';

import Link from 'next/link';
import Image from 'next/image';
import { useState, useRef, useEffect } from 'react';
import { source } from '../lib/source';
import { usePathname, useRouter } from 'next/navigation';
import { useTheme } from 'next-themes';
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
  FaRightFromBracket
} from 'react-icons/fa6';
import { useSession, signIn, signOut } from 'next-auth/react';
import { useSearchContext } from 'fumadocs-ui/contexts/search';
import { LoginModal } from './LoginModal';
import { HomeNavbar } from './HomeNavbar';

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
          { text: 'Keycloak con Autenticación 2FA', url: '/docs/b asic-rules/login-2fa', Icon: FaFingerprint },
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
          { text: 'Dispositvos', url: '/docs/downloads/updates/devices', Icon: FaLaptopCode },
        ]
      }
    ]
  },
];


export function Navbar({ publicPaths = [] }: { publicPaths?: string[] }) {
  const pathname = usePathname();
  const { data: session } = useSession();
  const userRoles = (session?.user as any)?.roles || [];
  
  const [activeMenu, setActiveMenu] = useState<string | null>(null);
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const { theme, setTheme } = useTheme();
  const { setOpenSearch } = useSearchContext();
  const [mounted, setMounted] = useState(false);
  const [isLoginModalOpen, setIsLoginModalOpen] = useState(false);
  const router = useRouter();
  
  // Lógica para ocultar/mostrar navbar al hacer scroll
  const [showNavbar, setShowNavbar] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);
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

    const controlNavbar = () => {
      if (typeof window !== 'undefined') {
        const currentScrollY = window.scrollY;
        
        // Solo mostrar si estamos cerca del tope (ej: menos de 100px)
        if (currentScrollY < 100) {
          setShowNavbar(true);
        } else {
          setShowNavbar(false);
        }
      }
    };

    window.addEventListener('scroll', controlNavbar);
    return () => {
      window.removeEventListener('scroll', controlNavbar);
    };
  }, [lastScrollY]);

  if (pathname === '/') {
    return <HomeNavbar publicPaths={publicPaths} />;
  }

  const handleMouseEnter = (name: string) => {
    if (timeoutRef.current) clearTimeout(timeoutRef.current);
    setActiveMenu(name);
  };

  const handleMouseLeave = () => {
    timeoutRef.current = setTimeout(() => {
      setActiveMenu(null);
    }, 150);
  };

  const isLinkActive = (url: string) => {
    if (url === '/') return pathname === '/';
    return pathname.startsWith(url);
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
    <nav className={`fixed top-0 left-0 right-0 z-[175] h-[60px] bg-fd-background/90 backdrop-blur-[12px] backdrop-saturate-[150%] border-b border-fd-foreground/10 shadow-2xl transition-all duration-500 flex items-center justify-between px-4 md:px-8 ${
      showNavbar ? 'translate-y-0 opacity-100' : '-translate-y-full opacity-0'
    }`}>
      {/* Logo Section */}
      <Link href="/" className="flex items-center gap-3 mr-4 group shrink-0">
        <Image
          src="/logo.svg"
          alt="ERPyA Logo"
          width={36}
          height={36}
          priority
          style={{ width: 'auto', height: '28px' }}
          className={`group-hover:scale-110 transition-transform duration-300 h-[28px] w-auto block ${pathname === '/' ? 'brightness-0 invert' : 'dark:brightness-0 dark:invert'}`}
        />
      </Link>

      {/* Navigation Links - CENTRADO ROBUSTO SIN COLISIONES */}
      <div className="hidden lg:flex items-center gap-0.5 xl:gap-1.5 h-full mx-auto shrink">
        {filteredNavLinks.map((link) => {
          const active = isLinkActive(link.url);
          const isMegaMenu = !!link.groups;
          return (
            <div 
              key={link.text}
              className={`h-full flex items-center ${isMegaMenu ? '' : 'relative'}`}
              onMouseEnter={() => handleMouseEnter(link.text)}
              onMouseLeave={handleMouseLeave}
            >
              <Link 
                href={link.url}
                className={`relative flex items-center gap-1 px-2 xl:px-3 h-full text-xs xl:text-sm font-semibold transition-all duration-200 ${
                  active 
                    ? 'text-[#3b82f6]' 
                    : 'text-fd-foreground/80 hover:text-[#3b82f6]'
                }`}
              >
                <link.Icon className={`text-[13px] xl:text-[14px] ${active ? 'opacity-100' : 'opacity-80'}`} />
                {link.text}
                {(link.groups || link.children) && <FaChevronDown className={`text-[9px] xl:text-[10px] transition-transform duration-300 ${activeMenu === link.text ? 'rotate-180' : ''}`} />}
                
                {active && (
                  <div className="absolute bottom-[6px] left-2 right-2 h-[2px] bg-[#3b82f6] rounded-full animate-in fade-in zoom-in duration-300" />
                )}
              </Link>

              {/* Enhanced Dropdown Menu */}
              {(link.groups || link.children) && activeMenu === link.text && (
                <div 
                  className={`absolute top-[100%] left-1/2 -translate-x-1/2 bg-fd-background/95 backdrop-blur-xl border border-fd-foreground/10 rounded-xl shadow-2xl py-4 px-5 animate-in fade-in slide-in-from-top-1 duration-200 ${
                    link.groups
                      ? 'w-[980px] grid grid-cols-4 gap-6 max-h-[80vh] overflow-hidden' 
                      : 'min-w-[240px] flex flex-col gap-1.5'
                  }`}
                  onMouseLeave={() => setHoveredChild(null)}
                >
                  {link.groups ? (
                    <>
                      {/* Left 3 Columns for Documentation Groups */}
                      <div className="col-span-3 grid grid-cols-3 gap-6 max-h-[70vh] overflow-y-auto pr-4 border-r border-fd-foreground/5 custom-scrollbar">
                        {link.groups.map((group, idx) => (
                          <div key={group.text} className="flex flex-col gap-2">
                            <span className="text-[10px] font-bold text-fd-foreground/45 tracking-wider uppercase border-b border-fd-foreground/5 pb-1">
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
                                        ? 'bg-[#3b82f6]/10 text-[#3b82f6]' 
                                        : 'text-fd-foreground/80 hover:text-[#3b82f6] hover:bg-[#3b82f6]/5'
                                    }`}
                                    onMouseEnter={() => setHoveredChild({ text: child.text, url: child.url })}
                                  >
                                    {child.Icon && <child.Icon className="text-xs text-[#3b82f6] w-[13px] shrink-0" />}
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
                        <span className="text-[10px] font-bold text-zinc-500 tracking-wider uppercase border-b border-fd-foreground/5 pb-1">
                          Artículos Relacionados
                        </span>
                        {hoveredChild ? (
                          <div className="flex flex-col gap-2 animate-in fade-in duration-200">
                            <div className="text-xs font-bold text-[#3b82f6] mb-1 truncate">
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
                                        className={`text-xs transition-all duration-150 py-1.5 border-b border-fd-foreground/5 last:border-b-0 truncate hover:text-[#3b82f6] ${
                                          artActive ? 'text-[#3b82f6] font-bold' : 'text-zinc-600 dark:text-zinc-400'
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
                            <FaBook className="text-2xl text-zinc-500 animate-pulse" />
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
                          className={`flex items-center gap-3 px-4 py-2.5 text-sm rounded-lg transition-all duration-200 ${
                            childActive 
                              ? 'bg-[#3b82f6]/10 text-[#3b82f6]' 
                              : 'text-fd-foreground/80 hover:bg-[#3b82f6]/5 hover:text-[#3b82f6]'
                          }`}
                        >
                          {child.Icon && <child.Icon className="text-[#3b82f6] w-[14px]" />}
                          {child.text}
                        </Link>
                      );
                    })
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Right Side Tools */}
      <div className="flex items-center gap-2 xl:gap-4 shrink-0">
        <button 
          onClick={() => setOpenSearch(true)}
          className="flex items-center gap-2 bg-fd-muted border border-fd-border rounded-full px-4 py-1.5 text-sm text-fd-muted-foreground hover:bg-fd-accent hover:text-fd-foreground transition-all duration-200"
        >
          <FaMagnifyingGlass className="text-[14px]" />
          <span>Buscar</span>
        </button>

        <div className="hidden md:flex items-center gap-3 border-l border-fd-foreground/10 pl-4 ml-2">
          <button 
            onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
            className="text-fd-muted-foreground hover:text-fd-primary transition-all duration-200"
            aria-label="Cambiar tema"
          >
            {mounted && (theme === 'dark' ? <FaSun className="text-[18px]" /> : <FaMoon className="text-[18px]" />)}
            {!mounted && <FaMoon className="text-[18px]" />}
          </button>
        </div>

        {/* Auth Section */}
        <div className="flex items-center gap-3 border-l border-fd-foreground/10 pl-4">
          {session ? (
            <div className="flex items-center gap-3">
              <div className="flex flex-col items-end hidden sm:flex">
                <span className="text-[11px] font-bold text-fd-foreground leading-tight">
                  {session.user?.name}
                </span>
                <span className="text-[9px] text-fd-muted-foreground leading-tight uppercase tracking-tighter mb-1">
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
                className="group flex items-center justify-center w-9 h-9 bg-red-500/10 text-red-500 hover:bg-red-500/20 border border-red-500/20 rounded-full transition-all duration-300"
                title="Cerrar sesión"
              >
                <FaRightFromBracket className="text-[14px] group-hover:scale-110 transition-transform" />
              </button>
            </div>
          ) : (
            <button 
              onClick={() => setIsLoginModalOpen(true)}
              className="flex items-center gap-2 bg-[#3b82f6]/10 text-[#3b82f6] hover:bg-[#3b82f6]/20 border border-[#3b82f6]/20 px-4 py-1.5 rounded-full text-xs font-bold uppercase tracking-wider transition-all duration-300"
            >
              <FaRightToBracket className="text-[12px]" />
              <span className="hidden sm:inline">Acceder</span>
            </button>
          )}
        </div>
      </div>
      
      <style jsx global>{`
        .custom-scrollbar::-webkit-scrollbar {
          width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
          background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
          background: #3b82f6;
          border-radius: 10px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
          background: #2563eb;
        }
      `}</style>
      <LoginModal 
        isOpen={isLoginModalOpen} 
        onClose={() => setIsLoginModalOpen(false)} 
        onSuccess={() => {
          setIsLoginModalOpen(false);
          window.location.reload();
        }} 
      />
    </nav>
  );
}
