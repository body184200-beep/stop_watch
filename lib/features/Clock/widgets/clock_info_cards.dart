import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class ClockInfoCards extends StatelessWidget {
  const ClockInfoCards({super.key, required this.dateTime});
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final tz = dateTime.timeZoneOffset.isNegative
        ? 'UTC-${dateTime.timeZoneOffset.inHours.abs()}'
        : 'UTC+${dateTime.timeZoneOffset.inHours}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
      child: Row(
        children: [
          _InfoCard(
            label: 'AM / PM',
            value: dateTime.hour < 12 ? 'AM' : 'PM',
            color: AppColors.primary,
          ),
          const SizedBox(width: AppDimens.paddingSmall),
          _InfoCard(
            label: 'Zone',
            value: tz,
            color: AppColors.secondary,
          ),
          const SizedBox(width: AppDimens.paddingSmall),
          _InfoCard(
            label: 'Day',
            value: _weekDay(dateTime.weekday),
            color: AppColors.success,
          ),
        ],
      ),
    );
  }

  String _weekDay(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, style: AppTextStyles.labelMedium),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
