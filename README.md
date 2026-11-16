# Pokédex Flutter Offline-First: Fundamentos (Avance 40%)

![Flutter](https://img.shields.io/badge/Flutter-3.47.7-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.13.5-0175C2?logo=dart)
![SQLite](https://img.shields.io/badge/SQLite-Drift_2.35.4-003B57?logo=sqlite)
![GraphQL](https://img.shields.io/badge/GraphQL-PokéAPI_v1beta2-E10098?logo=graphql)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-brightgreen)

* **Institución:** Pontificia Universidad Católica Madre y Maestra (PUCMM)
* **Escuela:** Ingeniería en Computación y Telecomunicaciones
* **Asignatura:** Desarrollo de Aplicaciones Móviles
* **Docente:** Freddy Peña (`fr.pena@ce.pucmm.edu.do`)
* **Estudiante:** Diaurys (GitHub: [`diaurys`](https://github.com/diaurys))
* **Repositorio Oficial:** [https://github.com/diaurys/pokedex-offline-first](https://github.com/diaurys/pokedex-offline-first)
* **Alcance de esta entrega:** $\approx 40\%$ del proyecto final (Fundamentos arquitectónicos, persistencia y offline-first).

---

## 1. Resumen de Entregables Obligatorios del Avance

Este avance evalúa la base arquitectónica del proyecto: estructura, persistencia, integración con GraphQL y funcionamiento offline.

| # | Entregable Obligatorio | Referencia | Implementación en el Proyecto |
|---|---|---|---|
| **1** | **Estructura del proyecto** | §8 · RNF-MAN-01, 02 | Organización por funcionalidades (`pokemon`, `favorites`) con capas `presentation`, `domain` y `data`. |
| **2** | **Modelo de datos local** | §11 · PS-01, D6 | Persistencia relacional estructurada en SQLite con Drift (`pokemons`, `pokemon_types`, `favorites`, `sync_metadata`). |
| **3** | **Integración GraphQL** | OF-01, 02 · RF-CAT-02 | Catálogo obtenido de PokéAPI (`v1beta2`) con paginación (`limit`, `offset`) y guardado transaccional (*Upsert*) sin duplicados. |
| **4** | **Fuente de lectura local** | OF-16, 17, 18 | La interfaz observa la base local vía `StreamProvider`; ningún widget consume respuestas GraphQL directamente. |
| **5** | **Interfaz sin bloqueos** | OF-03 · PA-01 | La app abre de inmediato y permite navegar fluidamente mientras la sincronización ocurre en segundo plano. |
| **6** | **Catálogo funcional** | RF-CAT-01, 04 | Listado con nombre, número (`#001`), imagen oficial con respaldos y tipos; estados de carga, vacío y error con «Reintentar». |
| **7** | **Funcionamiento offline** | OF-05, 10 · PA-03, 04 | Catálogo 100% disponible sin conexión, probado también después de reiniciar la aplicación por completo. |
| **8** | **Indicador de conectividad** | IND-01, 05 | Indicador visual permanente en la cabecera con estados **Online** (Verde) y **Offline** (Rojo), texto, icono y badge SQLite. |
| **9** | **Documentación inicial** | ENT-01 a 03 · ENT-10 | Este `README.md`, el historial de commits y el registro arquitectónico [`ADR-001`](docs/adr/ADR-001-offline-first-architecture.md). |

---

## 2. Arquitectura de la Solución (Clean Architecture)

El proyecto sigue los principios de **Clean Architecture** organizados por funcionalidades (*features*). El dominio de negocio es completamente puro y desacoplado de Flutter, del cliente GraphQL y de la base de datos (RNF-MAN-01, RNF-MAN-02).

```
                      ┌───────────────────────────────────────────────┐
                      │              POKÉAPI GRAPHQL                  │
                      │   (https://graphql.pokeapi.co/v1beta2)        │
                      └──────────────────────┬────────────────────────┘
                                             │  Query paginada
                                             │  ($limit, $offset)
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │          PokemonRemoteDataSource              │
                      │         (Capa Data / Datasource)              │
                      └──────────────────────┬────────────────────────┘
                                             │  DTOs mapeados
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │              SyncCoordinator                  │
                      │      (Motor de Sincronización en 2do plano)   │
                      └──────────────────────┬────────────────────────┘
                                             │  Escritura transaccional
                                             │  (Upsert sin duplicados)
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │          SQLite Local (Drift ORM)             │
                      │        (ÚNICA FUENTE DE VERDAD - OF-16)       │
                      │   Tablas: Pokemons, Types, Favorites, Sync    │
                      └──────────────────────┬────────────────────────┘
                                             │  Stream reactivo
                                             │  (watchCatalog)
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │            PokemonRepositoryImpl              │
                      │         (Capa Data / Implementación)          │
                      └──────────────────────┬────────────────────────┘
                                             │  Entidades de dominio
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │         pokemonCatalogStreamProvider          │
                      │        (Capa Presentation / Riverpod)         │
                      └──────────────────────┬────────────────────────┘
                                             │  AsyncValue (Data/Load/Error)
                                             ▼
                      ┌───────────────────────────────────────────────┐
                      │                CatalogScreen                  │
                      │   (UI: Grid responsivo, 3 estados, OF-03)     │
                      └───────────────────────────────────────────────┘
```

### Separación de Capas por Funcionalidad:
1. **`domain/` (Dominio)**:
   * `entities/pokemon_entity.dart`: Modelos puros de Dart (`PokemonListItem`, `PokemonTypeEntity`). No importan paquetes de Flutter ni Drift.
   * `repositories/pokemon_repository.dart`: Contrato abstracto que define las operaciones del catálogo (`watchCatalog`, `syncCatalog`, etc.).
2. **`data/` (Datos)**:
   * `datasources/pokemon_remote_data_source.dart`: Ejecución de consultas GraphQL sobre PokéAPI `v1beta2` con timeout explícito (RNF-RES-01).
   * `daos/pokemon_dao.dart`: Acceso a SQLite con Drift. Implementa `watchCatalog()` mediante Streams y `upsertCatalogBatch()` dentro de transacciones atómicas.
   * `repositories/pokemon_repository_impl.dart`: Implementación concreta del repositorio inyectando el DAO y el coordinador.
3. **`presentation/` (Presentación)**:
   * `providers/catalog_provider.dart`: Expone el `StreamProvider` que observa la base de datos local.
   * `screens/catalog_screen.dart`: Vista principal que renderiza los estados de Carga, Éxito, Vacío y Error con botón «Reintentar» (RF-CAT-04).
   * `widgets/pokemon_card.dart`: Tarjeta visual con gradientes por tipo, número nacional (`#001`), imagen oficial y botón de favoritos reactivo.

---

## 3. Modelo de Datos Local (SQLite con Drift)

Conforme a **§11 y PS-01**, la persistencia estructurada local se implementa con **Drift (SQLite)**. Se definen las tablas relacionales con índices explícitos (RNF-REN-02):

```sql
-- Tabla Principal de Pokémon
CREATE TABLE pokemons (
  id INTEGER NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  height INTEGER NOT NULL,
  weight INTEGER NOT NULL,
  base_experience INTEGER,
  generation_id INTEGER NOT NULL,
  content_hash TEXT,
  updated_at INTEGER NOT NULL
);
CREATE INDEX idx_pokemons_name ON pokemons(name);
CREATE INDEX idx_pokemons_generation ON pokemons(generation_id);

-- Tabla Relacional de Tipos (1 a 2 tipos por Pokémon)
CREATE TABLE pokemon_types (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  pokemon_id INTEGER NOT NULL REFERENCES pokemons(id) ON DELETE CASCADE,
  slot INTEGER NOT NULL,
  type_name TEXT NOT NULL,
  type_id INTEGER NOT NULL
);
CREATE INDEX idx_pokemon_types_pokemon_id ON pokemon_types(pokemon_id);

-- Tabla de Favoritos del Usuario (Persistencia <150ms)
CREATE TABLE favorites (
  pokemon_id INTEGER NOT NULL PRIMARY KEY REFERENCES pokemons(id) ON DELETE CASCADE,
  added_at INTEGER NOT NULL
);

-- Tabla de Metadatos de Sincronización
CREATE TABLE sync_metadata (
  resource_key TEXT NOT NULL PRIMARY KEY,
  last_sync_time INTEGER NOT NULL,
  records_count INTEGER NOT NULL,
  content_hash TEXT
);
```

---

## 4. Estrategia Offline-First y Sincronización

### ¿Por qué la interfaz es 100% Offline-First (OF-16, OF-17)?
1. **La UI nunca llama a GraphQL para renderizar**: El widget `CatalogScreen` se suscribe a `pokemonCatalogStreamProvider`. Este provider emite la lista consultando la base de datos local SQLite mediante `pokemonDao.watchCatalog()`.
2. **Sincronización en segundo plano sin bloqueos (OF-03, PA-01)**:
   - Al abrir la aplicación o presionar el botón de sincronizar, se invoca `syncCoordinator.syncCatalog()`.
   - Se consulta la API GraphQL solicitando un lote paginado (`$limit: 24`, `$offset: 0`).
   - Los datos recibidos se persisten en SQLite usando `insertOnConflictUpdate` (Upsert). Si un Pokémon ya existía, se actualiza sin duplicarse (OF-02).
   - Como SQLite es reactivo (`Stream`), en cuanto termina la transacción en la base local, la interfaz se refresca sola y al instante.
3. **Estrategia de imágenes offline en 3 niveles (OF-08)**:
   - Nivel 1: `official-artwork` descargada y almacenada en caché de disco (`CachedNetworkImage`).
   - Nivel 2: Sprite frontal de respaldo si el artwork falla.
   - Nivel 3: Asset local embebido `assets/images/pokeball_placeholder.png` para cuando no existe conexión ni caché previa.

---

## 5. Indicador Global de Conectividad (IND-01 a IND-05)

El widget `ConnectivityBanner` se encuentra fijo en la parte superior de la aplicación y expone de forma inequívoca el estado de conexión del dispositivo:

* 🟢 **En línea — PokéAPI disponible** (Verde): Red activa y PokéAPI respondiendo. Indica la fecha y hora de la última sincronización.
* 🔴 **Modo sin conexión (Offline-First)** (Rojo): Dispositivo en modo avión o sin Wi-Fi/datos. Notifica al usuario: *"Visualizando datos guardados localmente en SQLite"*.
* 🔵 **Sincronizando con PokéAPI** (Azul): Transacción en segundo plano descargando e indexando nuevos Pokémon en SQLite.

El indicador incluye etiquetas `Semantics` para accesibilidad (RNF-ACC-01) y no transmite la información únicamente mediante color, sino también mediante iconos descriptivos y texto claro (RNF-ACC-05).

---

## 6. Demostración en Vivo para Evaluación (PA-03 y PA-04)

Durante la presentación del avance ante el docente, se verifican en vivo los escenarios obligatorios:

### Escenario PA-03: Consulta de Pokémon almacenados sin Internet
1. Con la aplicación abierta y datos sincronizados, **apagar el Wi-Fi / datos móviles** del dispositivo (o activar Modo Avión).
2. El indicador superior cambia inmediatamente a **Rojo («Modo sin conexión - Visualizando datos de SQLite»)**.
3. El catálogo completo continúa visible y navegable a 60 fps, demostrando que la pantalla no depende de la red.

### Escenario PA-04: Reinicio completo en modo offline
1. Manteniendo el dispositivo en Modo Avión (sin Internet), **cerrar por completo la aplicación** (matar el proceso desde la lista de apps recientes).
2. Volver a abrir la aplicación desde el icono del lanzador.
3. La aplicación abre de inmediato sin pantallas en blanco ni bloqueos (OF-03), cargando el catálogo directamente desde SQLite local.

---

## 7. Estructura de Archivos del Proyecto

```
lib/
├── app/
├── core/
│   ├── constants/
│   │   ├── api_constants.dart      # URLs, timeouts y endpoints GraphQL v1beta2
│   │   └── app_colors.dart         # Paleta oficial por tipos de Pokémon
│   ├── database/
│   │   ├── daos/
│   │   │   ├── favorites_dao.dart  # Persistencia de favoritos
│   │   │   ├── pokemon_dao.dart    # Streams reactivos e inserción transaccional
│   │   │   └── sync_dao.dart       # Registro de metadatos de sincronización
│   │   ├── tables/
│   │   │   ├── pokemon_table.dart  # Tabla pokemons con contentHash
│   │   │   ├── pokemon_details_tables.dart # Tabla pokemon_types
│   │   │   └── user_data_tables.dart       # Tablas favorites y sync_metadata
│   │   ├── app_database.dart       # DriftDatabase con índices e inicialización SQLite/Wasm
│   │   └── app_database.g.dart     # Código generado por drift_dev
│   ├── errors/
│   │   ├── exceptions.dart         # Excepciones de red, servidor y BD
│   │   └── failures.dart           # Fallos de dominio
│   ├── network/
│   │   ├── api_health_service.dart # Monitor de disponibilidad de PokéAPI
│   │   ├── connectivity_service.dart # Monitor de conectividad física
│   │   └── connectivity_state.dart # Estados inmutables del indicador
│   ├── sync/
│   │   └── sync_coordinator.dart   # Orquestador de sincronización en 2do plano
│   ├── utils/
│   │   └── hash_helper.dart        # Utilidad SHA-256 para integridad
│   ├── widgets/
│   │   └── connectivity_banner.dart# Indicador global de conectividad (IND-01)
│   └── providers.dart              # Inyección de dependencias con Riverpod
├── features/
│   ├── favorites/                  # Capa de datos y contratos de favoritos
│   └── pokemon/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── pokemon_remote_data_source.dart # Query GraphQL v1beta2 paginada
│       │   └── repositories/
│       │       └── pokemon_repository_impl.dart     # Implementación del repositorio
│       ├── domain/
│       │   ├── entities/
│       │   │   └── pokemon_entity.dart              # Entidades puras de catálogo
│       │   └── repositories/
│       │       └── pokemon_repository.dart          # Interfaz abstracta del repositorio
│       └── presentation/
│           ├── providers/
│           │   └── catalog_provider.dart            # StreamProvider reactivo
│           ├── screens/
│           │   └── catalog_screen.dart              # Catálogo con los 3 estados
│           └── widgets/
│               └── pokemon_card.dart                # Tarjeta visual con gradientes y favoritos
└── main.dart                       # Punto de entrada con ProviderScope y HomeScreen
```

---

## 8. Justificación de Dependencias Externas (RNF-MAN-04)

| Dependencia | Versión | Justificación Técnica |
|---|---|---|
| `flutter_riverpod` | `^3.5.0` | Gestor de estado reactivo y desacoplado recomendado en la cátedra; provee `StreamProvider` para conectar SQLite con la UI sin boilerplate. |
| `drift` | `^2.35.4` | ORM de persistencia estructurada tipo-segura sobre SQLite; soporte de transacciones ACID y Streams reactivos. |
| `drift_flutter` | `^0.3.1` | Abstracción oficial de Drift para inicialización transparente de bases de datos tanto en Android/iOS como en WebAssembly. |
| `sqlite3_flutter_libs` | `^0.6.0+eol` | Binarios nativos de SQLite para Android y escritorio. |
| `http` | `^1.6.0` | Cliente HTTP ligero para ejecutar consultas GraphQL contra el endpoint PokéAPI `v1beta2` con control de timeout. |
| `connectivity_plus` | `^7.3.2` | Detección reactiva de cambios en el estado de red física (Wi-Fi, datos móviles, sin red). |
| `cached_network_image` | `^4.0.7` | Descarga, renderizado y persistencia en caché de disco de los artworks oficiales de Pokémon (OF-08). |
| `shared_preferences` | `^2.5.6` | Almacenamiento clave-valor de configuración básica del sistema. |
| `intl` | `^0.20.3` | Formateo legible de marcas de tiempo de sincronización. |
| `crypto` | `^3.0.8` | Generación de firmas hash SHA-256 para verificación de integridad de datos. |

---

## 9. Instrucciones de Instalación y Ejecución

### Requisitos previos:
* Flutter SDK $\ge 3.22$
* Dart SDK $\ge 3.4$
* Android Studio / VS Code con extensiones de Flutter
* Dispositivo móvil Android físico con depuración USB habilitada (o navegador web).

### Pasos:
1. Clonar el repositorio:
   ```bash
   git clone https://github.com/diaurys/pokedex-offline-first.git
   cd pokedex-offline-first
   ```
2. Instalar dependencias:
   ```bash
   flutter pub get
   ```
3. Generar el código de base de datos de Drift (si se requiere):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Ejecutar en dispositivo móvil Android conectado:
   ```bash
   flutter run
   ```
5. *(Opcional)* Ejecutar en PC mediante el script de Opera / Web:
   ```powershell
   .\run_opera.bat
   ```

---

## 10. Registros de Decisiones Arquitectónicas (ADR)
* [ADR-001: Adopción de Arquitectura Offline-First con Drift (SQLite) y Riverpod](docs/adr/ADR-001-offline-first-architecture.md)

---

## 11. Declaración de Uso de Inteligencia Artificial
* **Herramienta utilizada:** Antigravity (Google DeepMind) y modelos LLM.
* **Ámbito de uso:** Asistencia en la estructuración de la arquitectura limpia, redacción de consultas GraphQL adaptadas a la versión `v1beta2`, configuración de índices en tablas SQLite con Drift y redacción de documentación técnica.
* **Validación humana:** Todo el código generado fue inspeccionado, compilado, depurado y validado mediante `dart analyze lib` (0 errores, 0 warnings) y probado en vivo tanto en dispositivo físico Android como en navegador.
