---
title: erpya-3.9.4-001-3.8.0
role: public
icon: podcast
category: Actualizaciones
star: 9
sticky: 9
tag:
  - "Actualizaciones"
  - "Versiones"
  - "erpya-3.9.4-001-3.8.0"
  - "2026-01-23"
article: true
---

**Fecha de Liberación:** 2026-01-23

## Novedades

- **Ampliación de cobertura bancaria con loaders para Bancamiga, Tesoro y Provincial CSV**

## Contexto

Actualización del ecosistema de conciliación bancaria para bancos nacionales venezolanos.

### Bancos Incorporados / Actualizados:

| Banco                      | Clase Loader              |
| -------------------------- | ------------------------- |
| **Bancamiga**              | Bancamiga_XLS_Loader      |
| **Banco del Tesoro**       | BancoDelTesoro_XLS_Loader |
| **Banco Provincial (CSV)** | Provincial_CSV_Loader     |

### Mejoras Técnicas:

- **Infraestructura**: Alineación con Apache POI 5.x para un manejo de celdas más moderno y eficiente.
- **Normalización**: Estandarización centralizada de fechas y referencias numéricas para asegurar importaciones predecibles y reducir la intervención manual en conciliaciones.

## Requerimientos

- No se requieren procesos adicionales por aplicar.
