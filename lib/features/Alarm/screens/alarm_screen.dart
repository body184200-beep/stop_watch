import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/alarm_model.dart';
import '../widgets/add_alarm_sheet.dart';
import '../widgets/alarm_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<AlarmModel> _alarms = [
    AlarmModel(
      id: 1,
      hour: 7,
      minute: 0,
      label: 'Wake up',
      isEnabled: true,
      repeatDays: [true, true, true, true, true, false, false],
    ),
    AlarmModel(
      id: 2,
      hour: 12,
      minute: 30,
      label: 'Lunch break',
      isEnabled: false,
      repeatDays: List.filled(7, false),
    ),
    AlarmModel(
      id: 3,
      hour: 22,
      minute: 0,
      label: 'Sleep time',
      isEnabled: true,
      repeatDays: List.filled(7, true),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: _alarms.isEmpty ? _buildEmptyState() : _buildAlarmList(),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => AddAlarmBottomSheet.show(
          context,
          onSave: (newAlarm) => setState(() => _alarms.add(newAlarm)),
        ),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
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
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'Alarms',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          const Spacer(),
          Text(
            '${_alarms.where((a) => a.isEnabled).length} active',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm_off_rounded, size: 72, color: AppColors.textHint),
          SizedBox(height: 16),
          Text('No alarms', style: AppTextStyles.headlineMedium),
          SizedBox(height: 8),
          Text('Tap + to add your first alarm', style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildAlarmList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMedium,
        vertical: AppDimens.paddingSmall,
      ),
      itemCount: _alarms.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimens.paddingSmall),
      itemBuilder: (context, index) {
        final alarm = _alarms[index];
        return AlarmCard(
          alarm: alarm,
          onToggle: (value) => setState(() => _alarms[index] = alarm.copyWith(isEnabled: value)),
          onDelete: () => setState(() => _alarms.removeAt(index)),
        );
      },
    );
  }
}
