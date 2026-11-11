import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/api_constants.dart';
import 'core/constants/app_colors.dart';
import 'core/providers.dart';
import 'core/widgets/connectivity_banner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Offline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryRed),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.catching_pokemon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Pokédex Offline-First',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar',
            onPressed: () {
              ref.read(syncCoordinatorProvider).syncCatalog(force: true);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Indicador Global de Conectividad (IND-01 a IND-05)
          const ConnectivityBanner(),

          // 2. Contenido de prueba interactiva
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.catching_pokemon,
                    size: 80,
                    color: AppColors.primaryRed,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Fase 5: Indicador de Conectividad',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'La barra superior está viva y conectada a la base de datos SQLite y al monitor de red.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // Botón 1: Forzar Sincronización (azul)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.sync),
                      label: const Text('Probar Sincronización (Ver Azul)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.statusSyncing,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ref.read(syncCoordinatorProvider).syncCatalog(force: true);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botón 2: Simular Caída de API con red activa (PA-08, ver naranja)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.warning_amber),
                      label: const Text('Simular API Caída PA-08 (Ver Naranja)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.statusServiceUnavailable,
                        side: const BorderSide(
                          color: AppColors.statusServiceUnavailable,
                          width: 2,
                        ),
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final current =
                            prefs.getBool(ApiConstants.prefSimulateApiDown) ?? false;
                        await prefs.setBool(
                            ApiConstants.prefSimulateApiDown, !current);
                        ref
                            .read(connectivityIndicatorProvider.notifier)
                            .refreshAvailability();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tarjeta informativa
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🧪 Pruebas que puedes hacer ahora mismo:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text('1. Apaga el Wi-Fi de tu celular: la barra pasa a ROJO.'),
                        Text('2. Enciende el Wi-Fi: pasa a AZUL y luego a VERDE.'),
                        Text('3. Pulsa el botón naranja: simula fallo de API (PA-08).'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
