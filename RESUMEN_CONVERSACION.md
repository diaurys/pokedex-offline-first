# Resumen del Proyecto y Estado Actual para Continuación en Antigravity

**Proyecto:** Pokédex Móvil con Flutter, GraphQL y Arquitectura Offline-First  
**Asignatura:** Desarrollo de Aplicaciones Móviles · Proyecto Final  
**Institución:** Pontificia Universidad Católica Madre y Maestra (PUCMM)  
**Docente:** Freddy Peña  
**Estudiante:** Diaurys  
**Repositorio GitHub:** [https://github.com/diaurys/pokedex-offline-first](https://github.com/diaurys/pokedex-offline-first)  
**Fecha de guardado:** 11 de noviembre de 2026  

---

## 1. Lo Esencial y Reglas del Proyecto (Rúbrica Oficial)
* **Arquitectura:** Clean Architecture por funcionalidades (`pokemon`, `favorites`, `trivia`, `settings`) con capas `presentation`, `domain` y `data`.
* **Núcleo Offline-First:** La UI **solo observa la base de datos local (SQLite mediante Drift)**. Nunca consume directamente las respuestas de GraphQL.
* **Fuente Remota:** PokéAPI GraphQL (especificación activa `v1beta2` en `https://graphql.pokeapi.co/v1beta2`).
* **Sincronización Remoto → Local:** 
  * Los datos remotos se validan y se guardan en transacción (Upsert para evitar duplicados).
  * La UI nunca se bloquea (muestra carga/vacío y sincroniza en segundo plano).
  * **Regla OF-19 y PA-16:** Si alguien altera datos del catálogo en SQLite local, la app detecta la diferencia mediante hash SHA-256 y los restaura desde PokéAPI. Favoritos y puntajes nunca se tocan.
* **Indicador Global de Conectividad (IND-01 a IND-05):**
  * Fijo y visible en todas las pantallas principales.
  * 4 estados: *En línea*, *Sin conexión*, *Servicio no disponible (hay red pero falla la API)* y *Sincronizando*.
  * Informa origen del dato (SQLite local) y marca de última sincronización.

---

## 2. Diagnóstico del Entorno en la PC del Estudiante
* **Sistema Operativo:** Windows 11.
* **Flutter SDK:** 3.47.7 (Channel stable, Dart 3.13.5).
* **Android SDK:** Version 36.1.0, JDK 21 de Android Studio configurado.
* **Dispositivo Físico:** Celular `WDY LX3` con Android 14 (API 34) conectado por cable USB con depuración autorizada (`ALWSCP3B24400894`).
* **Git:** Configurado con usuario `Diaurys` y enlazado por GitHub CLI a `diaurys/pokedex-offline-first`.
* **Solución a error de tilde en ruta Windows:**
  * La carpeta se llama `Pokédex` con tilde en la `é`. Para evitar que Gradle falle en Windows, se configuró `android.overridePathCheck=true` en `android/gradle.properties`.

---

## 3. Estado Actual del Código (100% Sin Errores)
Se ejecutó `dart analyze lib` con resultado: **`No issues found!`** (0 errores, 0 advertencias).

### Archivos ya creados y testeados:
1. **Configuración y Constantes:**
   * `lib/core/constants/api_constants.dart`: URLs de PokeAPI, artwork oficial, sprites de respaldo y timeouts explícitos (RNF-RES-01).
   * `lib/core/constants/app_colors.dart`: Paleta oficial por tipos de Pokémon y estados de conectividad.
2. **Base de Datos Local (Drift / SQLite):**
   * `lib/core/database/app_database.dart` y `app_database.g.dart`: Base de datos SQLite reactiva con índices (RNF-REN-02).
   * `lib/core/database/tables/`: Tablas `Pokemons`, `PokemonTypes`, `PokemonStats`, `PokemonAbilities`, `PokemonMoves`, `PokemonEvolutions`, `Favorites`, `TriviaRecords`, `SyncMetadata`.
   * `lib/core/database/daos/`:
     * `pokemon_dao.dart`: Consultas reactivas (Stream), filtros por tipo/generación, búsqueda con debounce, Upsert transaccional y detección de alteración de hash (OF-19).
     * `favorites_dao.dart`: Gestión de favoritos con persistencia < 150 ms (RF-FAV-03).
     * `trivia_dao.dart`: Puntuaciones y ranking local offline.
     * `sync_dao.dart`: Registro de fecha y hora de sincronización.
3. **Manejo de Errores y Utilidades:**
   * `lib/core/errors/exceptions.dart` y `failures.dart`: Separación Clean Architecture de excepciones de red y fallos de dominio.
   * `lib/core/utils/hash_helper.dart`: Cálculo de SHA-256 para integridad de datos locales.
   * `lib/core/utils/type_matchups_helper.dart`: Matriz de efectividad de tipos (×0 a ×4).
4. **Red y GraphQL:**
   * `lib/core/network/connectivity_state.dart`: Modelo desacoplado de los 4 estados de conectividad.
   * `lib/core/network/api_health_service.dart`: Comprobación de disponibilidad real de PokeAPI GraphQL y simulación de caída para PA-08.
   * `lib/core/network/connectivity_service.dart`: Monitor de red con prevención de parpadeos.
   * `lib/features/pokemon/data/datasources/pokemon_remote_data_source.dart`: Cliente GraphQL v1beta2 para catálogo y detalles completos.
5. **Coordinador de Sincronización:**
   * `lib/core/sync/sync_coordinator.dart`: Manejo de reintentos con backoff exponencial (RNF-RES-02), prevención de syncs duplicados concurrentes (RNF-RES-03) y restauración automática de datos alterados (OF-19).
6. **Inyección de Dependencias (Riverpod):**
   * `lib/core/providers.dart`: Centralización de todos los proveedores listos para consumir en la UI.
7. **Punto de Entrada Actual:**
   * `lib/main.dart`: Configurado con `ProviderScope` y pantalla de bienvenida de prueba.

---

## 4. Próximos Pasos al Abrir la Nueva Sesión
1. **Verificar compilación en el celular WDY LX3:**
   * Ejecutar la app con el botón Play en Android Studio o con `flutter run -d ALWSCP3B24400894`.
2. **Construir la Interfaz de Usuario (Presentation Layer) paso a paso con el estudiante:**
   * Paso 1: Widget del **Indicador Global de Conectividad (IND-01 a IND-05)** con los 4 estados.
   * Paso 2: Pantalla de **Catálogo** (Búsqueda debounce 300-500ms, filtros por tipo/gen, lista virtualizada y Pull-to-Refresh).
   * Paso 3: Pantalla de **Detalle del Pokémon** (Hero animation, stats con radar/barras, debilidades ×0 a ×4, evoluciones, alternancia shiny, favoritos y compartir tarjeta).
   * Paso 4: Pantalla de **Favoritos** (<150ms).
   * Paso 5: Pantalla de **Trivia "¿Quién es este Pokémon?"** (siluetas, tiempo, ranking offline).
   * Paso 6: Pantalla de **Ajustes y Modo Demostración** (Switches para simular caída de API PA-08 y modificar datos en vivo para PA-16).
3. **Documentación:** Generar el README oficial con las 13 secciones solicitadas por el docente y los 2 ADRs.

---

## 5. Mensaje Rápido para pegar en la nueva cuenta de Antigravity:
> *"Hola Antigravity, estoy continuando el proyecto Pokédex Offline-First en Flutter de la PUCMM. Lee el archivo `RESUMEN_CONVERSACION.md` en la raíz de este proyecto; ahí está todo el contexto, la arquitectura ya implementada y dónde nos quedamos. Vamos a ir paso a paso."*
