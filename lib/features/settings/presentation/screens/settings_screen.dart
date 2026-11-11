import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers.dart';

/// Pantalla de Depuración e Inspector de Base de Datos para el docente (PA-08, PA-13, PA-16)
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isApiDownSimulated = false;
  int _pokemonCount = 0;
  int _typesCount = 0;
  int _favoritesCount = 0;
  int _triviaCount = 0;
  String _lastSyncInfo = 'Nunca';
  bool _isLoadingCounts = true;

  @override
  void initState() {
    super.initState();
    _loadSettingsAndCounts();
  }

  Future<void> _loadSettingsAndCounts() async {
    setState(() => _isLoadingCounts = true);
    final prefs = await SharedPreferences.getInstance();
    final isDown = prefs.getBool(ApiConstants.prefSimulateApiDown) ?? false;

    final db = ref.read(appDatabaseProvider);
    final pCount = await db.pokemons.count().getSingle();
    final tCount = await db.pokemonTypes.count().getSingle();
    final fCount = await db.favorites.count().getSingle();
    final trCount = await db.triviaRecords.count().getSingle();

    final lastSync = await ref.read(syncDaoProvider).getLastSyncTime('catalog_sync');
    final lastSyncText = lastSync != null
        ? '${lastSync.day}/${lastSync.month}/${lastSync.year} ${lastSync.hour.toString().padLeft(2, '0')}:${lastSync.minute.toString().padLeft(2, '0')}:${lastSync.second.toString().padLeft(2, '0')}'
        : 'Nunca';

    if (mounted) {
      setState(() {
        _isApiDownSimulated = isDown;
        _pokemonCount = pCount;
        _typesCount = tCount;
        _favoritesCount = fCount;
        _triviaCount = trCount;
        _lastSyncInfo = lastSyncText;
        _isLoadingCounts = false;
      });
    }
  }

  Future<void> _toggleApiSimulation(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ApiConstants.prefSimulateApiDown, value);
    setState(() {
      _isApiDownSimulated = value;
    });
    // Forzamos comprobación de salud de red
    ref.read(connectivityIndicatorProvider.notifier).refreshAvailability();
  }

  Future<void> _tamperFirstPokemon() async {
    final db = ref.read(appDatabaseProvider);
    final firstPokemon = await (db.select(db.pokemons)..limit(1)).getSingleOrNull();

    if (firstPokemon == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay Pokémon en la base de datos para alterar.')),
      );
      return;
    }

    // Alteramos el nombre directamente en SQLite sin actualizar el hash (PA-16)
    final tamperedName = '${firstPokemon.name}_ALTERADO';
    await ref.read(pokemonDaoProvider).simulateTamperPokemon(firstPokemon.id, tamperedName);

    await _loadSettingsAndCounts();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.amber.shade900,
        content: Text(
          '¡Dato alterado en SQLite! #${firstPokemon.id} ahora es "$tamperedName". Ve a su detalle para ver la advertencia OF-19.',
        ),
      ),
    );
  }

  Future<void> _clearDatabase() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Limpiar base de datos local?'),
        content: const Text(
          'Esto eliminará todos los Pokémon y detalles de SQLite para permitir probar la instalación limpia (PA-01 y PA-15). Los favoritos se mantendrán según OF-21.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.statusOffline,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar Catálogo'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = ref.read(appDatabaseProvider);
      await db.delete(db.pokemons).go();
      await db.delete(db.pokemonTypes).go();
      await db.delete(db.pokemonStats).go();
      await db.delete(db.pokemonAbilities).go();
      await db.delete(db.pokemonMoves).go();
      await db.delete(db.pokemonEvolutions).go();
      await _loadSettingsAndCounts();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Catálogo local eliminado. La app está en estado vacío (PA-15).')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: RefreshIndicator(
        onRefresh: _loadSettingsAndCounts,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. Tarjeta de Simulación de Caída de API (PA-08)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.cloud_off,
                          color: _isApiDownSimulated
                              ? AppColors.statusServiceUnavailable
                              : Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Simulador de Caída de API (PA-08)',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Switch(
                          value: _isApiDownSimulated,
                          activeThumbColor: AppColors.statusServiceUnavailable,
                          onChanged: _toggleApiSimulation,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isApiDownSimulated
                          ? '⚠️ Simulación ACTIVA: GraphQL está inaccesible con Internet encendido. El indicador se torna Naranja (Servicio no disponible, IND-03).'
                          : 'Inactivo: Conexión normal con https://graphql.pokeapi.co/v1beta2.',
                      style: TextStyle(
                        color: _isApiDownSimulated
                            ? AppColors.statusServiceUnavailable
                            : Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 2. Inspector de Base de Datos SQLite (PA-13, PA-16)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.storage, color: AppColors.primaryRed),
                            SizedBox(width: 10),
                            Text(
                              'Inspector SQLite Local',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 20),
                          tooltip: 'Recargar métricas',
                          onPressed: _loadSettingsAndCounts,
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),

                    if (_isLoadingCounts)
                      const Center(child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(),
                      ))
                    else ...[
                      _buildDbRow('Pokémon en Catálogo:', '$_pokemonCount registros'),
                      _buildDbRow('Tipos asociados en BD:', '$_typesCount registros'),
                      _buildDbRow('Favoritos del usuario (OF-21):', '$_favoritesCount guardados'),
                      _buildDbRow('Historial de Trivia:', '$_triviaCount partidas'),
                      _buildDbRow('Última Sincronización:', _lastSyncInfo),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Herramientas de Demostración Técnica (PA-15, PA-16)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.science, color: Colors.indigo),
                        SizedBox(width: 10),
                        Text(
                          'Escenarios de Prueba en Vivo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Botón para PA-16: Simular alteración local
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.edit_note, color: Colors.amber),
                        label: const Text('Alterar 1er Pokémon en SQLite (PA-16)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.amber.shade900,
                          side: BorderSide(color: Colors.amber.shade700),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _tamperFirstPokemon,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Modifica el registro en SQLite para disparar la detección por Hash SHA-256 y demostrar la regla OF-19.',
                      style: TextStyle(color: Colors.black54, fontSize: 11),
                    ),
                    const SizedBox(height: 14),

                    // Botón para PA-15: Limpiar base de datos
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.delete_sweep, color: AppColors.statusOffline),
                        label: const Text('Vaciar Catálogo Local (PA-15)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.statusOffline,
                          side: const BorderSide(color: AppColors.statusOffline),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _clearDatabase,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Permite demostrar que la app maneja la ausencia total de datos con estados vacíos claros.',
                      style: TextStyle(color: Colors.black54, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Pokédex Offline-First · PUCMM 2026\nDesarrollado con Clean Architecture, Riverpod & Drift',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDbRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 13)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
