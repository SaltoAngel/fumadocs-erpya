import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { appName, gitConfig } from './shared';
import Image from 'next/image';

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: (
        <>
          <Image
            src="/logo.svg"
            alt="Logo"
            width={32}
            height={32}
            style={{ height: 'auto' }}
            className="mr-2"
          />
          <span className="font-bold">{appName}</span>
        </>
      ),
    },
    links: [
      {
        text: 'Documentación',
        url: '/docs',
        active: 'nested-url',
      },
      {
        text: 'Comunidad',
        url: '/docs/community',
      },
      {
        text: 'Descargas',
        url: '/docs/downloads',
      },
    ],
    githubUrl: `https://github.com/${gitConfig.user}/${gitConfig.repo}`,
  };
}
