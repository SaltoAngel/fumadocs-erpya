"use client";

import { motion, useSpring } from "framer-motion";
import type React from "react";
import { useRef, useState } from "react";
import { FaGithub } from "react-icons/fa";

interface Leader {
  name: string;
  role: string;
  image: string;
  github: string;
}

const leaders: Leader[] = [
  {
    name: "Carlos Parada",
    role: "Desarrollador / Servicios / Director",
    image: "/docs-assets/ext-19412d7f.png",
    github: "https://github.com/carlosaparadam",
  },
  {
    name: "José Botero",
    role: "Finanzas / Comercial",
    image: "/docs-assets/ext-aff6013f.png",
    github: "https://github.com/jabo6311",
  },
];

function Card({ leader }: { leader: Leader }) {
  const cardRef = useRef<HTMLDivElement>(null);
  const [coords, setCoords] = useState({ x: 0, y: 0 });
  const [isHovered, setIsHovered] = useState(false);

  // Framer Motion spring configuration for ultra-smooth 3D tilt
  const rotateX = useSpring(0, { stiffness: 120, damping: 20 });
  const rotateY = useSpring(0, { stiffness: 120, damping: 20 });

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    if (!cardRef.current) return;
    const rect = cardRef.current.getBoundingClientRect();

    // Mouse position relative to card
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    setCoords({ x, y });

    // Normalize coordinates (-0.5 to 0.5)
    const xc = x / rect.width - 0.5;
    const yc = y / rect.height - 0.5;

    // Calculate rotation angles (max 15 degrees)
    rotateX.set(-yc * 15);
    rotateY.set(xc * 15);
  };

  const handleMouseEnter = () => {
    setIsHovered(true);
  };

  const handleMouseLeave = () => {
    setIsHovered(false);
    rotateX.set(0);
    rotateY.set(0);
  };

  return (
    <div style={{ perspective: "1000px" }} className="w-[230px] h-[310px]">
      <motion.div
        ref={cardRef}
        onMouseMove={handleMouseMove}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        style={{
          rotateX,
          rotateY,
          transformStyle: "preserve-3d",
        }}
        className="relative w-full h-full rounded-2xl border border-fd-border bg-fd-muted/30 dark:bg-fd-muted/10 backdrop-blur-md overflow-hidden transition-all duration-300 hover:shadow-2xl hover:shadow-fd-primary/10 hover:border-fd-primary/30 flex flex-col items-center justify-between p-6 select-none"
      >
        {/* Spotlight / Radial Glow Overlay */}
        <div
          className="absolute inset-0 pointer-events-none transition-opacity duration-300"
          style={{
            opacity: isHovered ? 1 : 0,
            background: `radial-gradient(180px circle at ${coords.x}px ${coords.y}px, rgba(92, 146, 209, 0.18), transparent 80%)`,
          }}
        />

        {/* Top/Front content */}
        <div className="flex flex-col items-center text-center space-y-4 z-10" style={{ transformStyle: "preserve-3d" }}>
          <div 
            className="relative transition-transform duration-300 hover:scale-105"
            style={{ transform: "translateZ(55px)" }}
          >
            {/* biome-ignore lint/performance/noImgElement: Native img element is used to support flexible visual sizing without Next.js layout constraint issues */}
            <img
              src={leader.image}
              alt={leader.name}
              className="w-24 h-24 rounded-full object-cover border-2 border-fd-border shadow-md transition-all duration-300"
            />
          </div>
          <div className="space-y-1" style={{ transform: "translateZ(30px)" }}>
            <h3 className="font-bold text-lg text-fd-foreground leading-tight">
              {leader.name}
            </h3>
            <p className="text-xs text-fd-muted-foreground font-medium">
              {leader.role}
            </p>
          </div>
        </div>

        {/* Bottom content: Social / Action */}
        <div className="w-full flex justify-center z-10" style={{ transform: "translateZ(45px)", transformStyle: "preserve-3d" }}>
          <a
            href={leader.github}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-semibold text-fd-muted-foreground hover:text-fd-primary-foreground bg-fd-muted hover:bg-fd-primary border border-fd-border hover:border-fd-primary shadow-sm hover:shadow-md transition-all duration-300"
          >
            <FaGithub className="w-4 h-4" />
            <span>GitHub</span>
          </a>
        </div>
      </motion.div>
    </div>
  );
}

export function LeaderCards() {
  return (
    <div className="w-full py-8 flex flex-wrap justify-center gap-8 card-container">
      {leaders.map((leader) => (
        <Card key={leader.name} leader={leader} />
      ))}
    </div>
  );
}
