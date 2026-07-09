---
title: "Cognito Agent - Guía de uso diario"
status: finalizado
author: "Jules"
created: "2025-05-15"
updated: "2025-05-15"
version: 1.0
tags: [dev, repo, guia, ia, cognito, agent]
area: "09-Repositorios"
owner: "Tech Lead"
related: ["[[09-Repositorios/Backend-IA|Backend Local IA]]", "[[INDEX|Índice Maestro]]"]
---

# Cognito Agent — Guía de uso diario

Referencia rápida para empezar a usarlo en el día a día, tras las 5 fases mergeadas.

---

## 0. Antes de la primera vez: fijar trust manualmente

**Hueco conocido:** no existe todavía un comando CLI ni un endpoint para marcar un repo como confiado — solo los métodos Python `ProjectTrustStore.set_trusted()`/`set_extensions_trusted()`. Hasta que eso exista (ver nota al final), edita `~/.cognito/trust.json` a mano:

```json
{
  "/ruta/absoluta/resuelta/a/hypenosys.github.io": {"project": true, "extensions": false},
  "/ruta/absoluta/resuelta/a/tc": {"project": true, "extensions": false}
}
```

**Importante:** la ruta debe ser exactamente la que devuelve `realpath <ruta>` (o `readlink -f <ruta>`), porque el trust se compara contra la ruta ya resuelta (symlinks incluidos). Si copias la ruta a mano y no coincide, el gate falla en silencio y todo se comporta como "no confiado".

Deja `extensions: false` salvo que quieras probar extensiones locales de ese repo — son dos flags independientes a propósito (Fase 4).

---

## 1. Uso diario por CLI

Alias recomendado (ajusta la ruta a donde tengas `very-simplified-stack/cognito-backend/`):

```bash
# ~/.bashrc o ~/.zshrc
cog-agent() {
    (cd /ruta/a/very-simplified-stack/cognito-backend && \
     python -m cli.cognito_cli "$1" --cwd "$OLDPWD" --session-id latest)
}
```

Uso: desde dentro de cualquier repo, `cog-agent "arréglame este bug en X"`. Continúa automáticamente la última sesión de ese `cwd` (Fase 2).

Otros patrones:
```bash
# One-shot sin continuar sesión (fuerza una nueva)
python -m cli.cognito_cli "resume qué hace este archivo" --cwd .

# Pipe de un fichero como prompt
cat script.py | python -m cli.cognito_cli --cwd .

# Ver sesiones de un repo
# (vía HTTP directo, no hay subcomando CLI para esto todavía)
curl "http://localhost:8000/api/agent/sessions?cwd=$(realpath .)"
```

---

## 2. Cómo leer la incertidumbre

En modo `print`, el texto se colorea azul → ámbar → rojo según confianza (más rojo = el modelo está más "inseguro" de su propia salida, vía entropía de Shannon). Ajustable con `--threshold` o `COGNITO_COLOR_MODE=full|threshold|none`. Si un backend no devuelve logprobs (algunos modelos/backends OpenAI-compat), simplemente no verás color — no es un fallo.

---

## 3. Cosas a tener en cuenta

- **Archivos protegidos** (`auth.js`, `github-api.js`, `dashboard-data.js`, `dashboard.html`) se rechazan siempre en `write`/`edit`, con `extensions`/`project` trust en `True` o no. Es el comportamiento esperado, no lo reportes como bug.
- **El escalado por incertidumbre (Fase 5) solo aplica al `cognito-orchestrator`** (`/v1/chat/completions`), no al agent loop que usa el CLI (`/api/agent/loop`). Si trabajas por CLI día a día, no vas a ver ese mecanismo actuar — es esperado.
- Las sesiones viven en `~/.cognito/sessions/*.jsonl` — si algo se comporta raro, es el primer sitio donde mirar.
- `extensions_trusted=True` en un repo da a ese código el mismo nivel de acceso que el propio backend. No es sandbox.

---

## 4. Primeras tareas sugeridas (para ir cogiendo confianza)

En vez de empezar por algo sensible, un orden razonable:

1. **Solo lectura/análisis primero:** "resume qué hace `X`", "busca código muerto en `Y`" — para calibrar la calidad de las respuestas antes de dejarle escribir nada.
2. **Algo pequeño y reversible en `tc`** (es un prototipo, radio de explosión bajo) antes que en `hypenosys.github.io`.
3. **Bash/write reales** en una tarea acotada y de bajo riesgo — un script del homelab, una entrada de doc, algo que puedas revertir con un commit.
4. Deja para más adelante cualquier cosa cerca de las áreas ya protegidas por diseño (no hace falta ser cauto ahí — literalmente no puede tocarlas).

---

## Nota

Si al usarlo notas que editar `trust.json` a mano es un fastidio real (probablemente sí, apenas lo pruebes un par de veces), es un prompt pequeño y autocontenido para Jules — un flag `--trust`/`--untrust` en el CLI o un endpoint mínimo. Dímelo cuando te moleste de verdad y te lo preparo; no merece la pena adelantarlo especulativamente ahora.
