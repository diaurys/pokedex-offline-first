import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../network/connectivity_state.dart';
import '../providers.dart';

/// Indicador Global de Conectividad (IND-01 a IND-05)
/// Fijo y visible en las pantallas principales, reactivo con Riverpod
class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicatorAsync = ref.watch(connectivityIndicatorProvider);

    return indicatorAsync.when(
      data: (state) => _buildBanner(context, ref, state),
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildBanner(
    BuildContext context,
    WidgetRef ref,
    ConnectivityIndicatorState state,
  ) {
    Color bannerColor;
    IconData icon;
    String statusTitle;
    String statusSubtitle;
    String semanticsDescription;

    if (state.isSyncing) {
      // Estado 4: Sincronizando en segundo plano (IND-02)
      bannerColor = AppColors.statusSyncing;
      icon = Icons.sync;
      statusTitle = 'Sincronizando con PokéAPI';
      statusSubtitle = 'Actualizando persistencia local en segundo plano...';
      semanticsDescription = 'Estado de red: Sincronizando catálogo con PokeAPI';
    } else if (state.isOnline) {
      // Estado 1: En línea y API disponible (IND-02)
      bannerColor = AppColors.statusOnline;
      icon = Icons.cloud_done;
      statusTitle = 'En línea — PokéAPI disponible';
      statusSubtitle = _formatSyncTime(state.lastSyncTime);
      semanticsDescription = 'Estado de red: En línea. PokeAPI disponible.';
    } else if (state.isServiceUnavailable) {
      // Estado 3: Red activa pero API caída / timeout (IND-02, PA-08)
      bannerColor = AppColors.statusServiceUnavailable;
      icon = Icons.cloud_off;
      statusTitle = 'Servicio no disponible (PA-08)';
      statusSubtitle = 'Hay red pero PokeAPI no responde. Usando SQLite.';
      semanticsDescription = 'Estado de red: Servicio no disponible. PokeAPI no responde.';
    } else {
      // Estado 2: Modo sin conexión física (IND-02, OF-05)
      bannerColor = AppColors.statusOffline;
      icon = Icons.wifi_off;
      statusTitle = 'Modo sin conexión (Offline-First)';
      statusSubtitle = 'Operando con datos almacenados en SQLite.';
      semanticsDescription = 'Estado de red: Modo sin conexión. Usando catálogo local.';
    }

    return Semantics(
      label: semanticsDescription,
      container: true,
      child: Material(
        color: bannerColor,
        elevation: 2,
        child: InkWell(
          onTap: () {
            ref.read(connectivityIndicatorProvider.notifier).refreshAvailability();
            ref.read(syncCoordinatorProvider).syncCatalog(force: true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Comprobando disponibilidad del servicio...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                if (state.isSyncing)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else
                  Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        statusTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        statusSubtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'SQLite',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatSyncTime(DateTime? lastSync) {
    if (lastSync == null) return 'Fuente: SQLite local · Sin sincronizaciones previas';
    final formatter = DateFormat('HH:mm:ss');
    return 'Fuente: SQLite local · Última sync: ${formatter.format(lastSync)}';
  }
}
