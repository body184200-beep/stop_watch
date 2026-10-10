import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../logic/stopwatch_logic.dart';
import '../widgets/animated_ring.dart';
import '../widgets/lap_list_section.dart';
import '../widgets/status_badge.dart';
import '../widgets/stopwatch_controls.dart';
import '../widgets/time_display.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen>
    with TickerProviderStateMixin {
  late final StopwatchLogic _logic;
  late final AnimationController _pulseController;
  late final AnimationController _ringController;

  @override
  void initState() {
    super.initState();
    _logic = StopwatchLogic();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
  }

  @override
  void dispose() {
    _logic.dispose();
    _pulseController.dispose();
    _ringController.dispose();
    super.dispose();
  }

  void _onStartPause() {
    if (_logic.isRunning) {
      _logic.pause();
      _ringController.stop();
    } else {
      _logic.start();
      _ringController.repeat();
    }
  }

  void _onLapReset() {
    if (_logic.isRunning) {
      _logic.lap();
    } else if (_logic.hasStarted) {
      _logic.reset();
      _ringController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _logic,
          builder: (context, _) {
            final progress = (_logic.elapsedMs % 60000) / 60000;
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                    child: Center(
                      child: AnimatedRing(
                        progress: progress,
                        isRunning: _logic.isRunning,
                        pulseController: _pulseController,
                        child: TimeDisplay(
                          elapsedMs: _logic.elapsedMs,
                          lapsCount: _logic.laps.length,
                          currentLapMs: _logic.currentLapMs,
                        ),
                      ),
                    ),
                  ),
                ),
                StopwatchControls(
                  isRunning: _logic.isRunning,
                  hasStarted: _logic.hasStarted,
                  onStartPause: _onStartPause,
                  onLapReset: _onLapReset,
                ),
                if (_logic.laps.isNotEmpty)
                  LapListSection(
                    laps: _logic.laps,
                    fastestLap: _logic.fastestLap,
                    slowestLap: _logic.slowestLap,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingMedium,
        vertical: AppDimens.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ShaderMask(
              shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
              child: const Text(
                'StopWatch',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(state: _logic.state),
        ],
      ),
    );
  }
}
