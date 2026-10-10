import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    super.key,
    required this.focused,
    required this.selected,
    required this.onMonthChanged,
    required this.onDateSelected,
    required this.onResetToToday,
  });

  final DateTime focused;
  final DateTime? selected;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onResetToToday;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _dayLabels = [
    'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su',
  ];

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(focused.year, focused.month, 1);
    final startOffset = (firstDay.weekday - 1) % 7;
    final daysInMonth = DateTime(focused.year, focused.month + 1, 0).day;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
                  onPressed: () => onMonthChanged(DateTime(focused.year, focused.month - 1)),
                ),
                GestureDetector(
                  onTap: onResetToToday,
                  child: Text(
                    '${_monthNames[focused.month - 1]} ${focused.year}',
                    style: AppTextStyles.headlineMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                  onPressed: () => onMonthChanged(DateTime(focused.year, focused.month + 1)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: _dayLabels.map((d) {
                final isWeekend = d == 'Sa' || d == 'Su';
                return Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isWeekend
                            ? AppColors.accent.withValues(alpha: 0.6)
                            : AppColors.textHint,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1,
              ),
              itemCount: startOffset + daysInMonth,
              itemBuilder: (context, index) {
                if (index < startOffset) return const SizedBox.shrink();
                final day = index - startOffset + 1;
                final date = DateTime(focused.year, focused.month, day);
                final isToday = _isSameDay(date, DateTime.now());
                final isSelected = selected != null && _isSameDay(date, selected!);
                final isWeekend = date.weekday == 6 || date.weekday == 7;

                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isToday && !isSelected
                          ? AppColors.primary.withValues(alpha: 0.15)
                          : null,
                      border: isToday && !isSelected
                          ? Border.all(color: AppColors.primary.withValues(alpha: 0.5))
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isToday || isSelected ? FontWeight.w700 : FontWeight.w400,
                          color: isSelected
                              ? Colors.white
                              : isToday
                                  ? AppColors.primary
                                  : isWeekend
                                      ? AppColors.accent.withValues(alpha: 0.7)
                                      : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
