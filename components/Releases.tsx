'use client';

import React, { useEffect, useState } from 'react';

interface Release {
  html_url: string;
  name: string;
  published_at: string;
  assets: {
    browser_download_url: string;
    name: string;
  }[];
}

export function Releases() {
  const [releases, setReleases] = useState<Release[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('https://api.github.com/repos/adempiere/zk-ui/releases')
      .then((res) => res.json())
      .then((data) => {
        if (Array.isArray(data)) {
          setReleases(data);
        }
        setLoading(false);
      })
      .catch((err) => {
        console.error('Error fetching releases:', err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <p>Cargando versiones...</p>;
  }

  return (
    <div className="space-y-6">
      {releases.map((release) => (
        <div key={release.html_url} className="border-b pb-4">
          <h3 className="text-xl font-bold">
            <a
              href={release.html_url}
              target="_blank"
              rel="noopener noreferrer"
              className="text-primary hover:underline"
            >
              {release.name} ({new Date(release.published_at).toLocaleDateString('es-ES', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
              })})
            </a>
          </h3>
          <ul className="list-disc list-inside mt-2">
            {release.assets.map((asset) => (
              <li key={asset.browser_download_url}>
                <a
                  href={asset.browser_download_url}
                  className="text-sm text-muted-foreground hover:text-foreground"
                >
                  {asset.name}
                </a>
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  );
}
