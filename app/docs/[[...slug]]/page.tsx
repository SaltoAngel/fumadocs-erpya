import { getPageImage, getPageMarkdownUrl, source } from '@/lib/source';
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

  return (
    <DocsPage toc={page.data.toc} full={page.data.full}>
      <DocsTitle>{page.data.title}</DocsTitle>
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
