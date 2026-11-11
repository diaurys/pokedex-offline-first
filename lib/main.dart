import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_colors.dart';
import 'core/providers.dart';
import 'core/widgets/connectivity_banner.dart';
import 'features/favorites/presentation/screens/favorites_screen.dart';
import 'features/pokemon/presentation/screens/catalog_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/trivia/presentation/screens/trivia_screen.dart';

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
      home: const MainNavigationShell(),
    );
  }
}

/// Contenedor principal con barra de navegación inferior y banner de conectividad fijo (IND-01 a IND-05)
class MainNavigationShell extends ConsumerStatefulWidget {
  const MainNavigationShell({super.key});

  @override
  ConsumerState<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends ConsumerState<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CatalogScreen(),
    FavoritesScreen(),
    TriviaScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = const [
    'Pokédex Offline',
    'Mis Favoritos',
    'Trivia Pokémon',
    'Inspector & Pruebas PA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.catching_pokemon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              _titles[_currentIndex],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
              ref.read(syncCoordinatorProvider).syncCatalog(force: true);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Indicador Global de Conectividad visible en toda la aplicación (IND-01 a IND-05)
          const ConnectivityBanner(),

          // 2. Pantalla activa según la pestaña seleccionada
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            selectedIcon: Icon(Icons.catching_pokemon, color: AppColors.primaryRed),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite, color: AppColors.primaryRed),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports, color: AppColors.primaryRed),
            label: 'Trivia',
          ),
          NavigationDestination(
            icon: Icon(Icons.science_outlined),
            selectedIcon: Icon(Icons.science, color: AppColors.primaryRed),
            label: 'Inspector PA',
          ),
        ],
      ),
    );
  }
}
