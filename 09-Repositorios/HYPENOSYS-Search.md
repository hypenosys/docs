---
title: "HYPENOSYS Search — Guía y arquitectura"
status: experimental
author: "Hypenosys"
created: "2026-11-09"
updated: "2026-11-09"
version: "0.5 (prototipo con parches locales)"
tags: [search, searxng, gemma, ollama, ia, docker, documentacion]
area: "09-Repositorios"
related: ["[[09-Repositorios/README|Repositorios]]", "[[09-Repositorios/Backend-IA|Backend Local IA]]"]
---

# ✧ HYPENOSYS Search

**Private Search · Intelligent Answers**

HYPENOSYS Search es un **prototipo** de buscador autoalojado, con recuperación web mediante SearXNG y respuestas asistidas por IA con enlaces a fuentes. No debe confundirse con el dashboard de Hypenosys Studio ni con el proyecto general Backend Local IA.

> [!warning] Estado del proyecto
> Esta guía describe una instalación experimental verificada parcialmente en LAN y Tailscale. No existe aún una versión pública auditada ni un despliegue BYOK apto para recibir claves por HTTP.

## 1. Funcionalidades

| Función | Estado |
|---|---|
| Búsqueda web a través de SearXNG | Funcional en pruebas |
| AI Overview con Gemma local | Funcional en pruebas |
| Deep Research (consultas adicionales + lectura limitada de páginas públicas) | Experimental |
| Referencias enlazadas | Funcional; no equivalen a verificación automática |
| Conversación con historial reciente de sesión | Funcional; no persistente |
| Proveedores BYOK | Interfaz disponible; requiere HTTPS para uso con claves |
| Modelo privado en Ollama | Separado del BYOK público |

## 2. Arquitectura

```text
Navegador
  │
  ├── Instancia BYOK (FastAPI) ──┐
  │                            ├── SearXNG ─── motores web (pueden limitar solicitudes)
  └── Instancia privada ────────┘
             │
             └── Ollama / Gemma (red privada + autenticación)
```

Backend: **FastAPI (Python)**. Frontend: **HTML, CSS y JavaScript**. Orquestación: **Docker Compose**. El motor de investigación selecciona extractos y puede hacer consultas adicionales; **no es aún un agente general con herramientas nativas**.

## 3. Cómo utilizarlo

1. Escribe una pregunta y pulsa **Buscar**.
2. Revisa las páginas que devuelve SearXNG.
3. Genera **AI Overview** para un resumen basado en extractos, o usa **Deep Research** para ampliar la recuperación.
4. Verifica siempre las afirmaciones en las fuentes originales.
5. Las preguntas de seguimiento conservan contexto limitado en el hilo de la pestaña.

## 4. Proveedores y modelos

La interfaz BYOK contempla OpenAI, OpenRouter, Anthropic, Google Gemini, Groq, Mistral, DeepSeek, xAI, Together AI, Fireworks AI, Cerebras, NVIDIA NIM y Perplexity API. Los modelos y formatos compatibles dependen del proveedor y deben probarse individualmente.

La instancia privada puede utilizar modelos de Ollama autorizados por el backend (por ejemplo, Gemma). La configuración actual ha funcionado con **Gemma 4 26B y un contexto de 4096 tokens**; la estabilidad en tareas largas sigue en evaluación.

## 5. Limitaciones y problemas conocidos

- Los motores públicos pueden responder con **CAPTCHA**, demasiadas peticiones o cero resultados.
- Las búsquedas en lenguaje natural requieren reformulación: enviar frases completas al buscador puede generar resultados irrelevantes.
- La documentación oficial debe priorizarse cuando la pregunta sea técnica.
- Los extractos y enlaces no demuestran automáticamente la exactitud de las respuestas.
- Los límites de contexto y salida pueden producir respuestas truncadas.
- Las citas numeradas son locales a cada respuesta y no deben mezclarse entre turnos.

## 6. Seguridad antes de publicar

- **No usar claves BYOK por HTTP.** Deben habilitarse HTTPS, límites por usuario y protección de secretos antes de exponer el servicio.
- No publicar el puerto de Ollama. Restringirlo con firewall y políticas de acceso; **Tailscale no sustituye a la autenticación**.
- Tratar los documentos recuperados como contenido no confiable (prompt injection).
- Mantener defensas SSRF para lectura de URL, DNS y redirecciones; limitar tiempo y tamaño.
- No publicar direcciones de administración, credenciales, secretos ni archivos `.env`.
- Introducir caché, control de carga y reintentos moderados para reducir bloqueos de los motores.

## 7. Mantenimiento y diagnóstico

Comprobaciones generales en el host de Docker (adaptar ruta y nombre del proyecto a la instalación):

```bash
docker compose -f /ruta/privada/compose.yaml ps
docker compose -f /ruta/privada/compose.yaml logs --tail=80
```

Comprobar una búsqueda SearXNG vía JSON (solo en red interna):

```bash
curl -sS -G 'http://127.0.0.1:8888/search' \
  --data-urlencode 'q=FastAPI Python REST API documentation' \
  --data-urlencode 'format=json' \
  --data-urlencode 'engines=bing'
```

No reproducir tokens ni resultados de diagnóstico que contengan secretos en incidencias públicas.

## 8. Hoja de ruta

1. Consolidar las rutas de búsqueda y añadir tests de integración.
2. Reformular consultas sin reglas codificadas para una sola temática.
3. Priorizar documentación primaria y deduplicar fuentes.
4. Verificar enlaces y correspondencia entre cita y afirmación.
5. Incorporar control de concurrencia, caché y fallbacks de motores.
6. Auditar privacidad, SSRF, autenticación y configurar HTTPS antes de apertura pública.

---

**Estado:** HYPENOSYS Search en desarrollo. Esta documentación podrá ampliarse conforme se estabilicen nuevas versiones.
