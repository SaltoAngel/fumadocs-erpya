import type { BaseLayoutProps } from 'fumadocs-ui/layouts/shared';
import { appName, gitConfig } from './shared';
import Image from 'next/image';
import {
  HomeIcon,
  UsersIcon,
  BoxIcon,
  BookIcon,
  DownloadIcon,
  InfoIcon,
  NewspaperIcon,
  RocketIcon,
  ListChecksIcon,
  CpuIcon,
  BookmarkIcon,
  FingerprintIcon,
  FileDownIcon,
  Settings2Icon,
  PinIcon,
  LayersIcon,
  RefreshCwIcon,
  ArchiveIcon,
  UserIcon,
  ShieldCheckIcon,
  BriefcaseIcon,
  LayoutIcon,
  MonitorIcon,
  HardDriveIcon,
  FileTextIcon,
  PieChartIcon,
  TruckIcon,
  ShoppingCartIcon,
  BarChartIcon,
  CalculatorIcon,
  ZapIcon
} from 'lucide-react';

export function baseOptions(): BaseLayoutProps {
  return {
    nav: {
      title: (
        <div className="flex items-center gap-2 py-1">
          <Image
            src="/logo.svg"
            alt="Logo"
            width={40}
            height={40}
            priority
            style={{ width: 'auto', height: '40px' }}
            className="drop-shadow-sm"
          />
        </div>
      ),
    },
    links: [
      {
        text: 'Inicio',
        url: '/',
        icon: <HomeIcon className="size-4" />,
      },
      {
        text: 'Nosotros',
        url: '/docs/about',
        icon: <InfoIcon className="size-4" />,
        type: 'menu',
        items: [
          { text: 'Acerca de', url: '/docs/about', icon: <UserIcon className="size-4" /> },
          { text: 'Noticias', url: '/docs/about/news', icon: <NewspaperIcon className="size-4" /> },
          { text: 'Servicios', url: '/docs/about/services', icon: <RocketIcon className="size-4" /> },
          { text: 'Procedimientos', url: '/docs/about/standard-procedures', icon: <ListChecksIcon className="size-4" /> },
          { text: 'E-commerce', url: '/docs/about/other-services/e-commerce', icon: <ShoppingCartIcon className="size-4" /> },
        ]
      },
      {
        text: 'Producto',
        url: '/docs/product',
        icon: <BoxIcon className="size-4" />,
        type: 'menu',
        items: [
          { text: 'Características', url: '/docs/product', icon: <BoxIcon className="size-4" /> },
          { text: 'Tecnología', url: '/docs/product/technology', icon: <CpuIcon className="size-4" /> },
          { text: 'Procesos', url: '/docs/product/business-process', icon: <Settings2Icon className="size-4" /> },
          { text: 'Beneficios', url: '/docs/product/benefits', icon: <ZapIcon className="size-4" /> },
          { text: 'Código Fuente', url: '/docs/product/source-code', icon: <ArchiveIcon className="size-4" /> },
        ]
      },
      {
        text: 'Documentación',
        url: '/docs',
        icon: <BookIcon className="size-4" />,
        type: 'menu',
        items: [
          { text: 'ADempiere Estándar', url: '/docs/docs', icon: <BookIcon className="size-4" /> },
          { text: 'Gestión Básica', url: '/docs/docs/basic-rules', icon: <BookmarkIcon className="size-4" /> },
          { text: 'Datos Maestros', url: '/docs/docs/master-data', icon: <PinIcon className="size-4" /> },
          { text: 'Dispositivos', url: '/docs/docs/devices', icon: <MonitorIcon className="size-4" /> },
          { text: 'Keycloak & 2FA', url: '/docs/docs/basic-rules/login-keycloak', icon: <FingerprintIcon className="size-4" /> },
          { text: 'Importación', url: '/docs/docs/data-importation', icon: <FileDownIcon className="size-4" /> },
          { text: 'Gestiones (ERP)', url: '/docs/docs/material-management', icon: <LayersIcon className="size-4" /> },
          { text: 'Localización LVE', url: '/docs/docs/lve/document-utility', icon: <ShieldCheckIcon className="size-4" /> },
        ]
      },
      {
        text: 'Comunidad',
        url: '/docs/community',
        icon: <UsersIcon className="size-4" />,
        type: 'menu',
        items: [
          { text: 'Comunidad', url: '/docs/community', icon: <UsersIcon className="size-4" /> },
          { text: 'Código de Conducta', url: '/docs/community/code-of-conduct', icon: <FileTextIcon className="size-4" /> },
          { text: 'Derechos y Deberes', url: '/docs/community/duties-and-rigths', icon: <ShieldCheckIcon className="size-4" /> },
        ]
      },
      {
        text: 'Descargas',
        url: '/docs/downloads',
        icon: <DownloadIcon className="size-4" />,
        type: 'menu',
        items: [
          { text: 'Docker', url: '/docs/downloads/docker', icon: <HardDriveIcon className="size-4" /> },
          { text: 'Binarios', url: '/docs/downloads/binary', icon: <ArchiveIcon className="size-4" /> },
          { text: 'Actualizaciones', url: '/docs/downloads/updates', icon: <RefreshCwIcon className="size-4" /> },
        ]
      },
    ],
    githubUrl: `https://github.com/${gitConfig.user}/${gitConfig.repo}`,
  };
}
