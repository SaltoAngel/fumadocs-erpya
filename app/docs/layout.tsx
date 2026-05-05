import { source, filterPageTree } from '@/lib/source';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { baseOptions } from '@/lib/layout.shared';
import { AISearch, AISearchPanel, AISearchTrigger } from '@/components/ai/search';
import { MessageCircleIcon } from 'lucide-react';
import { cn } from '@/lib/cn';
import { buttonVariants } from 'fumadocs-ui/components/ui/button';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

export default async function Layout({ children }: { children: React.ReactNode }) {
  const options = baseOptions();
  const session = await getServerSession(authOptions);
  const userRoles = (session?.user as any)?.roles || [];
  
  // Filtrar el árbol de páginas según los roles del usuario
  const fullTree = source.getPageTree();
  
  const filteredTree = Array.isArray(fullTree) 
    ? filterPageTree(fullTree, userRoles)
    : { ...fullTree, children: filterPageTree((fullTree as any).children || [], userRoles) };

  // Función auxiliar para verificar acceso a una URL
  const checkLinkAccess = (url: string) => {
    if (userRoles.includes('admin')) return true;
    if (!url.startsWith('/docs')) return true;
    
    // 1. Verificar si la página destino es explícitamente pública
    const segments = url.split('/').filter(Boolean).slice(1);
    const page = source.getPage(segments);
    if (page?.data && (page.data as any).role === 'public') {
      return true;
    }

    // 2. Verificar permisos jerárquicos de Keycloak
    const pathParts = url.split('/').filter(Boolean).slice(1);
    if (pathParts.length === 0) return true; // Raíz /docs
    
    const possibleRoles: string[] = [];
    let currentPath = "docs";
    for (const part of pathParts) {
      currentPath += `:${part}`;
      possibleRoles.push(currentPath);
    }

    return possibleRoles.some(role => userRoles.includes(role));
  };

  // Filtrar los links del sidebar según los roles
  const filteredLinks = (options.links || [])
    .map((link: any) => {
      // Verificar acceso al link principal
      if (link.url && !checkLinkAccess(link.url)) return null;

      // Si tiene sub-items, filtrarlos también
      if (link.items) {
        const filteredItems = link.items.filter((item: any) => 
          !item.url || checkLinkAccess(item.url)
        );
        if (filteredItems.length === 0) return null;
        return { ...link, items: filteredItems };
      }

      return link;
    })
    .filter(Boolean);
  
  return (
    <DocsLayout 
      tree={filteredTree as any} 
      {...options}
      links={filteredLinks}
      nav={{
        enabled: false
      }}
      sidebar={{
        enabled: true
      }}
    >
      <AISearch>
        <AISearchPanel />
        <AISearchTrigger
          position="float"
          className={cn(
            buttonVariants({
              variant: 'secondary',
              className: 'z-50 text-fd-muted-foreground rounded-2xl border border-white/10 shadow-xl',
            }),
          )}
        >
          <MessageCircleIcon className="size-4.5" />
          Ask AI
        </AISearchTrigger>
      </AISearch>

      {children}
    </DocsLayout>
  );
}
