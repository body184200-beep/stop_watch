import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class AnalogClockPainter extends CustomPainter {
  const AnalogClockPainter({required this.dateTime});
  final DateTime dateTime;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(
      center,
      radius - 2,
      Paint()
        ..color = AppColors.cardBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawCircle(
      center,
      radius - 4,
      Paint()
        ..color = AppColors.surfaceVariant
        ..style = PaintingStyle.fill,
    );

    final rect = Rect.fromCircle(center: center, radius: radius - 4);
    canvas.drawArc(
      rect,
      0,
      2 * math.pi,
      false,
      Paint()
        ..shader = const SweepGradient(
          colors: [AppColors.primary, AppColors.secondary, AppColors.primary],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    for (int i = 0; i < 12; i++) {
      final angle = (i * math.pi / 6) - math.pi / 2;
      final isQuarter = i % 3 == 0;
      final outerR = radius - 12;
      final innerR = outerR - (isQuarter ? 12.0 : 6.0);

      canvas.drawLine(
        Offset(center.dx + outerR * math.cos(angle), center.dy + outerR * math.sin(angle)),
        Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle)),
        Paint()
          ..color = isQuarter ? AppColors.textSecondary : AppColors.textHint
          ..strokeWidth = isQuarter ? 2.5 : 1.5
          ..strokeCap = StrokeCap.round,
      );
    }

    _drawHand(
      canvas,
      center,
      angle: ((dateTime.hour % 12 + dateTime.minute / 60) / 12) * 2 * math.pi - math.pi / 2,
      length: radius * 0.52,
      width: 5,
      color: AppColors.textPrimary,
    );

    _drawHand(
      canvas,
      center,
      angle: ((dateTime.minute + dateTime.second / 60) / 60) * 2 * math.pi - math.pi / 2,
      length: radius * 0.72,
      width: 3.5,
      color: AppColors.primary,
    );

    _drawHand(
      canvas,
      center,
      angle: (dateTime.second / 60) * 2 * math.pi - math.pi / 2,
      length: radius * 0.78,
      width: 1.5,
      color: AppColors.accent,
    );

    canvas.drawCircle(center, 6, Paint()..color = AppColors.primary);
    canvas.drawCircle(center, 3, Paint()..color = AppColors.background);
  }

  void _drawHand(
    Canvas canvas,
    Offset center, {
    required double angle,
    required double length,
    required double width,
    required Color color,
  }) {
    canvas.drawLine(
      center,
      Offset(
        center.dx + length * math.cos(angle),
        center.dy + length * math.sin(angle),
      ),
      Paint()
        ..color = color
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(AnalogClockPainter old) =>
      old.dateTime.second != dateTime.second;
}
