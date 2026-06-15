---
title: "{{title}}"
status: borrador
author: "{{author}}"
created: "{{date}}"
updated: "{{date}}"
version: 0.1
tags: [assets, tracking, producción]
area: "07-Assets-y-Recursos"
owner: "{{author}}"
related: []
---

# 📦 Asset Tracking: [Categoría]

*¿Dónde está ese modelo de la silla y por qué tiene 2 millones de polígonos?*

## 1. Inventario de Assets
| ID | Nombre Asset | Responsable | Estado | Versión | Ubicación en Repo |
|---|---|---|---|---|---|
| A001 | Prota_Model | [Nombre] | En progreso | 0.4 | `/Art/Chars/` |
| A002 | Sword_SFX | [Nombre] | Finalizado | 1.0 | `/Audio/SFX/` |

## 2. Estados Definidos
- 🔴 **Pendiente:** Ni se ha empezado.
- 🟠 **Bloqueado:** Esperando a otro departamento/tarea.
- 🟡 **En Progreso:** Se está trabajando en ello.
- 🔵 **Review:** Esperando aprobación del Lead.
- 🟢 **Finalizado:** Integrado y funcionando.

## 3. Convenciones de Exportación
- **Formatos:** [FBX, PNG, WAV...].
- **Nomenclatura:** `T_[Nombre]_D.png` (Textura Albedo), etc.
- **Escala sugerida:** [Ej: 1 unidad = 1 metro].

## 4. Notas de Integración
- [Asset X] requiere el shader [Y] para verse bien.
- [Asset Z] debe tener activada la opción [W] en el motor.

---
### Checklist de Tracking
- [ ] ¿Están todos los responsables asignados?
- [ ] ¿Se ha actualizado el estado tras la última reunión?
- [ ] ¿Los nombres coinciden con los archivos reales?
