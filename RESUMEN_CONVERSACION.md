# Resumen del Proyecto y Estado Actual para Continuación en Antigravity

**Proyecto:** Pokédex Móvil con Flutter, GraphQL y Arquitectura Offline-First  
**Asignatura:** Desarrollo de Aplicaciones Móviles · Proyecto Final  
**Institución:** Pontificia Universidad Católica Madre y Maestra (PUCMM)  
**Docente:** Freddy Peña  
**Estudiante:** Diaurys (GitHub: `diaurys`)  
**Repositorio GitHub:** [https://github.com/diaurys/pokedex-offline-first](https://github.com/diaurys/pokedex-offline-first)  
**Última actualización:** 11 de noviembre de 2026  

---

## ⚠️ Compromisos y Reglas Obligatorias (NO OLVIDAR NUNCA)
1. **Enfocarse solo en cumplir lo que pide el profesor**: No añadir nada que no esté explícitamente en el PDF del proyecto final.
2. **Diseño creativo y original**: Mantener una estética moderna, limpia y fiel a los estándares de Pokémon (colores por tipo, Hero animations, gráficos interactivos) sin salirse de las convenciones de Flutter y Material 3.
3. **Explicar cada paso**: El estudiante debe entender cada decisión arquitectónica para su defensa oral técnica de 5 minutos (eliminatoria).
4. **Ejecución y pruebas en PC**: Para evitar la lentitud del celular, el desarrollo y pruebas se realizan en PC abriendo **Opera** mediante el script `.\run_opera.bat` (servidor local en `http://localhost:8080` con soporte SQLite WebAssembly y Hot Reload). Cuando esté listo para la entrega final, se compila e instala en el celular Android físico (`WDY LX3`).

---

## 1. Estado de Fases del Proyecto

| Fase | Descripción | Estado |
| :--- | :--- | :---: |
| **Fase 1: Git & Repositorio** | Configuración de Git, repositorio en GitHub con Conventional Commits. | ✅ **100% Completo** |
| **Fase 2: Clean Architecture** | Capas `presentation`, `domain`, `data` separadas por features (`pokemon`, `favorites`, `trivia`, `settings`). | ✅ **100% Completo** |
| **Fase 3: Base de Datos SQLite (Drift)** | 9 tablas con índices, DAOs transaccionales, soporte SHA-256 para OF-19 y WebAssembly (`sqlite3.wasm`). | ✅ **100% Completo** |
| **Fase 4: Motor de Sync & GraphQL** | PokeAPI GraphQL `v1beta2`, queries optimizadas, backoff exponencial, DTOs y mapeo sin duplicados. | ✅ **100% Completo** |
| **Fase 5: Indicador de Conectividad** | Widget permanente con 4 estados (Verde/Online, Rojo/Offline, Naranja/API Caída, Azul/Sincronizando) e info SQLite. | ✅ **100% Completo** |
| **Fase 6: Pantallas de la App** | Catálogo con búsqueda/debounce/filtros, Detalle con stats radar (`fl_chart`)/shiny/matchups, Favoritos (<150ms) y Trivia ("¿Quién es este Pokémon?" con siluetas y logros). | ✅ **100% Completo** |
| **Fase 7: Herramientas PA en Vivo** | Simulador de caída de API (PA-08), simulador de alteración de hash (PA-16) e Inspector SQLite en tiempo real. | ✅ **100% Completo** |
| **Fase 8: Documentación & Defensa** | README con las 13 secciones obligatorias, 2 ADRs de arquitectura, diagramas Mermaid y guion de 5 minutos. | ⏳ **Siguiente paso** |

---

## 2. Archivos Clave del Proyecto

### Núcleo y Arquitectura (`lib/core/`):
* `lib/core/constants/api_constants.dart`: Endpoints, timeouts de red (RNF-RES-01) y URLs de imágenes.
* `lib/core/constants/app_colors.dart`: Colores oficiales de los 18 tipos de Pokémon y de conectividad.
* `lib/core/database/app_database.dart`: Base de datos Drift con soporte nativo (Android/Windows) y Web (`DriftWebOptions` con `sqlite3.wasm` y `drift_worker.js`).
* `lib/core/database/daos/`: `pokemon_dao.dart`, `favorites_dao.dart`, `trivia_dao.dart`, `sync_dao.dart`.
* `lib/core/network/`: `connectivity_service.dart`, `api_health_service.dart` (soporta PA-08).
* `lib/core/sync/sync_coordinator.dart`: Motor de sincronización en segundo plano con backoff exponencial.
* `lib/core/utils/type_matchups_helper.dart`: Matriz de efectividad de tipos ($18 \times 18$) para debilidades y resistencias ($\times 4$ a $\times 0$).
* `lib/core/widgets/connectivity_banner.dart`: Indicador visual global IND-01 a IND-05.
* `lib/core/providers.dart`: Inyección de dependencias de Riverpod.

### Funcionalidades (`lib/features/`):
* **Pokémon (`lib/features/pokemon/`)**:
  * `presentation/providers/catalog_provider.dart`: Debounce 350ms (RF-CAT-03), filtros de tipo/gen y persistencia en `SharedPreferences` (RF-FIL-04).
  * `presentation/widgets/pokemon_card.dart`: Tarjeta con gradiente por tipo, artwork/sprite/asset fallback (OF-08), animación Hero y favorito reactivo (<150ms).
  * `presentation/screens/catalog_screen.dart`: Grid responsivo virtualizado (RNF-REN-01), barra de búsqueda, chips de tipo y estados diferenciados (RF-CAT-04).
  * `presentation/screens/pokemon_detail_screen.dart`: Detalle completo con toggle Shiny ⭐, radar/barras de estadísticas (`fl_chart`), habilidades (máx. 160 chars), cadena evolutiva, matchups defensivos y botón de compartir (`share_plus`).
* **Favoritos (`lib/features/favorites/`)**:
  * `presentation/screens/favorites_screen.dart`: Pantalla dedicada offline (RF-FAV-02/03) protegida contra sobrescritura (OF-21).
* **Trivia (`lib/features/trivia/`)**:
  * `presentation/screens/trivia_screen.dart`: Juego "¿Quién es este Pokémon?" con silueta negra, 15 segundos límite por pregunta, ranking local en SQLite, logros visuales y selector de idioma Español/Inglés (RF-TRV-01 a 06).
* **Ajustes e Inspector PA (`lib/features/settings/`)**:
  * `presentation/screens/settings_screen.dart`: Toggle para simular caída de API (PA-08), alteración de datos SQLite para disparar alerta de restauración OF-19 (PA-16) y métricas de BD en vivo.

### Archivos de Ejecución:
* `run_opera.bat`: Comando para levantar el servidor local en `http://localhost:8080` y abrir Opera automáticamente con Hot Reload.
* `lib/main.dart`: Contenedor principal con `NavigationBar` (Material 3) e indicador global superior.

---

## 3. Estado de Calidad del Código
* **`dart analyze lib`**: `No issues found!` (0 errores, 0 warnings).
* **Git**: Todos los cambios están commiteados y subidos a la rama `main` en GitHub.

---

## 4. Qué Hacer en la Próxima Sesión
1. **Redactar el `README.md` completo de 13 secciones** exigidas por la rúbrica oficial (§13 del PDF):
   - Descripción del proyecto y alcance.
   - Requisitos previos e instalación.
   - Tecnologías utilizadas con justificación de cada dependencia (RNF-MAN-04).
   - Arquitectura de la solución (Clean Architecture, diagramas Mermaid).
   - Estructura de carpetas por funcionalidad.
   - Estrategia Offline-First y SQLite con Drift.
   - Integración GraphQL (PokeAPI v1beta2) y paginación justificada.
   - Motor de sincronización, reintentos con backoff y regla OF-19.
   - Persistencia local y separación de datos de usuario (OF-21).
   - Indicador de conectividad y máquina de 4 estados.
   - Funcionalidades complementarias y gamificación.
   - Limitaciones conocidas.
   - Declaración obligatoria de uso de herramientas de Inteligencia Artificial (con detalle de prompts y validación).
2. **Generar los 2 documentos ADR (Architecture Decision Records)** en `docs/adr/`.
3. **Preparar el guion para la defensa técnica de 5 minutos** (explicación de la arquitectura, Offline-First, hash de integridad y manejo de errores sin titubeos).
