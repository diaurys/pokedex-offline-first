import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_colors.dart';
import 'core/providers.dart';
import 'core/widgets/connectivity_banner.dart';
import 'features/pokemon/presentation/screens/catalog_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Offline-First',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryRed,
          primary: AppColors.primaryRed,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.lightBackground,
      ),
      home: const HomeScreen(),
    );
  }
}

/// Pantalla Principal del Avance (40% del Proyecto)
/// Estructura limpia y fácil de explicar:
/// 1. AppBar con sincronización manual.
/// 2. Indicador Global de Conectividad (IND-01, IND-05) que muestra Online/Offline y fuente SQLite.
/// 3. Catálogo de Pokémon (RF-CAT-01, RF-CAT-04) que observa exclusivamente SQLite (OF-16, 17, 18).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.catching_pokemon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Pokédex Offline-First',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar Catálogo',
            onPressed: () {
              // Dispara sincronización asíncrona sin bloquear la UI (OF-03, PA-01)
              ref.read(syncCoordinatorProvider).syncCatalog(force: true);
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          // 1. Indicador Global de Conectividad (Entregable 8: IND-01, IND-05)
          ConnectivityBanner(),

          // 2. Catálogo Funcional que observa SQLite reactivamente (Entregable 4 y 6: OF-16, RF-CAT-01)
          Expanded(
            child: CatalogScreen(),
          ),
        ],
      ),
    );
  }
}
