---
title: "{{title}}"
status: borrador
author: "{{author}}"
created: "{{date}}"
updated: "{{date}}"
version: 0.1
tags: [dev, tdd, sistemas]
area: "04-Dev"
owner: "{{author}}"
related: []
---

# 🛠️ Technical Design: [Nombre del Sistema]

*Traduciendo los sueños de diseño a las pesadillas de programación.*

## 1. Objetivo Técnico
- **¿Qué debe hacer este sistema?**
- **Restricciones:** [Memoria, CPU, red, limitaciones del motor].

## 2. Arquitectura del Sistema
- **Clases Principales:** [Clase A, Clase B].
- **Patrones de Diseño:** [Ej: Singleton, Observer, State Machine].
- **Diagrama de Clases/Componentes:** [[Imagen o código Mermaid]].

## 3. Integración con el Motor
- **Componentes necesarios:** [Ej: RigidBody, BoxCollider].
- **Prefabs/Blueprints:** Estructura recomendada.
- **Ciclo de vida:** [¿Qué pasa en el `Awake`, `Update`, `OnDestroy`?].

## 4. Comunicación entre Sistemas
- **Inputs:** ¿De dónde recibe datos?
- **Outputs:** ¿A quién notifica cambios?
- **Dependencias:** [Sistemas sin los cuales esto no funciona].

## 5. Optimización y Rendimiento
- **Coste estimado:** [Llamadas por frame, uso de memoria].
- **Estrategias de optimización:** [Ej: Object Pooling, LODs técnicos].

## 6. Herramientas para Diseñadores (Tooling)
- **Variables expuestas:** [Lo que el diseñador puede tocar sin romper el código].
- **Custom Editor / Gizmos:** Ayudas visuales en el motor.

---
### Checklist Técnico
- [ ] ¿Es modular y reutilizable?
- [ ] ¿He evitado el "código espagueti"?
- [ ] ¿Está documentado cómo testearlo?
- [ ] ¿He considerado el rendimiento en la plataforma más débil?
