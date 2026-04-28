import React from 'react';
import Link from 'next/link';
import { FaGithub, FaDiscord, FaTwitter, FaEnvelope, FaFileAlt, FaFolder, FaTags, FaHistory } from 'react-icons/fa';

export const BloggerInfo: React.FC = () => {
  const stats = [
    { label: 'Artículos', count: 289, href: '/article/', icon: <FaFileAlt /> },
    { label: 'Categoría', count: 7, href: '/category/', icon: <FaFolder /> },
    { label: 'Etiquetas', count: 441, href: '/tag/', icon: <FaTags /> },
    { label: 'Línea de tiempo', count: 289, href: '/timeline/', icon: <FaHistory /> },
  ];

  const socialLinks = [
    { name: 'Gmail', href: 'mailto:info@erpya.com', icon: <FaEnvelope />, color: '#DB4437' },
    { name: 'GitHub', href: 'https://github.com/erpcya', icon: <FaGithub />, color: '#171515' },
    { name: 'Discord', href: 'https://discord.gg/UWcyn7DEzV', icon: <FaDiscord />, color: '#2DAAE1' },
    { name: 'Twitter', href: 'https://twitter.com/erpcya', icon: <FaTwitter />, color: '#3397db' },
  ];

  const stickyArticles = [
    { title: 'erpya-3.9.4-001-4.1.7', href: '/downloads/updates/adempiere-3.9.4/erpya-3.9.4-001-4.1.x/erpya-3.9.4-001-4.1.7.html' },
    { title: 'erpya-3.9.4-001-3.4.3', href: '/downloads/updates/adempiere-3.9.4/erpya-3.9.4-001-3.x.x/erpya-3.9.4-001-3.4.x/erpya-3.9.4-001-3.4.3.html' },
    { title: 'erpya-3.9.4-001-3.4.4', href: '/downloads/updates/adempiere-3.9.4/erpya-3.9.4-001-3.x.x/erpya-3.9.4-001-3.4.x/erpya-3.9.4-001-3.4.4.html' },
    { title: 'Acerca de ERP Consultores y Asociados', href: '/about/' },
    { title: 'Mejoras de seguridad en ADempiere Cloud', href: '/about/news/security-improvements-in-adempiere-cloud.html' },
  ];

  return (
    <aside className="vp-blog-info-wrapper">
      <div className="vp-blogger-info">
        <img 
          className="vp-blogger-avatar" 
          src="/logo.svg" 
          alt="Blogger Avatar" 
          loading="lazy" 
        />
        <div className="vp-blogger-name">ERP Consultores y Asociados, C.A.</div>
        <div className="vp-blogger-description">
          Documentación Oficial de ERP Consultores y Asociados, CA
        </div>
      </div>

      <div className="vp-blog-counts">
        {stats.map((stat) => (
          <Link key={stat.label} href={stat.href} className="vp-blog-count">
            <div className="count">{stat.count}</div>
            <div className="label">{stat.label}</div>
          </Link>
        ))}
      </div>

      <div className="vp-social-medias">
        {socialLinks.map((social) => (
          <a
            key={social.name}
            href={social.href}
            className="vp-social-media"
            target="_blank"
            rel="noopener noreferrer"
            aria-label={social.name}
            style={{ color: social.color }}
          >
            {social.icon}
          </a>
        ))}
      </div>

      <div className="vp-sticky-article-wrapper">
        <div className="title">
          <FaFileAlt />
          <span>Artículos Destacados</span>
          <span className="num">{stickyArticles.length}</span>
        </div>
        <ul className="vp-sticky-articles">
          {stickyArticles.map((article, index) => (
            <li key={index} className="vp-sticky-article">
              <Link href={article.href} title={article.title}>
                {article.title}
              </Link>
            </li>
          ))}
        </ul>
      </div>
    </aside>
  );
};
