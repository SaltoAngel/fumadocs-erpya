import { getPageImage, getPageMarkdownUrl, source, resolveIcon } from '@/lib/source';
import {
  DocsBody,
  DocsDescription,
  DocsPage,
  DocsTitle,
  MarkdownCopyButton,
  ViewOptionsPopover,
} from 'fumadocs-ui/layouts/docs/page';
import { notFound } from 'next/navigation';
import { getMDXComponents } from '@/components/mdx';
import type { Metadata } from 'next';
import { createRelativeLink } from 'fumadocs-ui/mdx';
import { gitConfig } from '@/lib/shared';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { RestrictedAccess } from '@/components/docs/RestrictedAccess';
import { getGitMetadata } from '@/lib/git';
import { FaHistory, FaUsers } from 'react-icons/fa';

export default async function Page(props: PageProps<'/docs/[[...slug]]'>) {
  const params = await props.params;
  const page = source.getPage(params.slug);
  if (!page) notFound();

  // Verificación de seguridad jerárquica unificada
  const session = await getServerSession(authOptions);
  const userRoles = (session?.user as any)?.roles || [];
  
  // Usamos la URL oficial de la página para generar los roles
  // Ejemplo: /docs/about -> ["docs:about"]
  const pageUrl = page.url || "";
  const pathParts = pageUrl.split('/').filter(Boolean).slice(1);
  const possibleRoles: string[] = ["docs"];
  let currentPath = "docs";
  for (const part of pathParts) {
    currentPath += `:${part}`;
    possibleRoles.push(currentPath);
  }

  const explicitRole = (page.data as any).role;

  const hasAccess = 
    explicitRole === 'public' || // Acceso público explícito
    userRoles.includes('admin') || 
    (explicitRole && userRoles.includes(explicitRole)) ||
    possibleRoles.some((pathRole: string) => userRoles.includes(pathRole));

  // Debug en consola del servidor (puedes verlo en tu terminal)
  console.log(`Verificando acceso para: ${pageUrl}`, {
    rolesDelUsuario: userRoles,
    rolesNecesarios: [...possibleRoles, explicitRole].filter(Boolean)
  });

  if (!hasAccess) {
    return (
      <DocsPage full={page.data.full}>
        <RestrictedAccess requiredRole={explicitRole || possibleRoles[possibleRoles.length - 1] || 'admin'} />
      </DocsPage>
    );
  }

  const MDX = page.data.body;
  const markdownUrl = getPageMarkdownUrl(page).url;
  const gitMeta = getGitMetadata(page.path);
  const pageIcon = page.data.icon ? resolveIcon(page.data.icon) : null;

  return (
    <DocsPage toc={page.data.toc} full={page.data.full}>
      <DocsTitle className="flex items-center gap-3">
        {pageIcon && <span className="text-fd-primary">{pageIcon}</span>}
        <span>{page.data.title}</span>
      </DocsTitle>
      <DocsDescription className="mb-0">{page.data.description}</DocsDescription>
      <div className="flex flex-row gap-2 items-center border-b pb-6">
        <MarkdownCopyButton markdownUrl={markdownUrl} />
        <ViewOptionsPopover
          markdownUrl={markdownUrl}
          githubUrl={`https://github.com/${gitConfig.user}/${gitConfig.repo}/blob/${gitConfig.branch}/content/docs/${page.path}`}
        />
      </div>
      <DocsBody>
        <MDX
          components={getMDXComponents({
            // this allows you to link to other pages with relative file paths
            a: createRelativeLink(source, page),
          })}
        />
      </DocsBody>
      {gitMeta.lastUpdated && (
        <div className="mt-12 pt-6 border-t border-fd-border/60 flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4 text-[11px] text-fd-muted-foreground">
          <div className="flex items-center gap-2">
            <FaHistory className="w-3.5 h-3.5 text-fd-primary/75" />
            <span>
              Última actualización: <strong>{gitMeta.lastUpdated}</strong> por <strong>{gitMeta.lastAuthor}</strong>
            </span>
          </div>
          {gitMeta.contributors.length > 0 && (
            <div className="flex items-center gap-2">
              <FaUsers className="w-4 h-4 text-fd-primary/75" />
              <span>
                Colaboradores:{' '}
                {gitMeta.contributors.map((c, i) => (
                  <span key={c}>
                    <strong>{c}</strong>
                    {i < gitMeta.contributors.length - 1 ? ', ' : ''}
                  </span>
                ))}
              </span>
            </div>
          )}
        </div>
      )}
    </DocsPage>
  );
}

export async function generateStaticParams() {
  return source.generateParams();
}

export async function generateMetadata(props: PageProps<'/docs/[[...slug]]'>): Promise<Metadata> {
  const params = await props.params;
  const page = source.getPage(params.slug);
  if (!page) notFound();

  return {
    title: page.data.title,
    description: page.data.description,
    openGraph: {
      images: getPageImage(page).url,
    },
  };
}
