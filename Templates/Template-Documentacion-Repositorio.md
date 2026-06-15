---
title: "{{title}}"
status: borrador
author: "{{author}}"
created: "{{date}}"
updated: "{{date}}"
version: 0.1
tags: [dev, repo, guia]
area: "09-Repositorios"
owner: "{{author}}"
related: []
---

# 💾 Repo: [Nombre del Repositorio]

*Todo lo que necesitas saber para no romper la rama principal y que el resto del equipo te odie.*

## 1. Propósito
*¿Qué vive en este repositorio?*
[Ej: Código fuente del cliente, Herramientas internas, Web del estudio].

## 2. Configuración del Entorno
- **Requisitos previos:** [Node.js, .NET, Python, etc.].
- **Instalación:**
  ```bash
  git clone [url]
  npm install # o lo que toque
  ```
- **Variables de Entorno:** [Copia el .env.example si existe].

## 3. Flujo de Git (Workflow)
- **Rama principal:** `main` (siempre estable).
- **Ramas de desarrollo:** `dev`.
- **Nomenclatura de ramas:** `feat/[nombre]`, `fix/[nombre]`, `hotfix/[nombre]`.
- **Pull Requests:** Requisitos para mergear (Review, tests pasando).

## 4. Comandos Útiles
- `npm start`: Inicia el proyecto en local.
- `npm test`: Ejecuta la suite de tests.
- `npm build`: Genera la versión de producción.

## 5. Estructura de Carpetas
- `/src`: Código fuente.
- `/public`: Archivos estáticos.
- `/tests`: Pruebas unitarias/integración.

## 6. Despliegue (Deployment)
*¿Cómo llega esto al mundo real?*
[Instrucciones de CI/CD, servidores, etc.].

---
### Checklist de Repositorio
- [ ] ¿El README.md del repo real está actualizado?
- [ ] ¿Hay un `.gitignore` decente?
- [ ] ¿Están claras las dependencias externas?
