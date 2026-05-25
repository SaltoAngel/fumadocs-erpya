'use client';

import { useEffect } from 'react';
import { signIn } from 'next-auth/react';

export default function IframeLoginPage() {
  useEffect(() => {
    // Inicia automáticamente el flujo de login con Keycloak y redirige al callback HTML
    signIn('keycloak', { callbackUrl: '/auth-success.html' });
  }, []);

  return (
    <>
      <style dangerouslySetInnerHTML={{ __html: `
        nav { display: none !important; }
        .pt-\\[60px\\] { padding-top: 0 !important; }
      `}} />
      <div className="flex items-center justify-center h-screen w-full bg-[#0a0a0a]">
        <div className="flex flex-col items-center gap-4">
          <div className="w-8 h-8 border-2 border-white/10 border-t-[#1AAAD4] rounded-full animate-spin"></div>
          <p className="text-zinc-500 text-sm animate-pulse">Conectando con Keycloak...</p>
        </div>
      </div>
    </>
  );
}
