import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class AnimatedRing extends StatelessWidget {
  const AnimatedRing({
    super.key,
    required this.progress,
    required this.isRunning,
    required this.pulseController,
    required this.child,
  });

  final double progress;
  final bool isRunning;
  final AnimationController pulseController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final diameter = math.min(
          constraints.maxWidth * 0.85,
          constraints.maxHeight * 0.95,
        );
        final size = math.max(160.0, diameter);

        return AnimatedBuilder(
          animation: pulseController,
          builder: (_, _) {
            final glow = isRunning ? 0.4 + pulseController.value * 0.3 : 0.2;

            return SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _RingPainter(progress: progress, glowOpacity: glow),
                child: Center(child: child),
              ),
            );
          },
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.glowOpacity});

  final double progress;
  final double glowOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 8.0;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.cardBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      const startAngle = -math.pi / 2;
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..shader = const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth + 10
          ..strokeCap = StrokeCap.round
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * glowOpacity),
      );

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        Paint()
          ..shader = const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );

      final endX = center.dx + radius * math.cos(startAngle + sweepAngle);
      final endY = center.dy + radius * math.sin(startAngle + sweepAngle);
      canvas.drawCircle(
        Offset(endX, endY),
        strokeWidth / 1.5,
        Paint()..color = AppColors.primary,
      );
    }

    canvas.drawCircle(
      center,
      radius - strokeWidth - 4,
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.04 * glowOpacity * 3)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.glowOpacity != glowOpacity;
}
