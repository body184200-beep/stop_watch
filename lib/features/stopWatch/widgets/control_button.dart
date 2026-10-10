import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.size,
    this.gradient,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final double size;
  final LinearGradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: onTap != null ? gradient : null,
              color: onTap != null && gradient == null ? color : null,
              boxShadow: onTap != null
                  ? [
                      BoxShadow(
                        color: (gradient != null ? AppColors.primary : color)
                            .withValues(alpha: 0.35),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              color: onTap != null ? iconColor : AppColors.textHint,
              size: size * 0.45,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.labelMedium),
      ],
    );
  }
}
