import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../widgets/calendar_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppDimens.paddingMedium),
          child: Column(
            children: [
              _buildHeader(),
              CalendarCard(
                focused: _focused,
                selected: _selected,
                onMonthChanged: (newMonth) => setState(() => _focused = newMonth),
                onDateSelected: (date) => setState(() => _selected = date),
                onResetToToday: () => setState(() {
                  _focused = DateTime.now();
                  _selected = DateTime.now();
                }),
              ),
              if (_selected != null) _buildSelectedInfo(_selected!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingMedium,
      ),
      child: ShaderMask(
        shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Calendar',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedInfo(DateTime d) {
    final diff = d.difference(DateTime.now()).inDays;
    final isToday = d.year == DateTime.now().year &&
        d.month == DateTime.now().month &&
        d.day == DateTime.now().day;

    final subtitle = isToday
        ? 'Today'
        : (diff == 1
            ? 'Tomorrow'
            : (diff == -1 ? 'Yesterday' : (diff > 0 ? 'In $diff days' : '${diff.abs()} days ago')));

    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingMedium),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              ),
              child: Center(
                child: Text(
                  '${d.day}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_weekDays[d.weekday - 1]}, ${_monthNames[d.month - 1]} ${d.day}',
                    style: AppTextStyles.bodyLarge,
                  ),
                  Text(subtitle, style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
