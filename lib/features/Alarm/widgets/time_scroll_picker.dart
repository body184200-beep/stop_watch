import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class TimeScrollPicker extends StatelessWidget {
  const TimeScrollPicker({
    super.key,
    required this.value,
    required this.max,
    required this.onChanged,
  });

  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 72,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        perspective: 0.004,
        diameterRatio: 2.0,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: value),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index > max) return null;
            final isSelected = index == value;
            return Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: isSelected ? 36 : 24,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                  color: isSelected ? AppColors.primary : AppColors.textHint,
                ),
              ),
            );
          },
          childCount: max + 1,
        ),
      ),
    );
  }
}
