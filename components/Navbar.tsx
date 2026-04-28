'use client';

import Link from 'next/link';
import Image from 'next/image';
import { useState, useRef } from 'react';
import { usePathname } from 'next/navigation';
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
  FaCircleExclamation
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
          { text: 'Binarios', url: '/docs/downloads/binary', Icon: FaFileZipper },
        ]
      },
      {
        text: 'ACTUALIZACIONES',
        children: [
          { text: 'Actualizaciones', url: '/docs/downloads/updates', Icon: FaArrowsRotate },
          { text: 'ADempiere 3.9.4', url: '/docs/downloads/updates/adempiere-3.9.4', Icon: FaNewspaper },
        ]
      }
    ]
  },
];

export function Navbar() {
  const [activeMenu, setActiveMenu] = useState<string | null>(null);
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const pathname = usePathname();

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

  return (
    <nav className="fixed top-0 left-0 right-0 z-[175] h-[60px] bg-[#0d1117]/90 backdrop-blur-[12px] backdrop-saturate-[150%] border-b border-white/10 shadow-2xl transition-all duration-300 flex items-center px-4 md:px-8">
      {/* Logo Section */}
      <Link href="/" className="flex items-center gap-3 mr-8 group">
        <Image
          src="/logo.svg"
          alt="ERPyA Logo"
          width={36}
          height={36}
          priority
          style={{ width: 'auto', height: '36px' }}
          className="group-hover:scale-110 transition-transform duration-300"
        />
      </Link>

      {/* Navigation Links */}
      <div className="hidden lg:flex items-center gap-1 h-full">
        {navLinks.map((link) => {
          const active = isLinkActive(link.url);
          
          return (
            <div 
              key={link.text}
              className="relative h-full flex items-center"
              onMouseEnter={() => handleMouseEnter(link.text)}
              onMouseLeave={handleMouseLeave}
            >
              <Link 
                href={link.url}
                className={`relative flex items-center gap-1.5 px-3 h-full text-sm font-medium transition-all duration-200 ${
                  active 
                    ? 'text-[#3b82f6]' 
                    : 'text-white/80 hover:text-[#3b82f6]'
                }`}
              >
                <link.Icon className={`text-[14px] ${active ? 'opacity-100' : 'opacity-80'}`} />
                {link.text}
                {(link.groups || link.children) && <FaChevronDown className={`text-[10px] transition-transform duration-300 ${activeMenu === link.text ? 'rotate-180' : ''}`} />}
                
                {active && (
                  <div className="absolute bottom-[6px] left-3 right-3 h-[2px] bg-[#3b82f6] rounded-full animate-in fade-in zoom-in duration-300" />
                )}
              </Link>

              {/* Enhanced Dropdown Menu */}
              {(link.groups || link.children) && activeMenu === link.text && (
                <div className="absolute top-[100%] left-0 min-w-[280px] max-h-[80vh] overflow-y-auto bg-[#0d1117]/95 backdrop-blur-xl border border-white/10 rounded-lg shadow-2xl py-2 animate-in fade-in slide-in-from-top-1 duration-200 custom-scrollbar">
                  {link.groups ? (
                    link.groups.map((group, idx) => (
                      <div key={group.text} className={idx > 0 ? 'mt-4 pt-4 border-t border-white/5' : ''}>
                        <div className="px-4 py-1 text-[10px] font-bold text-white/40 tracking-widest uppercase">
                          {group.text}
                        </div>
                        {group.children.map((child) => {
                          const childActive = pathname === child.url;
                          return (
                            <Link
                              key={child.text}
                              href={child.url}
                              className={`flex items-center gap-3 px-4 py-2 text-sm transition-all duration-200 ${
                                childActive 
                                  ? 'bg-[#3b82f6]/10 text-[#3b82f6]' 
                                  : 'text-white/80 hover:bg-[#3b82f6]/10 hover:text-[#3b82f6]'
                              }`}
                            >
                              {child.Icon && <child.Icon className="text-[#3b82f6] w-[14px]" />}
                              {child.text}
                            </Link>
                          );
                        })}
                      </div>
                    ))
                  ) : (
                    link.children?.map((child) => (
                      <Link
                        key={child.text}
                        href={child.url}
                        className="flex items-center gap-3 px-4 py-2.5 text-sm text-white/80 hover:bg-[#3b82f6]/10 hover:text-[#3b82f6] transition-all duration-200"
                      >
                        {child.Icon && <child.Icon className="text-[#3b82f6] w-[14px]" />}
                        {child.text}
                      </Link>
                    ))
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>

      <div className="flex-1" />

      {/* Right Side Tools */}
      <div className="flex items-center gap-4">
        <button 
          className="flex items-center gap-2 bg-white/5 border border-white/10 rounded-full px-4 py-1.5 text-sm text-white/50 hover:bg-white/10 hover:text-white transition-all duration-200"
        >
          <FaMagnifyingGlass className="text-[14px]" />
          <span>Buscar</span>
        </button>

        <div className="hidden md:flex items-center gap-3 border-l border-white/10 pl-4 ml-2">
          <button className="text-white/60 hover:text-[#3b82f6] transition-all duration-200">
            <FaMoon className="text-[18px]" />
          </button>
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
    </nav>
  );
}
