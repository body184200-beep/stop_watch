import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/lap_models.dart';

class LapRow extends StatelessWidget {
  const LapRow({
    super.key,
    required this.lap,
    required this.isFastest,
    required this.isSlowest,
  });

  final LapModel lap;
  final bool isFastest;
  final bool isSlowest;

  @override
  Widget build(BuildContext context) {
    final Color? highlightColor = isFastest
        ? AppColors.success
        : isSlowest
            ? AppColors.accent
            : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: highlightColor?.withValues(alpha: 0.15) ?? AppColors.surfaceVariant,
              border: highlightColor != null
                  ? Border.all(color: highlightColor.withValues(alpha: 0.4))
                  : null,
            ),
            child: Center(
              child: Text(
                '${lap.lapNumber}',
                style: AppTextStyles.labelMedium.copyWith(
                  color: highlightColor ?? AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingSmall),
          if (isFastest || isSlowest)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: highlightColor!.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
              ),
              child: Text(
                isFastest ? 'Best' : 'Slow',
                style: AppTextStyles.labelMedium.copyWith(
                  color: highlightColor,
                  fontSize: 10,
                ),
              ),
            ),
          const Spacer(),
          Text(
            _formatTime(lap.lapTimeMs),
            style: AppTextStyles.bodyLarge.copyWith(
              color: highlightColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: AppDimens.paddingXLarge),
          SizedBox(
            width: 72,
            child: Text(
              _formatTime(lap.totalTimeMs),
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMedium.copyWith(fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int ms) {
    final int centis = (ms ~/ 10) % 100;
    final int secs = (ms ~/ 1000) % 60;
    final int mins = (ms ~/ 60000) % 60;
    final int hrs = ms ~/ 3600000;
    final pSecs = secs.toString().padLeft(2, '0');
    final pCentis = centis.toString().padLeft(2, '0');
    final pMins = mins.toString().padLeft(2, '0');
    if (hrs > 0) {
      return '${hrs.toString().padLeft(2, '0')}:$pMins:$pSecs.$pCentis';
    }
    return '$pMins:$pSecs.$pCentis';
  }
}
