import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/alarm_model.dart';
import 'time_scroll_picker.dart';

class AddAlarmBottomSheet extends StatefulWidget {
  const AddAlarmBottomSheet({super.key, required this.onSave});
  final ValueChanged<AlarmModel> onSave;

  static void show(BuildContext context, {required ValueChanged<AlarmModel> onSave}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.radiusXLarge)),
      ),
      isScrollControlled: true,
      builder: (_) => AddAlarmBottomSheet(onSave: onSave),
    );
  }

  @override
  State<AddAlarmBottomSheet> createState() => _AddAlarmBottomSheetState();
}

class _AddAlarmBottomSheetState extends State<AddAlarmBottomSheet> {
  int _selectedHour = 8;
  int _selectedMinute = 0;
  final _labelController = TextEditingController(text: 'New Alarm');

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('New Alarm', style: AppTextStyles.headlineLarge),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeScrollPicker(
                value: _selectedHour,
                max: 23,
                onChanged: (v) => setState(() => _selectedHour = v),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(':',
                    style: TextStyle(
                        fontSize: 40, color: AppColors.textPrimary, fontWeight: FontWeight.w300)),
              ),
              TimeScrollPicker(
                value: _selectedMinute,
                max: 59,
                onChanged: (v) => setState(() => _selectedMinute = v),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _labelController,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              labelText: 'Label',
              labelStyle: AppTextStyles.bodyMedium,
              filled: true,
              fillColor: AppColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              ),
              child: TextButton(
                onPressed: () {
                  widget.onSave(AlarmModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    hour: _selectedHour,
                    minute: _selectedMinute,
                    label: _labelController.text.isEmpty ? 'Alarm' : _labelController.text,
                  ));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save Alarm',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
