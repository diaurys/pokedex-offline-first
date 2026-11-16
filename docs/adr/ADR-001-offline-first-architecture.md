# ADR-001: Adopción de Arquitectura Offline-First con Drift (SQLite) y Riverpod

* **Estado:** Aceptado
* **Fecha:** Noviembre 2026
* **Proyecto:** Pokédex Móvil - Avance del Proyecto Final (PUCMM)
* **Docente:** Freddy Peña

---

## 1. Contexto y Planteamiento del Problema

La aplicación Pokédex requiere ofrecer una experiencia de usuario rápida, robusta y resiliente, capaz de funcionar sin conexión a Internet o bajo condiciones de red inestables.

Tradicionalmente, muchas aplicaciones móviles implementan una estrategia **Online-First**, donde cada pantalla consulta una API remota y, si la petición falla o entra en timeout, recurre a una caché secundaria. Esta estrategia presenta graves problemas:
1. **Latencia perceptible**: La interfaz muestra pantallas de carga (*spinners*) mientras espera respuestas de red.
2. **Experiencia degradada sin conexión**: El usuario debe esperar a que expire el timeout de red antes de poder visualizar datos que ya estaban en su dispositivo.
3. **Acoplamiento**: Los widgets dependen directamente de los contratos y fallos del cliente de red.

Para el proyecto final de Desarrollo de Aplicaciones Móviles se exige una arquitectura **Offline-First estricta (OF-16, OF-17, OF-18)**, donde la interfaz nunca consuma respuestas de red directamente.

---

## 2. Decisión Tomada

Se decide implementar una **Arquitectura Offline-First Estricta** basada en tres pilares tecnológicos:

1. **Base de Datos Local como Única Fuente de Verdad (Single Source of Truth)**:
   - Se utiliza **SQLite** mediante la librería **Drift** (`drift` y `drift_flutter`).
   - Toda la interfaz de usuario (capa de presentación) observa exclusivamente los datos persistidos en SQLite mediante `Stream`.
   - Ningún widget realiza peticiones directas a PokéAPI GraphQL ni procesa sus respuestas.

2. **Motor de Sincronización Desacoplado (`SyncCoordinator`)**:
   - La sincronización remota se ejecuta como un proceso independiente en segundo plano (OF-01, OF-03).
   - Los datos obtenidos de PokéAPI GraphQL se transforman, validan y persisten en SQLite mediante operaciones transaccionales tipo *Upsert* (`insertOnConflictUpdate`), garantizando la ausencia de registros duplicados (OF-02, PS-01).
   - Al insertarse los datos en SQLite, la base de datos emite automáticamente el cambio a través de los Streams de Drift, actualizando la UI de manera reactiva e instantánea.

3. **Gestión de Estado Reactiva con Riverpod**:
   - Se utiliza **Flutter Riverpod** para la inyección de dependencias y el manejo del ciclo de vida de los estados.
   - El catálogo se expone mediante `StreamProvider`, vinculando el flujo de la base de datos con la vista sin acoplamiento.

---

## 3. Alternativas Consideradas

### Alternativa A: Hive / SharedPreferences
* *Pros*: Facilidad inicial de configuración con pares clave-valor.
* *Contras descartadas*: No ofrecen soporte de base de datos relacional estándar (SQL), carecen de consultas transaccionales ACID robustas, y dificultan la indexación requerida para búsquedas eficientes.

### Alternativa B: Estrategia Online-First con Caché HTTP
* *Pros*: Flujo simple de implementar en APIs REST/GraphQL comunes.
* *Contras descartadas*: Viola los requerimientos fundamentales OF-16 y OF-17. Produce bloqueos de interfaz durante la navegación y no garantiza que la aplicación arranque de inmediato tras un reinicio sin Internet (fallando la prueba obligatoria PA-04).

---

## 4. Consecuencias

### Positivas
* **Rendimiento instantáneo**: La interfaz arranca de inmediato con 0 ms de espera de red, leyendo directamente del almacenamiento local (OF-03, PA-01).
* **Funcionamiento offline garantizado**: Las pruebas en vivo de desconexión (**PA-03**) y reinicio sin Internet (**PA-04**) se cumplen al 100%, ya que la información vive en SQLite.
* **Integridad de datos**: Las escrituras transaccionales de Drift impiden datos corruptos o duplicados tras múltiples sincronizaciones.
* **Separación de responsabilidades (Clean Architecture)**: La capa de dominio y la de presentación son completamente independientes del protocolo de comunicación GraphQL.

### Negativas / Mitigaciones
* *Mayor complejidad en el código*: Requiere diseñar modelos de datos locales (tablas Drift) y DTOs para mapear las respuestas de GraphQL a entidades locales.
  * *Mitigación*: Se implementaron DAOs dedicados (`PokemonDao`, `FavoritesDao`, `SyncDao`) que encapsulan la lógica de acceso a datos de forma clara y modular.
