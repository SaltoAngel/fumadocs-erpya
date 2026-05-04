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

export function filterPageTree(tree: any[], roles: string[]): any[] {
  if (!Array.isArray(tree)) return [];

  return tree
    .map((node) => {
      if (!node || typeof node !== 'object') return null;

      // 1. Verificar rol en el nodo actual (página o carpeta)
      const requiredRole = node.data?.role || node.data?.frontmatter?.role;
      if (requiredRole && !roles.includes(requiredRole)) {
        return null;
      }

      // 2. Si es una carpeta, filtrar hijos y la página de índice
      if (node.type === 'folder') {
        const children = Array.isArray(node.children) ? node.children : [];
        const filteredChildren = filterPageTree(children, roles);
        
        // También verificar la página de índice de la carpeta si existe
        let filteredIndex = node.index;
        if (node.index) {
          const indexRole = node.index.data?.role || node.index.data?.frontmatter?.role;
          if (indexRole && !roles.includes(indexRole)) {
            filteredIndex = undefined;
          }
        }

        // Si la carpeta queda vacía y no tiene índice accesible, la ocultamos
        if (filteredChildren.length === 0 && !filteredIndex) {
          return null;
        }

        return { 
          ...node, 
          children: filteredChildren,
          index: filteredIndex 
        };
      }

      return { ...node };
    })
    .filter((node): node is any => node !== null);
}
