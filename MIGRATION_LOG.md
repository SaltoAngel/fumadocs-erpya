# Migration Log: VuePress to Fumadocs

This document tracks the migration process, decisions made, and corrections applied to the system.

## Project Context
- **Source**: VuePress (docsVue)
- **Target**: React (Fumadocs)
- **Objective**: Modernize the tech stack while preserving the existing design and logic.

## Change History

### 2026-04-28: Initialization & Discovery
- [x] Analyzed existing VuePress project structure.
- [x] Identified "resource" feature in `Releases.vue` (fetching from `adempiere/zk-ui`).
- [x] Updated implementation plan based on user feedback: **No design changes allowed**.
- [x] Initialized Fumadocs project using `create-fumadocs-app`.
- [x] Migrated content from `docsVue/src` to `content/docs`.
- [x] Renamed all `README.md` to `index.mdx`.
- [x] Converted VuePress containers (`::: tip`, etc.) to Fumadocs `<Callout>` using a Python script.
- [x] Replicated `Releases` component in React.
- [x] Migrated public assets (logo, background, images).
- [x] Configured home page to match `BlogHome` layout.
- [x] Fixed Next.js image performance warnings (added `sizes` and fixed aspect ratio).

## System Corrections & Improvements
- **Constraint Applied**: Strictly maintaining the existing CSS/Design.
- **Correction**: Automated conversion of VuePress custom containers to MDX-compatible components.
- **Optimization**: Added `sizes` prop to landing page images to optimize LCP and removed aspect ratio warnings for the logo.
