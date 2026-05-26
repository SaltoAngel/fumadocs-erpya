'use client';

import React, { useEffect } from 'react';

export function CommandCenterDiagram() {
  useEffect(() => {
    const diagram = document.querySelector('.parallax-container') as HTMLElement | null;
    if (diagram) {
      const handleMouseMove = (e: MouseEvent) => {
        const xAxis = (window.innerWidth / 2 - e.pageX) / 40;
        const yAxis = (window.innerHeight / 2 - e.pageY) / 40;
        diagram.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
      };
      window.addEventListener('mousemove', handleMouseMove);
      return () => window.removeEventListener('mousemove', handleMouseMove);
    }
  }, []);

  return (
    <div className="relative h-[600px] flex items-center justify-center w-full parallax-container transition-transform duration-100 ease-out" style={{ perspective: '1000px', transformStyle: 'preserve-3d' }}>
      {/* Central Hub */}
      <div className="relative z-20 group">
        <div className="w-48 h-48 rounded-full glass-panel border-2 border-primary-container/40 flex items-center justify-center p-4 relative">
          <div className="absolute inset-0 bg-primary-container/10 blur-2xl rounded-full"></div>
          <div className="w-full h-full rounded-full border border-primary-container/20 flex items-center justify-center overflow-hidden">
            <img 
              src="data:image/svg+xml,%3csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%207870%207870'%20role='img'%20aria-label='ERPyA'%3e%3cg%20transform='translate(0%207870)%20scale(1%20-1)'%3e%3cpath%20fill='%231AAAD4'%20d='M4141%207101c82-21%20175-64%20249-114%20247-169%20382-492%20324-777-37-187-29-263%2037-346%20165-208%20201-269%20253-424%2046-139%2060-244%2053-394-9-206-78-411-193-575-28-39-330-350-754-776-389-390-722-732-739-758-128-190-146-445-47-654%2088-184%20241-254%20458-209%2099%2020%20225%2020%20324%200%20102-21%20195-14%20272%2021%2050%2023%20132%20101%20650%20618%20326%20326%20606%20612%20622%20637%2057%2091%2072%20188%2045%20310-21%2096-19%20251%205%20346%20125%20499%20665%20746%201122%20514%20198-101%20346-290%20404-515%2023-91%2023-264%201-358-36-147-127-300-239-402-190-172-441-239-697-185-52%2011-116%2020-143%2020-60%200-158-32-212-70-23-16-300-289-617-607-535-536-578-582-597-633-33-92-35-153-12-296%2016-96%2021-151%2016-214-23-335-254-620-575-709-433-120-884%20158-975%20601-22%20104-20%20206%205%20335%2029%20150%2013%20243-56%20333-100%20129-142%20194-186%20285-56%20118-85%20222-101%20363-26%20233%2040%20494%20178%20705%2035%2054%20230%20255%20768%20797%20770%20774%20770%20773%20818%20920%2029%2090%2036%20272%2014%20361-58%20226-202%20370-360%20356-33-3-86-13-116-22-87-27-243-31-354-10-61%2011-120%2016-167%2013-139-9-118%208-791-666-568-569-607-611-626-664-34-93-36-141-12-262%2026-124%2024-263-5-371-58-218-232-421-439-515-113-51-179-64-326-64-124%200-143%203-228%2031-428%20142-654%20598-503%201013%2099%20270%20335%20464%20624%20510%2090%2015%20198%209%20314-16%2071-15%2092-16%20151-5%2038%207%2092%2026%20123%2043%2081%2045%201217%201183%201252%201254%2045%2089%2052%20163%2028%20288-25%20128-27%20230-5%20334%2066%20323%20327%20570%20659%20623%2074%2012%20220%202%20306-20z'/%3e%3cpath%20fill='%230D2167'%20d='M3789%206985c-195-49-357-182-440-360-49-106-63-170-62-285%201-184%2060-327%20188-456%20118-119%20221-171%20386-195%20324-47%20643%20173%20725%20501%2024%2097%2016%20272-19%20368-69%20196-220%20346-417%20413-83%2028-275%2036-361%2014z'/%3e%3cpath%20fill='%230D2167'%20d='M1260%204464c-230-61-407-238-470-468-29-103-25-276%208-376%2053-160%20179-308%20324-379%20110-54%20183-71%20298-72%20126%200%20186%2014%20299%2068%2077%2037%20108%2059%20170%20122%20132%20131%20194%20281%20194%20466%200%20185-62%20335-193%20466-83%2083-192%20145-305%20174-75%2019-251%2019-325-1z'/%3e%3cpath%20fill='%230D2167'%20d='M6297%204465c-218-55-400-231-468-455-33-106-33-264%200-370%2079-259%20305-448%20561-469%20327-27%20599%20149%20701%20454%2020%2059%2024%2090%2024%20200%200%20110-4%20141-24%20200-67%20201-227%20363-421%20427-84%2028-286%2035-373%2013z'/%3e%3cpath%20fill='%230D2167'%20d='M3825%201956c-288-56-499-281-535-573-39-309%20156-611%20455-706%2058-18%2093-22%20205-22%20121%200%20143%203%20208%2027%20103%2037%20175%2083%20251%20159%20126%20126%20182%20255%20189%20439%205%20138-9%20206-67%20325-127%20257-425%20405-706%20351z'/%3e%3c/g%3e%3c/svg%3e" 
              alt="ERPyA Logo" 
              className="w-32 h-32 opacity-90 drop-shadow-[0_0_15px_rgba(26,170,212,0.5)]" 
            />
          </div>
        </div>
      </div>

      {/* Orbiting Nodes (Diagram Style) */}
      <div className="absolute inset-0 border border-white/5 rounded-full scale-125"></div>
      <div className="absolute inset-0 border border-dashed border-white/10 rounded-full scale-90"></div>
      
      {/* Node: Pentaho */}
      <div className="absolute top-10 left-1/4 -translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">bar_chart</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">PENTAHO</span>
      </div>
      
      {/* Node: ADempiere */}
      <div className="absolute -top-4 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">architecture</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">ADEMPIERE</span>
      </div>
      
      {/* Node: Odoo */}
      <div className="absolute top-10 right-1/4 translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">grid_view</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">ODOO</span>
      </div>
      
      {/* Node: Power BI */}
      <div className="absolute top-1/2 -right-4 -translate-y-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">analytics</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">POWER BI</span>
      </div>
      
      {/* Node: Superset (Active Highlighted) */}
      <div className="absolute bottom-10 right-1/4 translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-16 h-16 glass-panel rounded-full flex items-center justify-center border-primary-container node-pulse">
          <span className="material-symbols-outlined text-primary-container" style={{ fontVariationSettings: "'FILL' 1" }}>language</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-primary-container">SUPERSET</span>
      </div>
      
      {/* Node: Docker */}
      <div className="absolute -bottom-4 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">terminal</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">DOCKER</span>
      </div>
      
      {/* Node: K8s */}
      <div className="absolute bottom-10 left-1/4 -translate-x-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">deployed_code</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">K8S</span>
      </div>
      
      {/* Node: N8N */}
      <div className="absolute top-1/2 -left-4 -translate-y-1/2 flex flex-col items-center gap-2 group">
        <div className="w-14 h-14 glass-panel rounded-full flex items-center justify-center group-hover:border-primary-container transition-all duration-300">
          <span className="material-symbols-outlined text-on-surface-variant group-hover:text-primary-container transition-colors">account_tree</span>
        </div>
        <span className="font-micro-label text-[10px] tracking-[0.08em] font-bold text-on-surface-variant opacity-50">N8N</span>
      </div>

      {/* Subtle connecting lines (SVG) */}
      <svg className="absolute inset-0 w-full h-full -z-10 opacity-20 pointer-events-none" viewBox="0 0 600 600">
        <circle cx="300" cy="300" fill="none" r="150" stroke="currentColor" strokeWidth="1"></circle>
        <circle cx="300" cy="300" fill="none" r="240" stroke="currentColor" strokeDasharray="8 8" strokeWidth="1"></circle>
        <line stroke="#1AAAD4" strokeWidth="2" x1="300" x2="430" y1="300" y2="480"></line>
      </svg>
    </div>
  );
}
