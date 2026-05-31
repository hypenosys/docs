# 📚 Docs — Base de conocimiento del proyecto

Bienvenido al repositorio-vertedero de documentación. Si estás leyendo esto, enhorabuena: ya superaste el primer obstáculo. Los que no llegaron hasta aquí probablemente siguen buscando el archivo en el escritorio.

---

## ¿Qué es esto?

Este repositorio contiene toda la documentación del proyecto: diseño, worldbuilding, producción, arte, dev y todo lo demás que no cabe en una nota de Slack que nadie leerá.

Usamos **Obsidian** para editar y **Git** para sincronizar. Sí, Git. No, no es opcional. Sí, vale la pena aprenderlo.

---

## Requisitos

- [Obsidian](https://obsidian.md/download) instalado (desktop)
- Una cuenta de GitHub con acceso al repositorio `hypenosys/docs`
- Un Personal Access Token (PAT) de GitHub — se explica abajo
- Aproximadamente 10 minutos de tu vida que no recuperarás, pero que ahorrarán horas en el futuro

---

## Instalación paso a paso

### 1. Clona el repositorio

Abre una terminal y ejecuta:

```bash
git clone https://github.com/hypenosys/docs tu-carpeta-local
```

Cambia `tu-carpeta-local` por donde quieras tenerlo. Si no sabes dónde, usa `~/Documents/docs`. Si no tienes terminal, instala Git: [git-scm.com](https://git-scm.com).

---

### 2. Abre la carpeta como bóveda en Obsidian

1. Abre Obsidian
2. Haz clic en el icono de bóveda (abajo a la izquierda)
3. **"Abrir carpeta como bóveda"**
4. Selecciona la carpeta que clonaste
5. Obsidian cargará todo el contenido. Sí, esas carpetas son las notas. No hay truco.

---

### 3. Activa los plugins de comunidad

1. **Configuración** (⚙️) → **Plugins de comunidad**
2. Desactiva el **Modo restringido**
3. Confirma que entiendes que los plugins de comunidad no están auditados por Obsidian (lo entiendes)

---

### 4. Instala el plugin Git

1. En **Plugins de comunidad** → **Explorar**
2. Busca `Git` (autor: Vinzent03)
3. **Instalar** → **Activar**

Si no aparece en la lista, instálalo manualmente: descarga `main.js`, `manifest.json` y `styles.css` del [último release](https://github.com/Vinzent03/obsidian-git/releases/latest) y colócalos en `.obsidian/plugins/obsidian-git/`.

---

### 5. Crea tu Personal Access Token en GitHub

GitHub ya no acepta contraseñas normales para operaciones Git. Necesitas un token. Es como una contraseña, pero más larga y con menos dignidad.

1. Ve a [github.com](https://github.com) → tu foto de perfil → **Settings**
2. Baja hasta **Developer settings** (último ítem del menú lateral)
3. **Personal access tokens** → **Fine-grained tokens** → **Generate new token**
4. Configura:
   - **Nombre**: algo descriptivo (ej. `obsidian-docs`)
   - **Expiración**: la que prefieras (90 días es razonable)
   - **Repository access**: Solo `hypenosys/docs`
   - **Permissions → Contents**: `Read and Write`
5. **Generate token**
6. **Copia el token ahora.** GitHub no te lo volverá a mostrar. No hay segunda oportunidad. Guárdalo en un lugar seguro.

---

### 6. Configura el plugin Git en Obsidian

Ve a **Configuración** → **Git** y ajusta lo siguiente:

#### Automatización
| Ajuste | Valor |
|---|---|
| Auto commit-and-sync interval | `10` (minutos) |
| Auto pull interval | `10` (minutos) |
| Pull on startup | ✅ activado |
| Push on commit-and-sync | ✅ activado |
| Pull on commit-and-sync | ✅ activado |

#### Commit Author
| Ajuste | Valor |
|---|---|
| Author name | Tu nombre real (aparecerá en el historial) |
| Author email | El email de tu cuenta de GitHub |

#### Authentication
| Ajuste | Valor |
|---|---|
| Username | Tu usuario de GitHub |
| Password / Personal Access Token | El token que copiaste en el paso anterior |

---

## Uso diario

Una vez configurado, el plugin se encarga de todo automáticamente cada 10 minutos.

Si quieres sincronizar manualmente: `Ctrl+P` → escribe `git` → selecciona **Commit-and-sync**.

Esto hace en orden: guardar cambios → commit → pull → push. Si hay conflictos, Git te avisará. Si no sabes qué hacer con un conflicto de Git, pregunta a alguien del equipo antes de hacer algo que parezca razonable pero no lo sea.

---

## Estructura del repositorio

```
docs/
├── 00-Inicio/          # Por aquí se empieza
├── 01-Worldbuilding/   # Lore, mundo, historia
├── 02-Diseño-de-juego/ # Mecánicas, sistemas, reglas
├── 03-Arte/            # Referencias, guías de estilo
├── 04-Dev/             # Documentación técnica
├── 05-Audio/           # Música, SFX, diseño sonoro
├── 06-Produccion/      # Roadmap, sprints, milestones
├── 07-Assets-y-Recursos/
├── 08-Archivo/         # Lo que ya no está activo pero no tiramos
├── 09-Repositorios/    # Documentación de los repositorios de Hypenosys
├── Attachments/        # Imágenes y archivos adjuntos
└── Templates/          # Plantillas reutilizables
```

---

## Problemas frecuentes

**"Git is not ready"**
El vault no está abierto sobre la carpeta del repositorio. Asegúrate de que la bóveda de Obsidian apunta a la carpeta que clonaste (la que contiene `.git`).

**Error al hacer push**
Probablemente el token expiró o no tiene permisos de escritura. Genera uno nuevo y actualízalo en la configuración del plugin.

**Conflictos al hacer pull**
Alguien editó el mismo archivo que tú al mismo tiempo. Hablar con el equipo antes de editar es una funcionalidad que Git no puede implementar por ti.

**Pantalla negra en la versión web (Selkies)**
Añade `shm_size: "1gb"` al docker-compose del contenedor. Si no sabes qué es eso, pide ayuda a quien gestiona la infraestructura.

---

## Buenas prácticas

- **No guardes información sensible** en este repositorio (contraseñas, tokens, datos personales)
- **Usa las plantillas** de la carpeta `Templates/` para nuevas notas
- **Pon las imágenes** en `Attachments/` o en la subcarpeta correspondiente al área
- **Escribe en español** salvo que el contexto técnico lo requiera en inglés
- **Haz sync antes de empezar a editar** para evitar conflictos innecesarios

---

*Si algo no funciona y este documento no lo cubre, probablemente sea culpa de Git. O de la humanidad en general.*
