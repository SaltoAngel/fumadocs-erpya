'use client';

import React, { useEffect } from 'react';
import { FaBook, FaDiscord, FaWrench, FaBullhorn, FaXmark } from 'react-icons/fa6';

interface LoginModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export const LoginModal: React.FC<LoginModalProps> = ({ isOpen, onClose, onSuccess }) => {
  useEffect(() => {
    const handleIframeMessage = (event: MessageEvent) => {
      // Seguridad: Validamos que el mensaje venga de nuestro propio origen
      if (event.origin !== window.location.origin) return;

      // Validamos el tipo de mensaje estructurado
      if (event.data && event.data.type === 'KEYCLOAK_LOGIN_SUCCESS') {
        onSuccess();
        onClose();
      }
    };

    if (isOpen) {
      window.addEventListener('message', handleIframeMessage);
    }

    return () => {
      window.removeEventListener('message', handleIframeMessage);
    };
  }, [isOpen, onClose, onSuccess]);

  if (!isOpen) return null;

  // Redirige al iframe a nuestra página interna de auto-login para saltarnos la pantalla de NextAuth
  const loginUrl = `/iframe-login`;

  return (
    <>
      {/* Overlay invisible para cerrar al hacer clic afuera */}
      <div 
        className="fixed inset-0 z-[990]"
        onClick={onClose}
      />
      
      {/* Contenedor Popover */}
      <div 
        className="absolute top-[calc(100%+15px)] right-0 z-[1000] bg-[#0a0a0a] border border-[#e5e5e5] rounded-xl flex flex-col md:flex-row w-[750px] h-[550px] shadow-[0_30px_60px_rgba(0,0,0,0.8)] animate-in fade-in slide-in-from-top-4 duration-300" 
        onClick={(e) => e.stopPropagation()}
      >
        {/* Triángulo superior (flecha) */}
        <div className="absolute -top-[11px] right-[42px] w-[20px] h-[20px] bg-[#0a0a0a] border-t border-l border-[#e5e5e5] transform rotate-45"></div>

        {/* LADO IZQUIERDO: Iframe de Keycloak */}
        <div className="w-full md:w-[50%] h-[60%] md:h-full border-b md:border-b-0 md:border-r border-white/10 relative overflow-hidden rounded-l-xl">
          {/* Overlay loader visual while iframe loads */}
          <div className="absolute inset-0 flex items-center justify-center text-zinc-600 pointer-events-none">
            <div className="w-5 h-5 border-2 border-white/10 border-t-[#1AAAD4] rounded-full animate-spin"></div>
          </div>
          <iframe
            id="keycloak-iframe"
            src={loginUrl}
            title="Keycloak Login"
            scrolling="no"
            className="w-full h-[110%] -mt-[20px] border-none bg-transparent relative z-10"
          />
        </div>

        {/* LADO DERECHO: UI Nativa (Beneficios de Registro) */}
        <div className="w-full md:w-[50%] h-[40%] md:h-full p-8 flex flex-col justify-center rounded-r-xl relative z-10">
          <h3 className="text-white text-lg font-semibold mb-6 tracking-tight">¿Por qué crear una cuenta?</h3>
          
          <ul className="flex flex-col gap-4 mb-8">
            <li className="flex items-center text-zinc-300 text-sm">
              <span className="text-[#1AAAD4] mr-3 font-bold">*</span>
              <span>Es totalmente gratuito</span>
            </li>
            <li className="flex items-center text-zinc-300 text-sm">
              <span className="text-[#1AAAD4] mr-3 font-bold">*</span>
              <span>Accede a Discord privado</span>
            </li>
            <li className="flex items-center text-zinc-300 text-sm">
              <span className="text-[#1AAAD4] mr-3 font-bold">*</span>
              <span>Aprende y comparte en foros</span>
            </li>
            <li className="flex items-center text-zinc-300 text-sm">
              <span className="text-[#1AAAD4] mr-3 font-bold">*</span>
              <span>Entérate de novedades primero</span>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
};
