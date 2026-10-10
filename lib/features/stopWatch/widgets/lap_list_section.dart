import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/lap_models.dart';
import 'lap_row.dart';

class LapListSection extends StatelessWidget {
  const LapListSection({
    super.key,
    required this.laps,
    required this.fastestLap,
    required this.slowestLap,
  });

  final List<LapModel> laps;
  final LapModel? fastestLap;
  final LapModel? slowestLap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
              vertical: AppDimens.paddingSmall,
            ),
            child: Row(
              children: [
                Text('Laps', style: AppTextStyles.headlineMedium),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
                  ),
                  child: Text(
                    '${laps.length}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                const Text('Lap time', style: AppTextStyles.labelMedium),
                const SizedBox(width: AppDimens.paddingXLarge),
                const Text('Total', style: AppTextStyles.labelMedium),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingMedium,
                vertical: AppDimens.paddingSmall,
              ),
              itemCount: laps.length,
              separatorBuilder: (_, _) =>
                  const Divider(color: AppColors.divider, height: 1),
              itemBuilder: (context, index) {
                final lap = laps[index];
                return LapRow(
                  lap: lap,
                  isFastest: fastestLap?.lapNumber == lap.lapNumber,
                  isSlowest: slowestLap?.lapNumber == lap.lapNumber,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
