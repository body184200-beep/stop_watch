import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../logic/stopwatch_logic.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.state});
  final StopwatchState state;

  @override
  Widget build(BuildContext context) {
    final (Color color, String label) = switch (state) {
      StopwatchState.idle => (AppColors.textHint, 'Ready'),
      StopwatchState.running => (AppColors.success, 'Running'),
      StopwatchState.paused => (AppColors.warning, 'Paused'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: color)),
        ],
      ),
    );
  }
}
