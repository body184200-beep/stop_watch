import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../widgets/control_button.dart';

class StopwatchControls extends StatelessWidget {
  const StopwatchControls({
    super.key,
    required this.isRunning,
    required this.hasStarted,
    required this.onStartPause,
    required this.onLapReset,
  });

  final bool isRunning;
  final bool hasStarted;
  final VoidCallback onStartPause;
  final VoidCallback onLapReset;

  @override
  Widget build(BuildContext context) {
    final bool showSecondary = hasStarted;
    final bool secondaryIsReset = !isRunning && hasStarted;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingMedium,
        horizontal: AppDimens.paddingMedium,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppDimens.buttonSizeSmall,
              child: AnimatedOpacity(
                opacity: showSecondary ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: ControlButton(
                  icon: secondaryIsReset ? Icons.refresh_rounded : Icons.flag_rounded,
                  label: secondaryIsReset ? 'Reset' : 'Lap',
                  color: AppColors.surfaceVariant,
                  iconColor: secondaryIsReset ? AppColors.accent : AppColors.textSecondary,
                  size: AppDimens.buttonSizeSmall,
                  onTap: showSecondary ? onLapReset : null,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            ControlButton(
              icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
              label: isRunning ? 'Pause' : (hasStarted ? 'Resume' : 'Start'),
              color: isRunning ? AppColors.accent : AppColors.primary,
              iconColor: Colors.white,
              size: AppDimens.buttonSize,
              gradient: isRunning ? null : AppColors.primaryGradient,
              onTap: onStartPause,
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            const SizedBox(width: AppDimens.buttonSizeSmall),
          ],
        ),
      ),
    );
  }
}
