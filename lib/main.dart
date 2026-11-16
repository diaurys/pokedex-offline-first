import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers.dart';
import 'core/theme/paper_theme.dart';
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
      title: 'Fichero Pokédex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: PaperColors.paperBackgroundLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: PaperColors.inkPrimaryLight,
          primary: PaperColors.inkPrimaryLight,
          surface: PaperColors.cardLight,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: PaperColors.cardLight,
          foregroundColor: PaperColors.inkPrimaryLight,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontFamilyFallback: PaperTypography.typewriterFallbacks,
            color: PaperColors.inkPrimaryLight,
            fontSize: 16.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        extensions: const [
          PaperThemeExtension.light,
        ],
      ),
      home: const HomeScreen(),
    );
  }
}

/// Pantalla Principal del Avance (40% del Proyecto)
/// Concepto Rector: "Fichero Pokédex" (Archivador analógico de un naturalista)
///
/// Componentes principales para la defensa ante el profesor:
/// 1. Cabecera técnica de archivador con acción de sincronización en segundo plano.
/// 2. Cinta de control de conectividad con indicador de persistencia SQLite y Sello de Goma reactivo (IND-01 a IND-05).
/// 3. Catálogo de Fichas de Cartulina observando reactivamente SQLite con Drift (OF-16, RF-CAT-01).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: PaperColors.paperBackgroundLight,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: PaperColors.cardBorderLight, width: 1.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.menu_book, color: PaperColors.inkPrimaryLight, size: 21),
            SizedBox(width: 10),
            Text('FICHERO POKÉDEX'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync, color: PaperColors.inkPrimaryLight),
            tooltip: 'Sincronizar con PokéAPI',
            onPressed: () {
              // Dispara sincronización en segundo plano sin bloquear la UI (OF-03, PA-01)
              ref.read(syncCoordinatorProvider).syncCatalog(force: true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sincronizando archivo en segundo plano...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          // 1. Cinta de control y Sello Global de Conectividad (IND-01 a IND-05)
          ConnectivityBanner(),

          // 2. Catálogo de Fichas Técnicas que observa exclusivamente SQLite (OF-16, RF-CAT-01)
          Expanded(
            child: CatalogScreen(),
          ),
        ],
      ),
    );
  }
}
