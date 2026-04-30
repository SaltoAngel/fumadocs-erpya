import { source } from '@/lib/source';
import { DocsLayout } from 'fumadocs-ui/layouts/docs';
import { baseOptions } from '@/lib/layout.shared';
import { AISearch, AISearchPanel, AISearchTrigger } from '@/components/ai/search';
import { MessageCircleIcon } from 'lucide-react';
import { cn } from '@/lib/cn';
import { buttonVariants } from 'fumadocs-ui/components/ui/button';

export default function Layout({ children }: { children: React.ReactNode }) {
  const options = baseOptions();
  
  return (
    <DocsLayout 
      tree={source.getPageTree()} 
      {...options}
      nav={{
        enabled: false // Mantenemos desactivado el nav original
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
