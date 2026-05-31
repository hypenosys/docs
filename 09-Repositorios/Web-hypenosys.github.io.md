# Informe de Auditoría del Repositorio Hypenosys

## Descripción General del Proyecto
Hypenosys es una plataforma profesional para un estudio de juegos indie, diseñada con una estética elegante, "oscura y morada" (inspirada en Dracula). Sirve como el centro de operaciones central para el estudio, facilitando la gestión de proyectos, el seguimiento financiero y el desarrollo autónomo impulsado por IA.

- **Propósito:** Proporcionar una interfaz unificada para que los miembros del estudio realicen el seguimiento de tareas, gestionen presupuestos e interactúen con agentes de codificación autónomos.
- **Objetivos Principales:** Centralizar las operaciones del estudio, automatizar el mantenimiento del repositorio mediante IA y proporcionar transparencia en la progresión del proyecto.
- **Usuarios Objetivo:** Líderes de estudio, desarrolladores, artistas y diseñadores dentro del estudio Hypenosys.
- **Arquitectura de Alto Nivel:** Un sitio estático construido con Jekyll y alojado en GitHub Pages. Funciona como un "Hub Serverless" donde los archivos del repositorio de GitHub (JSON) actúan como la base de datos, y los Cloudflare Workers gestionan la autenticación.

## Stack Tecnológico
- **Lenguajes:** HTML5, SCSS/CSS (compilado vía Jekyll), JavaScript (ES6+), Ruby (build de Jekyll).
- **Frameworks:**
	- **Jekyll:** Generador de sitios estáticos.
	- **Bootstrap 4.6.0:** Componentes de interfaz de usuario base y diseño.
	- **Tailwind CSS:** Estilizado orientado a utilidades para módulos de dashboard modernos.
- **Librerías:**
	- **jQuery 3.6.0:** Manipulación del DOM y plugins de Bootstrap.
	- **Chart.js:** Visualización de datos para analíticas del estudio y seguimiento de burnout.
	- **FontAwesome 6.5.1:** Iconografía.
	- **Marked.js:** Renderizado de Markdown para los registros de actividad de la IA.
- **Sistemas de Construcción:** Bundler (Ruby), GitHub Pages (Despliegue).
- **Servicios Externos:**
	- **GitHub Content API:** Utilizada como capa de persistencia para datos JSON.
	- **Cloudflare Workers:** Impulsa el proxy OAuth "Gatekeeper" para una autenticación segura de GitHub.
	- **Jules API:** Agente autónomo basado en Google Cloud para la automatización del repositorio.

## Estructura de Directorios

### `_data/`
- **Propósito:** Actúa como la base de datos del proyecto.
- **Contenidos:**
	- `dashboard_tasks.json`: Tareas activas para el tablero Kanban.
	- `dashboard_tasks_archive.json`: Historial de tareas completadas/eliminadas.
	- `studio_stats.json`: Métricas cacheadas (ratios de QA, clasificaciones del Salón de la Fama).
	- `studio_budget.json`: Datos financieros, hitos e índices de burnout.
	- `team_profiles.json` y `team.json`: Metadatos del equipo y perfiles públicos.
	- `tech_stack.json`: Inventario de herramientas del estudio y niveles de maestría.

### `assets/`
- **Propósito:** Activos estáticos y lógica principal del lado del cliente.
- **Contenidos:**
	- `javascript/auth.js`: Gestiona el flujo OAuth y el AuthManager.
	- `javascript/github-api.js`: Motor de transacciones atómicas para la persistencia JSON en GitHub.
	- `javascript/jules-api.js`: Cliente para el agente de IA Jules.
	- `javascript/ui-components.js`: Lógica de renderizado de componentes de UI reutilizables.
	- `main.scss`: Estilo global (tema Dracula).

### `_includes/` y `_layouts/`
- **Propósito:** Sistema de plantillas de Jekyll.
- **Contenidos:** Encabezados de navegación, pies de página, secciones de equipo y diseños de página base.

### `pages/`
- **Propósito:** Páginas de la aplicación con lógica pesada.
- **Contenidos:** `jules-panel.html` (El centro de control de automatización por IA).

## Inventario de Funcionalidades

### Dashboard de Operaciones
- **Descripción:** Interfaz de gestión de proyectos en tiempo real.
- **Componentes:** `dashboard.html`, `dashboard.js`.
- **Flujo de Usuario:** Login -> Ver Kanban -> Mover tareas -> Recomputación automática de estadísticas.
- **Dependencias:** `github-api.js`, `Chart.js`.

### Automatización con Jules IA
- **Descripción:** Agente autónomo que realiza tareas de codificación y crea Pull Requests.
- **Componentes:** `jules-panel.html`, `jules-api.js`.
- **Flujo de Usuario:** Seleccionar Repo -> Introducir Prompt -> Lanzar Sesión -> Aprobar Plan -> Monitorear PR.
- **Dependencias:** `Jules API`, `GitHub API`.

### Changelog Dinámico
- **Descripción:** Sistema de registro de proyectos impulsado por la interfaz de usuario.
- **Componentes:** `CHANGELOG.html`.
- **Flujo de Usuario:** El usuario autenticado rellena el formulario -> `githubApi` realiza una escritura atómica en `CHANGELOG.html`.

### Editor de Perfiles de Equipo
- **Descripción:** Gestión de perfiles de autoservicio para los miembros del estudio.
- **Componentes:** Modales de `auth.js`.
- **Flujo de Usuario:** Login de usuario -> Editar Perfil -> Sincronización con `team_profiles.json` y `team.json`.

## Páginas de la Interfaz de Usuario

| Ruta | Propósito | Componentes | APIs Conectadas |
|---|---|---|---|
| `/` | Landing page | `home.html`, `team_section.html` | Ninguna (Estática) |
| `/dashboard.html` | Operaciones y Kanban | `dashboard.js`, columnas Kanban | GitHub API |
| `/jules-panel/` | Centro de Control de IA | `jules-api.js`, Tarjetas de sesión | Jules API, GitHub API |
| `/CHANGELOG.html` | Historial del Proyecto | `github-api.js` | GitHub API |
| `/tech-stack/` | Inventario de Herramientas | `tech_stack.json` | Ninguna (Estática) |
| `/guia-ue5-svn.html` | Documentación de SVN | Guías manuales | Ninguna |

## Modelo de Datos
- **Mecanismo de Almacenamiento:** Archivos en el directorio `_data/`.
- **Esquemas:** Basados en JSON con un `schema_version: "1.0.0"` explícito.
- **Atomicidad:** El script `github-api.js` implementa un envoltorio `atomicWrite` con lógica de reintentos (`MAX_RETRIES = 4`) y gestión de conflictos 409 para evitar la pérdida de datos durante ediciones concurrentes.

## Autenticación
- **Método de Inicio de Sesión:** GitHub OAuth 2.0.
- **Gatekeeper:** Cloudflare Worker personalizado en `hypenosys-gatekeeper-v2.axlffcc.workers.dev`.
- **Persistencia de Sesión:**
	- `localStorage`: Utilizado para sesiones "Remember Me" (persiste `github_token`).
	- `sessionStorage`: Utilizado para sesiones temporales (persiste `gh_access_token`).
- **Autorización:** Lista blanca (whitelist) codificada en `github-api.js` que asegura que solo los miembros autorizados del estudio puedan modificar los datos.

## Integración con GitHub
- **Interacciones con el Repositorio:** Lectura y escritura de archivos JSON directamente en la rama master.
- **Uso de la API:** `/contents/` para datos, `/user` para validación de autenticación, `/pulls` para monitoreo.
- **Workflows:**
	- `enforce-changelog.yml`: Asegura que cada PR incluya una entrada en el changelog.
- **Automatización:** Recomputación automática de `studio_stats.json` cada vez que se actualiza una tarea en el dashboard.

## Módulos del Dashboard

### Tablero Kanban
- **Propósito:** Gestión del ciclo de vida de las tareas.
- **Entradas:** Detalles de la tarea (Descripción, Prioridad, Hito).
- **Salidas:** `dashboard_tasks.json` actualizado.

### Analíticas de QA
- **Propósito:** Monitorear la salud del proyecto y la velocidad del equipo.
- **Entradas:** `dashboard_tasks.json`.
- **Salidas:** `studio_stats.json`, clasificaciones del Salón de la Fama.

### Índice de Burnout
- **Propósito:** Monitoreo del estrés basado en los plazos de los hitos y la presión de las tareas.
- **Dependencias:** `studio_budget.json`, `dashboard_tasks.json`.

## Sistemas de Automatización
- **Recomputación de Estadísticas:** Activada en `github-api.js` tras cualquier actualización exitosa de tareas.
- **Agentes Jules:** Procesos en segundo plano en Google Cloud que interactúan con el repositorio.
- **Cumplimiento del Changelog:** GitHub Action que bloquea los PR que no tienen actualizaciones en el changelog.

## Integración de Jules
- **Paneles:** El archivo dedicado `jules-panel.html` proporciona una experiencia sofisticada similar a un IDE.
- **Monitoreo:** Registros de actividad en tiempo real con renderizado de Markdown y un diff-viewer para los cambios de código.
- **Gestión de Sesiones:**
	- **Cementerio:** Almacenamiento local para sesiones pausadas o fallidas.
	- **Archivo:** Gestión de sesiones concluidas.
- **Acciones Autónomas:** Jules puede leer de forma autónoma el contexto del repositorio, planificar cambios, ejecutar código y abrir PRs.

## Infraestructura
- **Modelo de Despliegue:** Sitio estático respaldado por Git.
- **Alojamiento:** GitHub Pages.
- **CI/CD:** GitHub Actions.
- **Monitoreo:** Visualizadores basados en el dashboard para la salud del proyecto y financiera.

## Revisión de Seguridad
- **Autenticación:** Implementación robusta de OAuth utilizando el patrón Gatekeeper.
- **Autorización:** Control de acceso basado en listas blancas (Codificado en JS).
- **Manejo de Secretos:** Las claves de API de Jules se almacenan en el localStorage del navegador.
- **Riesgos Potenciales:**
	- La lista blanca es del lado del cliente (aunque los permisos de la API de GitHub proporcionan la capa de seguridad real).
	- Las claves de API en localStorage son vulnerables a XSS si se inyectara un script malicioso.

## Deuda Técnica
- **Duplicación de Datos:** Los datos de los miembros están duplicados entre `team.json` y `team_profiles.json`, lo que requiere una lógica de sincronización compleja.
- **Hibridación de CSS:** La coexistencia de Bootstrap 4 y Tailwind CSS crea cierta redundancia en las hojas de estilo.
- **Configuraciones Codificadas:** Varias rutas de repositorio y listas blancas de usuarios están codificadas en los archivos JavaScript en lugar de obtenerse de `_config.yml`.

## Resumen del Repositorio
El repositorio de Hypenosys es un ejemplo sofisticado de una arquitectura de "Dashboard Serverless". Al utilizar Jekyll para la interfaz de usuario y la API de contenido de GitHub para la persistencia de datos, el estudio ha creado un centro operativo de alta utilidad y bajo coste. La profunda integración con el agente de IA Jules demuestra un enfoque innovador hacia la ingeniería de software autónoma y la gestión de repositorios.