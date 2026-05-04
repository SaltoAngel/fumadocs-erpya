'use client';

import React from 'react';
import { LuLock } from 'react-icons/lu';
import Link from 'next/link';
import { motion } from 'framer-motion';

interface RestrictedAccessProps {
  requiredRole: string;
}

export function RestrictedAccess({ requiredRole }: RestrictedAccessProps) {
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      className="flex flex-col items-center justify-center min-h-[400px] text-center p-8 bg-fd-background/50 backdrop-blur-sm border border-fd-foreground/10 rounded-3xl shadow-2xl overflow-hidden relative"
    >
      {/* Decorative background elements */}
      <div className="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 bg-red-500/5 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute bottom-0 left-0 -ml-16 -mb-16 w-64 h-64 bg-fd-primary/5 rounded-full blur-3xl pointer-events-none" />

      <div className="p-5 bg-red-500/10 rounded-2xl mb-8 relative">
        <LuLock className="size-12 text-red-500" />
        <div className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 rounded-full animate-pulse" />
      </div>

      <h1 className="text-4xl font-black mb-4 tracking-tight text-fd-foreground">
        Acceso Restringido
      </h1>

      <div className="flex flex-col sm:flex-row gap-4 items-center">
        <Link 
          href="/docs" 
          className="bg-fd-primary text-fd-primary-foreground px-8 py-3 rounded-2xl font-bold hover:scale-105 active:scale-95 transition-all shadow-lg shadow-fd-primary/20"
        >
          Volver al Inicio
        </Link>
        <button 
          onClick={() => window.location.reload()}
          className="text-fd-muted-foreground hover:text-fd-foreground px-8 py-3 rounded-2xl font-medium transition-all"
        >
          Ya tengo permisos, reintentar
        </button>
      </div>

      <div className="mt-12 pt-8 border-t border-fd-foreground/5 w-full max-w-xs">
        <p className="text-xs text-fd-muted-foreground/60 uppercase tracking-[0.2em] font-semibold">
          Seguridad Gestionada por Keycloak
        </p>
      </div>
    </motion.div>
  );
}
