---
title: "{{title}}"
status: borrador
author: "{{author}}"
created: "{{date}}"
updated: "{{date}}"
version: 0.1
tags: [gameplay, mecanica, diseño]
area: "02-Diseño-de-juego"
owner: "{{author}}"
related: []
---

# ⚙️ Mecánica: [Nombre de la Mecánica]

*Si el jugador no puede hacerlo, no existe. Si puede hacerlo y está roto, es un bug (o una feature si nos da pereza arreglarlo).*

## 1. Resumen
*¿En qué consiste?*
[Descripción breve de la acción y su propósito en el core loop].

## 2. Flujo de la Mecánica (Inputs & Outputs)
- **Activación (Input):** [Botón, condición de entorno, etc.].
- **Proceso:** [Qué ocurre internamente, cálculos, estados].
- **Resultado (Output):** [Efecto visual, cambio de stats, feedback sonoro].

## 3. Reglas Detalladas
- **Condiciones:** ¿Cuándo se puede usar? ¿Cuándo falla?
- **Limitaciones:** Cooldowns, costes de recursos, restricciones de movimiento.
- **Casos de borde:** ¿Qué pasa si el jugador hace algo que no esperábamos?

## 4. Feedback (Juiciness)
*Haciendo que se sienta bien.*
- **Visual:** [Partículas, screen shake, animaciones].
- **Sonoro:** [SFX sugeridos].
- **Háptico:** [Vibración del mando].

## 5. Balance y Parámetros
*Valores editables para diseño.*
- `velocidad_base`: [Valor]
- `duracion_efecto`: [Valor]
- `coste_energia`: [Valor]

## 6. Relación con otros Sistemas
- Interacción con [[Mecánica X]].
- Afecta a [[Sistema Y]].

---
### Checklist de Mecánica
- [ ] ¿Es divertida o solo es necesaria?
- [ ] ¿El feedback es suficiente para que el jugador entienda qué ha pasado?
- [ ] ¿Está definida de forma que un programador pueda implementarla sin llorar?
- [ ] ¿He incluido el diagrama de flujo si es complejo?
