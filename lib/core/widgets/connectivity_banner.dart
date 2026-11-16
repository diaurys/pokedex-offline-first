import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../theme/paper_theme.dart';
import 'rubber_stamp_indicator.dart';

/// Cinta de Control de Archivo y Conectividad (IND-01 a IND-05)
/// Diseñado como una tira de cartulina técnica de campo que acompaña al fichero:
/// - Sello de procedencia de almacenamiento local Drift SQLite
/// - Sello de goma físico con estado de red
/// - Tocar la tira permite refrescar y verificar el estado sin bloquear la UI
class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicatorAsync = ref.watch(connectivityIndicatorProvider);

    return indicatorAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
      data: (state) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: PaperColors.cardLight,
            border: Border(
              bottom: BorderSide(color: PaperColors.cardBorderLight, width: 1.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Procedencia de datos (SQLite Local)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.isOnline
                          ? PaperColors.stampGreen
                          : PaperColors.stampRed,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ARCHIVO LOCAL: SQLITE',
                    style: PaperTypography.typewriter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: PaperColors.inkSecondaryLight,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),

              // 2. Sello de goma interactivo con rotación analógica
              const RubberStampIndicator(compact: true),
            ],
          ),
        );
      },
    );
  }
}
