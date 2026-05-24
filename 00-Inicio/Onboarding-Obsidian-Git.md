# Configuración de Obsidian + GitHub

Guía de onboarding para nuevos miembros del equipo.
Tiempo estimado: 5–10 minutos.

## Requisitos previos

- [ ] Tener Git instalado en tu máquina ([git-scm.com](https://git-scm.com))
- [ ] Tener acceso al repositorio `hypenosys/docs` en GitHub
- [ ] Tener Obsidian instalado ([obsidian.md](https://obsidian.md))
- [ ] Estar conectado a la VPN de Tailscale (pide el enlace a Axel por Discord)

## Paso 1 — Clona el repositorio

Abre una terminal y ejecuta:

```bash
# Con HTTPS (necesitarás un Personal Access Token de GitHub)
git clone https://github.com/hypenosys/docs.git

# Con SSH (recomendado si ya tienes SSH configurado con GitHub)
git clone git@github.com:hypenosys/docs.git
```

Colócalo donde quieras, por ejemplo `C:\Proyectos\Hypenosys\docs`
o `~/hypenosys/docs`.

## Paso 2 — Abre la carpeta como vault en Obsidian

1. Abre Obsidian
2. En la pantalla de inicio → **Abrir carpeta como vault**
3. Selecciona la carpeta donde clonaste el repo
4. Acepta confiar en los plugins cuando te lo pregunte

## Paso 3 — Instala el plugin obsidian-git

1. Settings → Community plugins → Desactiva "Restricted mode"
2. Browse → busca **"Git"** (por Vinzent03)
3. Install → Enable

## Paso 4 — Configura el plugin

Ve a Settings → Community plugins → Git y configura:

| Ajuste | Valor recomendado |
|---|---|
| Auto commit-and-sync interval | `10` minutos |
| Auto pull interval | `10` minutos |
| Pull on startup | ✅ Activado |
| Commit message | `vault: {{date}} {{time}} — {{files}}` |
| Merge strategy | `Merge` |

> ⚠️ **Importante:** El plugin no guardará tu token de GitHub
> en el repo (está en `.gitignore`). Tendrás que autenticarte
> la primera vez que hagas push — usa un
> [Personal Access Token](https://github.com/settings/tokens)
> con permisos `repo` si usas HTTPS.

## Paso 5 — Verifica que funciona

Crea una nota de prueba en cualquier carpeta, espera 10 minutos
o usa el comando `Git: Commit-and-sync` desde la paleta de comandos
(Ctrl+P / Cmd+P). Si el icono de la barra lateral no muestra errores,
está todo correcto.

## Flujo de trabajo diario

```
Al abrir Obsidian → pull automático (tienes lo último del equipo)
Trabajas normalmente...
Cada 10 min → commit + push automático
Al cerrar → Ctrl+P → "Git: Commit-and-sync" para forzar un push final
```

## Si hay conflictos

Los conflictos en Markdown son raros pero posibles si dos personas
editan la misma nota al mismo tiempo. obsidian-git los marcará
con los marcadores estándar de Git (`<<<<<<`, `=======`, `>>>>>>>`).
Resuélvelos editando el archivo y quédate con la versión correcta
(o mezcla ambas). Luego haz commit-and-sync de nuevo.

**Truco para evitarlos:** avisa por Discord si vas a hacer una
edición larga en una nota compartida crítica.
