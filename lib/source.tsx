import { docs } from 'collections/server';
import { loader } from 'fumadocs-core/source';
import { docsContentRoute, docsImageRoute, docsRoute } from './shared';
import React from 'react';
import * as LuIcons from 'react-icons/lu';
import * as FaIcons from 'react-icons/fa';
import * as HiIcons from 'react-icons/hi2';

// Mapeo seguro usando Lucide por defecto
const iconMap: Record<string, React.ElementType> = {
  gears: LuIcons.LuSettings,
  gear: LuIcons.LuSettings,
  'file-import': LuIcons.LuFile,
  'fa-medium': LuIcons.LuSunMedium,
  computer: LuIcons.LuMonitor,
  rocket: LuIcons.LuRocket,
  book: LuIcons.LuBook,
  briefcase: LuIcons.LuBriefcase,
  calculator: LuIcons.LuCalculator,
  chart: LuIcons.LuChartBar,
  cog: LuIcons.LuSettings,
  database: LuIcons.LuDatabase,
  globe: LuIcons.LuGlobe,
  home: LuIcons.LuHouse,
  image: LuIcons.LuImage,
  link: LuIcons.LuLink,
  list: LuIcons.LuList,
  lock: LuIcons.LuLock,
  mail: LuIcons.LuMail,
  map: LuIcons.LuMap,
  music: LuIcons.LuMusic,
  phone: LuIcons.LuPhone,
  search: LuIcons.LuSearch,
  server: LuIcons.LuServer,
  star: LuIcons.LuStar,
  tag: LuIcons.LuTag,
  tags: LuIcons.LuTags,
  trash: LuIcons.LuTrash,
  user: LuIcons.LuUser,
  users: LuIcons.LuUsers,
  video: LuIcons.LuVideo,
  wrench: LuIcons.LuWrench,
};

export const source = loader({
  baseUrl: docsRoute,
  source: docs.toFumadocsSource(),
  icon(icon) {
    if (!icon) return;
    
    const normalized = icon.toLowerCase();
    
    // 1. Buscar en nuestro mapa manual
    if (normalized in iconMap) {
      const Icon = iconMap[normalized];
      if (Icon) return <Icon />;
    }
    
    // 2. Si empieza por fa-, buscar en Font Awesome
    if (normalized.startsWith('fa-')) {
      const faName = normalized.split(' ')[0].replace('fa-', '');
      const pascalName = faName.split('-').map(p => p.charAt(0).toUpperCase() + p.slice(1)).join('');
      const FaIcon = (FaIcons as any)[`Fa${pascalName}`];
      if (FaIcon) return <FaIcon />;
    }

    // 3. Fallback dinámico a Lucide
    const luName = icon.split('-').map(p => p.charAt(0).toUpperCase() + p.slice(1)).join('');
    const LuIcon = (LuIcons as any)[`Lu${luName}`] || (LuIcons as any)[luName];
    if (LuIcon) return <LuIcon />;

    return null; // Devolver null es seguro para React
  },
});

export function getPageImage(page: (typeof source)['$inferPage']) {
  const segments = [...page.slugs, 'image.png'];

  return {
    segments,
    url: `${docsImageRoute}/${segments.join('/')}`,
  };
}

export function getPageMarkdownUrl(page: (typeof source)['$inferPage']) {
  const segments = [...page.slugs, 'content.md'];

  return {
    segments,
    url: `${docsContentRoute}/${segments.join('/')}`,
  };
}

// Función auxiliar: obtiene los roles jerárquicos para una URL
function getRolesForUrl(url: string): string[] {
  const pathParts = url.split('/').filter(Boolean).slice(1); // Omitimos "docs"
  const roles: string[] = [];
  let currentPath = "docs";
  for (const part of pathParts) {
    currentPath += `:${part}`;
    roles.push(currentPath);
  }
  return roles;
}

// Función auxiliar: verifica si un usuario tiene acceso a una URL
function hasAccessToUrl(url: string, userRoles: string[], explicitRole?: string): boolean {
  if (explicitRole === 'public') return true; // Acceso total para todos
  if (userRoles.includes('admin')) return true;
  if (url === '/docs') return true;
  if (explicitRole && userRoles.includes(explicitRole)) return true;
  
  const requiredRoles = getRolesForUrl(url);
  if (requiredRoles.length === 0) return true; // Sin ruta, no se puede evaluar
  return requiredRoles.some((r: string) => userRoles.includes(r));
}

export function filterPageTree(tree: any[], roles: string[]): any[] {
  if (!Array.isArray(tree)) return [];

  return tree
    .map((node) => {
      if (!node || typeof node !== 'object') return null;

      // --- PÁGINAS (type: 'page') ---
      if (node.type === 'page') {
        const url = node.url || "";
        if (!url) return node; // Sin URL, no filtramos
        
        const explicitRole = node.data?.role || node.data?.frontmatter?.role;
        return hasAccessToUrl(url, roles, explicitRole) ? { ...node } : null;
      }

      // --- CARPETAS (type: 'folder') ---
      if (node.type === 'folder') {
        // Derivar la ruta de la carpeta desde su página índice
        const folderUrl = node.index?.url || "";
        
        // Si la carpeta tiene una URL derivable, verificar permisos de carpeta
        if (folderUrl) {
          const folderRoles = getRolesForUrl(folderUrl);
          const explicitRole = node.index?.data?.role || node.index?.data?.frontmatter?.role;
          const hasFolderAccess = hasAccessToUrl(folderUrl, roles, explicitRole);
          
          // Si el usuario no tiene acceso a la carpeta, ocultarla entera
          if (!hasFolderAccess) {
            return null;
          }
        }

        // Filtrar los hijos recursivamente
        const children = Array.isArray(node.children) ? node.children : [];
        const filteredChildren = filterPageTree(children, roles);

        // Verificar el índice
        let filteredIndex = node.index;
        if (node.index) {
          const indexUrl = node.index.url || "";
          const indexExplicitRole = node.index.data?.role || node.index.data?.frontmatter?.role;
          if (indexUrl && !hasAccessToUrl(indexUrl, roles, indexExplicitRole)) {
            filteredIndex = undefined;
          }
        }

        // REGLA DE ORO: La carpeta solo es visible si tiene contenido accesible
        if (filteredChildren.length === 0 && !filteredIndex) {
          return null;
        }

        return { ...node, children: filteredChildren, index: filteredIndex };
      }

      // --- SEPARADORES y otros tipos ---
      return { ...node };
    })
    .filter((node): node is any => node !== null);
}

// Nueva función para obtener todas las rutas públicas
export function getPublicPaths(): string[] {
  const tree = source.getPageTree();
  const publicPaths: string[] = [];

  function traverse(nodes: any[]) {
    for (const node of nodes) {
      if (node.type === 'page') {
        const explicitRole = node.data?.role || node.data?.frontmatter?.role;
        if (explicitRole === 'public' && node.url) {
          publicPaths.push(node.url);
        }
      } else if (node.type === 'folder') {
        // Si el índice es público, la carpeta es pública
        if (node.index) {
          const explicitRole = node.index.data?.role || node.index.data?.frontmatter?.role;
          if (explicitRole === 'public' && node.index.url) {
            publicPaths.push(node.index.url);
          }
        }
        if (node.children) traverse(node.children);
      }
    }
  }

  traverse(Array.isArray(tree) ? tree : (tree as any).children || []);
  return publicPaths;
}
