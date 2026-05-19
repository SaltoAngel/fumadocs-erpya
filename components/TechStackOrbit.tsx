'use client';

import React, { useState, useEffect, useRef } from 'react';

export function TechStackOrbit() {
  const [activeIndex, setActiveIndex] = useState<number>(0);
  const timerRef = useRef<NodeJS.Timeout | null>(null);

  // Auto-rotate clockwise (0 -> 7) every 5 seconds
  const startRotation = () => {
    stopRotation();
    timerRef.current = setInterval(() => {
      setActiveIndex((prev) => (prev + 1) % 8);
    }, 2000);
  };

  const stopRotation = () => {
    if (timerRef.current) {
      clearInterval(timerRef.current);
    }
  };

  useEffect(() => {
    startRotation();
    return () => stopRotation();
  }, []);

  const handleMouseEnterNode = (index: number) => {
    stopRotation();
    setActiveIndex(index);
  };

  const handleMouseLeaveNode = () => {
    startRotation();
  };

  // Helper functions to get dynamic properties for lines, nodes and labels
  const getLineProps = (index: number, xn: number, yn: number) => {
    const isActive = activeIndex === index;
    // Detiene la línea en el borde del círculo del nodo (radio 7.5, distancia total 34)
    const ratio = 26.5 / 34;
    const x2 = 50 + (xn - 50) * ratio;
    const y2 = 50 + (yn - 50) * ratio;
    
    return {
      x1: "50",
      y1: "50",
      x2: x2.toString(),
      y2: y2.toString(),
      stroke: isActive ? "#5BC8E5" : "rgba(255,255,255,0.14)",
      strokeWidth: isActive ? "0.75" : "0.32",
      strokeDasharray: isActive ? "none" : "1.7 2.2",
      strokeLinecap: "round" as const,
      style: {
        transition: "stroke 0.4s, stroke-width 0.4s, opacity 0.4s",
      }
    };
  };

  const getNodeCircleProps = (index: number, cx: string, cy: string) => {
    const isActive = activeIndex === index;
    return {
      cx,
      cy,
      r: "7.5",
      fill: "url(#nodeFill)",
      stroke: isActive ? "#5BC8E5" : "rgba(255,255,255,0.28)",
      strokeWidth: isActive ? "0.95" : "0.45",
      filter: "url(#softShadow)",
      style: {
        transition: "fill 0.4s, stroke 0.4s",
      }
    };
  };

  const getIconStyle = (index: number) => {
    const isActive = activeIndex === index;
    return {
      color: isActive ? "rgb(26, 170, 212)" : "rgba(255, 255, 255, 0.55)",
      transition: "color 0.4s",
    };
  };

  const getTextProps = (index: number, x: string, y: string) => {
    const isActive = activeIndex === index;
    return {
      x,
      y,
      textAnchor: "middle" as const,
      dominantBaseline: "middle" as const,
      fontSize: "3.2",
      fontWeight: isActive ? "700" : "400",
      fill: isActive ? "#1AAAD4" : "rgba(255,255,255,0.45)",
      fontFamily: "Inter,sans-serif",
      style: {
        transition: "fill 0.4s, font-weight 0.4s",
      }
    };
  };

  return (
    <div className="mx-auto h-[320px] w-full max-w-[380px] sm:h-[380px] lg:h-[430px] lg:max-w-none relative select-none">
      <svg viewBox="0 0 100 100" className="w-full h-full drop-shadow-[0_28px_50px_rgba(0,0,0,0.22)]">
        <defs>
          <radialGradient id="ecglow" cx="50%" cy="50%" r="50%">
            <stop offset="0%" stopColor="#5BC8E5" stopOpacity="0.38"></stop>
            <stop offset="48%" stopColor="#1AAAD4" stopOpacity="0.12"></stop>
            <stop offset="100%" stopColor="#1AAAD4" stopOpacity="0"></stop>
          </radialGradient>
          <linearGradient id="nodeFill" x1="0%" x2="100%" y1="0%" y2="100%">
            <stop offset="0%" stopColor="#ffffff" stopOpacity="0.18"></stop>
            <stop offset="100%" stopColor="#ffffff" stopOpacity="0.05"></stop>
          </linearGradient>
          <filter id="ecblur">
            <feGaussianBlur stdDeviation="1.6"></feGaussianBlur>
          </filter>
          <filter id="softShadow" x="-40%" y="-40%" width="180%" height="180%">
            <feDropShadow dx="0" dy="1.4" stdDeviation="2.6" floodColor="#020617" floodOpacity="0.34"></feDropShadow>
          </filter>
          <clipPath id="logoClip">
            <circle cx="50" cy="50" r="13.6"></circle>
          </clipPath>
        </defs>

        {/* Outer and Inner Orbit Circles */}
        <circle cx="50" cy="50" r="42" fill="url(#ecglow)"></circle>
        <circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.10)" strokeWidth="0.35" strokeDasharray="1.8 2.6"></circle>
        <circle cx="50" cy="50" r="26" fill="none" stroke="#1AAAD435" strokeWidth="0.35"></circle>

        {/* Dynamic Connecting Lines */}
        <line {...getLineProps(0, 50, 16)} />
        <line {...getLineProps(1, 74.04163056034261, 25.95836943965738)} />
        <line {...getLineProps(2, 84, 50)} />
        <line {...getLineProps(3, 74.04163056034261, 74.04163056034261)} />
        <line {...getLineProps(4, 50, 84)} />
        <line {...getLineProps(5, 25.958369439657385, 74.04163056034261)} />
        <line {...getLineProps(6, 16, 50)} />
        <line {...getLineProps(7, 25.95836943965738, 25.958369439657385)} />

        {/* Active Node Outer Glowing Circles */}
        {activeIndex === 0 && <circle cx="49.99999999999999" cy="16" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 1 && <circle cx="74.04163056034261" cy="25.95836943965738" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 2 && <circle cx="84" cy="50" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 3 && <circle cx="74.04163056034261" cy="74.04163056034261" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 4 && <circle cx="50" cy="84" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 5 && <circle cx="25.958369439657385" cy="74.04163056034261" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 6 && <circle cx="16" cy="50.00000000000001" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}
        {activeIndex === 7 && <circle cx="25.95836943965738" cy="25.958369439657385" r="11.8" fill="#1AAAD438" filter="url(#ecblur)"></circle>}

        {/* 1. ADempiere Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(0)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(0, "49.99999999999999", "16")} />
          <svg x="44.99999999999999" y="11" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(0)}>
            <path d="M3 3v18h18M3 12h9M12 3v9" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" fill="none"></path>
          </svg>
          <text {...getTextProps(0, "49.99999999999999", "5")}>ADempiere</text>
        </g>

        {/* 2. Odoo Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(1)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(1, "74.04163056034261", "25.95836943965738")} />
          <svg x="69.04163056034261" y="20.95836943965738" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(1)}>
            <rect x="3" y="3" width="8" height="8" rx="1.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="13" y="3" width="8" height="8" rx="1.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="3" y="13" width="8" height="8" rx="1.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="13" y="13" width="8" height="8" rx="1.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
          </svg>
          <text {...getTextProps(1, "81.81980515339463", "18.180194846605353")}>Odoo</text>
        </g>

        {/* 3. Power BI Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(2)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(2, "84", "50")} />
          <svg x="79" y="45" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(2)}>
            <rect x="2" y="10" width="4" height="11" rx="1" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="9" y="6" width="4" height="15" rx="1" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="16" y="2" width="4" height="19" rx="1" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
          </svg>
          <text {...getTextProps(2, "95", "50")}>Power BI</text>
        </g>

        {/* 4. Superset Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(3)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(3, "74.04163056034261", "74.04163056034261")} />
          <svg x="69.04163056034261" y="69.04163056034261" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(3)}>
            <circle cx="12" cy="12" r="9" stroke="currentColor" strokeWidth="1.5" fill="none"></circle>
            <path d="M12 3c2.5 2.5 4 5.5 4 9s-1.5 6.5-4 9M12 3c-2.5 2.5-4 5.5-4 9s1.5 6.5 4 9M3 12h18" stroke="currentColor" strokeWidth="1.5" fill="none"></path>
          </svg>
          <text {...getTextProps(3, "81.81980515339464", "81.81980515339464")}>Superset</text>
        </g>

        {/* 5. Docker Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(4)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(4, "50", "84")} />
          <svg x="45" y="79" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(4)}>
            {/* Whale outline and tail */}
            <path d="M2 13.5h16.5c1.2 0 2.5-1 3-2.5.3 1.2-.5 2.5-2 3H3c-1.5 0-1.5-2 0-2H5c.5-2 2-3 4-2.5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" fill="none" />
            <path d="M4 13.5c0 3 2 5 7.5 5s8.5-3 8.5-5" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" fill="none" />
            {/* Stacked Containers */}
            <rect x="5.5" y="7.5" width="2" height="2" rx="0.3" stroke="currentColor" strokeWidth="1.2" fill="none" />
            <rect x="8.5" y="7.5" width="2" height="2" rx="0.3" stroke="currentColor" strokeWidth="1.2" fill="none" />
            <rect x="11.5" y="7.5" width="2" height="2" rx="0.3" stroke="currentColor" strokeWidth="1.2" fill="none" />
            <rect x="7" y="4.5" width="2" height="2" rx="0.3" stroke="currentColor" strokeWidth="1.2" fill="none" />
            <rect x="10" y="4.5" width="2" height="2" rx="0.3" stroke="currentColor" strokeWidth="1.2" fill="none" />
          </svg>
          <text {...getTextProps(4, "50", "95")}>Docker</text>
        </g>

        {/* 6. K8s Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(5)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(5, "25.958369439657385", "74.04163056034261")} />
          <svg x="20.958369439657385" y="69.04163056034261" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(5)}>
            <polygon points="12,2 22,8.5 22,15.5 12,22 2,15.5 2,8.5" stroke="currentColor" strokeWidth="1.5" fill="none"></polygon>
            <line x1="12" y1="2" x2="12" y2="22" stroke="currentColor" strokeWidth="1" opacity="0.5"></line>
            <line x1="2" y1="8.5" x2="22" y2="15.5" stroke="currentColor" strokeWidth="1" opacity="0.5"></line>
            <line x1="22" y1="8.5" x2="2" y2="15.5" stroke="currentColor" strokeWidth="1" opacity="0.5"></line>
          </svg>
          <text {...getTextProps(5, "18.180194846605364", "81.81980515339464")}>K8s</text>
        </g>

        {/* 7. N8N Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(6)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(6, "16", "50.00000000000001")} />
          <svg x="11" y="45.00000000000001" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(6)}>
            <circle cx="5" cy="12" r="2.5" stroke="currentColor" strokeWidth="1.5" fill="none"></circle>
            <circle cx="19" cy="6" r="2.5" stroke="currentColor" strokeWidth="1.5" fill="none"></circle>
            <circle cx="19" cy="18" r="2.5" stroke="currentColor" strokeWidth="1.5" fill="none"></circle>
            <path d="M7.5 12h4l2-6h3M7.5 12h4l2 6h3" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" fill="none"></path>
          </svg>
          <text {...getTextProps(6, "5", "50.00000000000001")}>N8N</text>
        </g>

        {/* 8. Pentaho Node */}
        <g 
          className="cursor-pointer" 
          onMouseEnter={() => handleMouseEnterNode(7)} 
          onMouseLeave={handleMouseLeaveNode}
        >
          <circle {...getNodeCircleProps(7, "25.95836943965738", "25.958369439657385")} />
          <svg x="20.95836943965738" y="20.958369439657385" width="10" height="10" viewBox="0 0 24 24" style={getIconStyle(7)}>
            <path d="M3 3v18h18" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" fill="none"></path>
            <rect x="6" y="11" width="3" height="7" rx="0.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
            <rect x="12" y="7" width="3" height="11" rx="0.5" stroke="currentColor" strokeWidth="1.5" fill="none"></rect>
          </svg>
          <text {...getTextProps(7, "18.180194846605353", "18.180194846605364")}>Pentaho</text>
        </g>

        {/* Central Core (glowing logo) */}
        <g filter="url(#softShadow)">
          <circle cx="50" cy="50" r="17.2" fill="rgba(9, 24, 83, 0.58)" stroke="rgba(255,255,255,0.18)" strokeWidth="0.45"></circle>
          <circle cx="50" cy="50" r="14.4" fill="#0D2167" stroke="#5BC8E5" strokeWidth="0.65"></circle>
          <image 
            href="data:image/svg+xml,%3csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%207870%207870'%20role='img'%20aria-label='ERPyA'%3e%3cg%20transform='translate(0%207870)%20scale(1%20-1)'%3e%3cpath%20fill='%231AAAD4'%20d='M4141%207101c82-21%20175-64%20249-114%20247-169%20382-492%20324-777-37-187-29-263%2037-346%20165-208%20201-269%20253-424%2046-139%2060-244%2053-394-9-206-78-411-193-575-28-39-330-350-754-776-389-390-722-732-739-758-128-190-146-445-47-654%2088-184%20241-254%20458-209%2099%2020%20225%2020%20324%200%20102-21%20195-14%20272%2021%2050%2023%20132%20101%20650%20618%20326%20326%20606%20612%20622%20637%2057%2091%2072%20188%2045%20310-21%2096-19%20251%205%20346%20125%20499%20665%20746%201122%20514%20198-101%20346-290%20404-515%2023-91%2023-264%201-358-36-147-127-300-239-402-190-172-441-239-697-185-52%2011-116%2020-143%2020-60%200-158-32-212-70-23-16-300-289-617-607-535-536-578-582-597-633-33-92-35-153-12-296%2016-96%2021-151%2016-214-23-335-254-620-575-709-433-120-884%20158-975%20601-22%20104-20%20206%205%20335%2029%20150%2013%20243-56%20333-100%20129-142%20194-186%20285-56%20118-85%20222-101%20363-26%20233%2040%20494%20178%20705%2035%2054%20230%20255%20768%20797%20770%20774%20770%20773%20818%20920%2029%2090%2036%20272%2014%20361-58%20226-202%20370-360%20356-33-3-86-13-116-22-87-27-243-31-354-10-61%2011-120%2016-167%2013-139-9-118%208-791-666-568-569-607-611-626-664-34-93-36-141-12-262%2026-124%2024-263-5-371-58-218-232-421-439-515-113-51-179-64-326-64-124%200-143%203-228%2031-428%20142-654%20598-503%201013%2099%20270%20335%20464%20624%20510%2090%2015%20198%209%20314-16%2071-15%2092-16%20151-5%2038%207%2092%2026%20123%2043%2081%2045%201217%201183%201252%201254%2045%2089%2052%20163%2028%20288-25%20128-27%20230-5%20334%2066%20323%20327%20570%20659%20623%2074%2012%20220%202%20306-20z'/%3e%3cpath%20fill='%230D2167'%20d='M3789%206985c-195-49-357-182-440-360-49-106-63-170-62-285%201-184%2060-327%20188-456%20118-119%20221-171%20386-195%20324-47%20643%20173%20725%20501%2024%2097%2016%20272-19%20368-69%20196-220%20346-417%20413-83%2028-275%2036-361%2014z'/%3e%3cpath%20fill='%230D2167'%20d='M1260%204464c-230-61-407-238-470-468-29-103-25-276%208-376%2053-160%20179-308%20324-379%20110-54%20183-71%20298-72%20126%200%20186%2014%20299%2068%2077%2037%20108%2059%20170%20122%20132%20131%20194%20281%20194%20466%200%20185-62%20335-193%20466-83%2083-192%20145-305%20174-75%2019-251%2019-325-1z'/%3e%3cpath%20fill='%230D2167'%20d='M6297%204465c-218-55-400-231-468-455-33-106-33-264%200-370%2079-259%20305-448%20561-469%20327-27%20599%20149%20701%20454%2020%2059%2024%2090%2024%20200%200%20110-4%20141-24%20200-67%20201-227%20363-421%20427-84%2028-286%2035-373%2013z'/%3e%3cpath%20fill='%230D2167'%20d='M3825%201956c-288-56-499-281-535-573-39-309%20156-611%20455-706%2058-18%2093-22%20205-22%20121%200%20143%203%20208%2027%20103%2037%20175%2083%20251%20159%20126%20126%20182%20255%20189%20439%205%20138-9%20206-67%20325-127%20257-425%20405-706%20351z'/%3e%3c/g%3e%3c/svg%3e" 
            x="38.2" 
            y="38.2" 
            width="23.6" 
            height="23.6" 
            clipPath="url(#logoClip)" 
            preserveAspectRatio="xMidYMid meet"
          />
        </g>
      </svg>
    </div>
  );
}
