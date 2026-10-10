import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    super.key,
    required this.elapsedMs,
    required this.lapsCount,
    required this.currentLapMs,
  });

  final int elapsedMs;
  final int lapsCount;
  final int currentLapMs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatTime(elapsedMs),
              style: AppTextStyles.displayLarge.copyWith(fontSize: 42),
            ),
          ),
          if (lapsCount > 0) ...[
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Lap ${lapsCount + 1}  •  ${formatTime(currentLapMs)}',
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
