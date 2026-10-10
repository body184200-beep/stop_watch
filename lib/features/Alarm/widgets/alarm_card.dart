import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/alarm_model.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
  });

  final AlarmModel alarm;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(alarm.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.accent),
      ),
      onDismissed: (_) => onDelete(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: alarm.isEnabled
              ? AppColors.surface
              : AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          border: Border.all(
            color: alarm.isEnabled
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      alarm.formattedTime,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        color: alarm.isEnabled
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        alarm.period,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: alarm.isEnabled
                              ? AppColors.primary
                              : AppColors.textHint,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(alarm.label, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 2),
                Text(alarm.repeatLabel, style: AppTextStyles.labelMedium),
              ],
            ),
            const Spacer(),
            Switch.adaptive(
              value: alarm.isEnabled,
              onChanged: onToggle,
              activeThumbColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
              inactiveThumbColor: AppColors.textHint,
              inactiveTrackColor: AppColors.divider,
            ),
          ],
        ),
      ),
    );
  }
}
