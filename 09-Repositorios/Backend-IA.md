---
title: "Backend Local IA"
status: finalizado
author: "Jules"
created: "2025-05-15"
updated: "2025-05-15"
version: 1.0
tags: [dev, repo, guia, ia, backend, docker]
area: "09-Repositorios"
owner: "Tech Lead"
related: ["[[04-Dev/README|04 - Dev]]", "[[INDEX|Índice Maestro]]"]
---

# 🤖 Repo: Backend Local IA (Hypenosys AI Core)

*Si has llegado hasta aquí buscando cómo instalar un chat de IA que te haga el trabajo, felicidades. Has encontrado el motor que nos hará millonarios o nos llevará a la extinción. Probablemente lo segundo si tocas algo que no entiendes.*

## 1. Propósito
Este repositorio (o sección del vault para los despistados) contiene la orquestación Docker para el ecosistema de IA local del estudio. Aquí vive el cerebro digital que analiza nuestro código, gestiona nuestras comunicaciones y, ocasionalmente, intenta cobrar consciencia.

- **Ollama:** El que hace el pensamiento pesado (LLMs).
- **Qdrant:** La memoria a largo plazo (Vector DB).
- **n8n:** El que une los cables (Automatización/Workflows). Incluye soporte para Python (beta) porque JavaScript a veces no es suficiente castigo.
- **Forgejo:** Donde guardamos el código sin que Microsoft nos espíe.
- **Matrix:** Para hablar con la IA (y entre nosotros, si no queda más remedio).
- **PostgreSQL/Redis:** Los sospechosos habituales de cualquier backend serio.

## 2. Configuración del Entorno
- **Requisitos previos:** Docker y Docker Compose (V2). Una GPU NVIDIA si no quieres que la IA responda a la velocidad de una tortuga con sedantes.
- **Instalación y Primeros Pasos:**
  ```bash
  # 1. Generar la configuración inicial de Matrix (Synapse)
  docker run -it --rm \
    -v $(pwd)/services/matrix/data:/data \
    -e SYNAPSE_SERVER_NAME=matrix.localhost \
    -e SYNAPSE_REPORT_STATS=no \
    matrixdotorg/synapse:latest generate

  # 2. Levantar el resto del circo
  docker compose up -d
  ```
- **Variables de Entorno:** Mira el `.env` en la raíz. No seas vago y cambia las contraseñas por defecto antes de que nos hackeen desde una nevera inteligente.

## 3. Flujo de Trabajo
1. **Modelos:** Descarga modelos en Ollama usando `docker exec -it hypenosys-ollama ollama run llama3`.
2. **Workflows:** Accede a n8n en `localhost:5678` para crear flujos que conecten Ollama con Qdrant.
3. **Persistencia:** Todo se guarda en la carpeta `services/`. No borres carpetas al azar a menos que quieras perder meses de entrenamiento.

## 4. Comandos Útiles
- `docker compose ps`: Para ver si algo ha explotado.
- `docker compose logs -f [servicio]`: Para ver por qué ha explotado.
- `docker compose down`: Para cuando el ventilador de tu PC empiece a levitar.

## 5. Estructura de Carpetas
- `/services`: Datos persistentes y configuraciones específicas de cada contenedor.
- `docker-compose.yml`: La receta del caos.
- `.env`: Secretos que deberías proteger con tu vida (o al menos con una clave decente).

## 6. Despliegue (Deployment)
Esto es **LOCAL**. Si intentas subir esto a producción tal cual, el Tech Lead te perseguirá con un cable de red pelado. Para producción usaremos el archivo de Kubernetes que flota por ahí.

---
### Checklist de Supervivencia
- [x] ¿Has cambiado la contraseña de Postgres? (Mentira, no lo has hecho).
- [x] ¿Funciona la GPU en Docker?
- [x] ¿Entiendes por qué usamos Qdrant y no simplemente una lista de Python? (Si la respuesta es no, vuelve a estudiar).
