import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_state.dart';
import '../providers.dart';
import '../theme/paper_theme.dart';

/// Sello de Goma Global de Conectividad ("Fichero Pokédex")
/// Reemplaza la barra digital moderna por un sello físico estampado con tinta en la cartulina.
/// - Animación de impacto de estampado (180 ms)
/// - Rotación fija de -2° imitando el trabajo de un naturalista en campo
/// - Al tocarlo muestra la nota de última sincronización sin bloquear la interfaz.
class RubberStampIndicator extends ConsumerStatefulWidget {
  final bool compact;

  const RubberStampIndicator({
    super.key,
    this.compact = false,
  });

  @override
  ConsumerState<RubberStampIndicator> createState() => _RubberStampIndicatorState();
}

class _RubberStampIndicatorState extends ConsumerState<RubberStampIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _stampController;
  late Animation<double> _scaleAnimation;
  ConnectivityIndicatorState? _prevState;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnimation = Tween<double>(begin: 1.15, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.easeOutBack),
    );
    _stampController.forward();
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }

  void _triggerStampAnimation() {
    _stampController.reset();
    _stampController.forward();
  }

  String _formatLastSyncTime(DateTime? time) {
    if (time == null) return 'Sin sincronizaciones previas';
    final diff = DateTime.now().difference(time);
    if (diff.inSeconds < 45) return 'Hace unos segundos';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} h';
    return 'Hace ${diff.inDays} d';
  }

  void _showStampDetails(BuildContext context, ConnectivityIndicatorState state) {
    final syncInfo = _formatLastSyncTime(state.lastSyncTime);
    final statusDetail = switch (state.availability) {
      ApiAvailability.online when state.isSyncing =>
        'Descargando especímenes desde PokéAPI GraphQL a SQLite local.',
      ApiAvailability.online =>
        'Conexión activa. Los datos se leen directamente de SQLite local (0 ms de latencia).',
      ApiAvailability.serviceUnavailable =>
        'Hay red pero PokéAPI no responde. El catálogo sigue operativo con SQLite.',
      ApiAvailability.offline =>
        'Sin conexión de red física. Modo autónomo habilitado sobre SQLite.',
    };

    showModalBottomSheet(
      context: context,
      backgroundColor: PaperColors.cardLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: PaperColors.cardBorderLight, width: 1.5),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Solapa de expediente
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: PaperColors.inkFaintLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.bookmark_border, color: PaperColors.inkPrimaryLight, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'NOTA DE REGISTRO DE CAMPO',
                    style: PaperTypography.typewriter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: PaperColors.inkPrimaryLight,
                    ),
                  ),
                ],
              ),
              const Divider(color: PaperColors.inkFaintLight, thickness: 1, height: 24),
              Text(
                statusDetail,
                style: const TextStyle(
                  fontFamilyFallback: PaperTypography.serifFallbacks,
                  fontSize: 15,
                  height: 1.4,
                  color: PaperColors.inkPrimaryLight,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.history, size: 16, color: PaperColors.inkSecondaryLight),
                  const SizedBox(width: 6),
                  Text(
                    'Última sincronización: $syncInfo',
                    style: PaperTypography.typewriter(
                      fontSize: 12,
                      color: PaperColors.inkSecondaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.storage, size: 16, color: PaperColors.stampGreen),
                  const SizedBox(width: 6),
                  Text(
                    'Persistencia: Drift SQLite (Offline-First)',
                    style: PaperTypography.typewriter(
                      fontSize: 12,
                      color: PaperColors.stampGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.sync, size: 18),
                  label: Text(
                    'FORZAR SINCRONIZACIÓN CON POKÉAPI',
                    style: PaperTypography.typewriter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PaperColors.inkPrimaryLight,
                    side: const BorderSide(color: PaperColors.inkPrimaryLight, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ref.read(syncCoordinatorProvider).syncCatalog(force: true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indicatorAsync = ref.watch(connectivityIndicatorProvider);

    return indicatorAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
      data: (state) {
        if (_prevState != null &&
            (_prevState!.availability != state.availability ||
                _prevState!.isSyncing != state.isSyncing)) {
          _triggerStampAnimation();
        }
        _prevState = state;

        final (label, icon, color) = switch (state.availability) {
          ApiAvailability.online when state.isSyncing => (
              'SINCRONIZANDO',
              Icons.autorenew,
              PaperColors.stampBlue,
            ),
          ApiAvailability.online => (
              'EN LÍNEA',
              Icons.wifi,
              PaperColors.stampGreen,
            ),
          ApiAvailability.serviceUnavailable => (
              'SERVICIO CAÍDO',
              Icons.cloud_off,
              PaperColors.stampAmber,
            ),
          ApiAvailability.offline => (
              'SIN CONEXIÓN',
              Icons.wifi_off,
              PaperColors.stampRed,
            ),
        };

        return ScaleTransition(
          scale: _scaleAnimation,
          child: Transform.rotate(
            angle: -0.035, // -2° de giro manual de estampación
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => _showStampDetails(context, state),
                child: Container(
                  padding: widget.compact
                      ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
                      : const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    border: Border.all(
                      color: color.withValues(alpha: 0.85),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.isSyncing)
                        _RotatingSyncIcon(color: color, size: widget.compact ? 12 : 14)
                      else
                        Icon(icon, size: widget.compact ? 12 : 14, color: color),
                      const SizedBox(width: 5),
                      Text(
                        label,
                        style: PaperTypography.typewriter(
                          fontSize: widget.compact ? 9.5 : 11,
                          fontWeight: FontWeight.w900,
                          color: color,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RotatingSyncIcon extends StatefulWidget {
  final Color color;
  final double size;

  const _RotatingSyncIcon({required this.color, required this.size});

  @override
  State<_RotatingSyncIcon> createState() => _RotatingSyncIconState();
}

class _RotatingSyncIconState extends State<_RotatingSyncIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotController;

  @override
  void initState() {
    super.initState();
    _rotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _rotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotController,
      builder: (_, child) => Transform.rotate(
        angle: _rotController.value * 2 * math.pi,
        child: child,
      ),
      child: Icon(Icons.sync, size: widget.size, color: widget.color),
    );
  }
}
