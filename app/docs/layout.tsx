import { source, filterPageTree } from '@/lib/source';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { baseOptions } from '@/lib/layout.shared';
import { AISearch, AISearchPanel, AISearchTrigger } from '@/components/ai/search';
import { MessageCircleIcon } from 'lucide-react';
import { cn } from '@/lib/cn';
import { buttonVariants } from 'fumadocs-ui/components/ui/button';
import { getServerSession } from 'next-auth';

export default async function Layout({ children }: { children: React.ReactNode }) {
  const options = baseOptions();
  const session = await getServerSession();
  const userRoles = (session?.user as any)?.roles || [];
  
  // Filtrar el árbol de páginas según los roles del usuario
  const fullTree = source.getPageTree();
  
  // Si es un objeto Root (con propiedad children), filtramos sus hijos y mantenemos la estructura
  // Si es un array, lo filtramos directamente
  const filteredTree = Array.isArray(fullTree) 
    ? filterPageTree(fullTree, userRoles)
    : { ...fullTree, children: filterPageTree((fullTree as any).children || [], userRoles) };
  
  return (
    <DocsLayout 
      tree={filteredTree as any} 
      {...options}
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
