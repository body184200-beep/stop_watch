import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/lap_models.dart';

/// Enum representing the current state of the stopwatch.
enum StopwatchState { idle, running, paused }

/// Business logic for the stopwatch feature.
///
/// Uses [ChangeNotifier] so the UI can react to state changes.
class StopwatchLogic extends ChangeNotifier {
  // ── Private fields ────────────────────────────────────────────────────
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;

  int _lastLapMs = 0;
  StopwatchState _state = StopwatchState.idle;
  final List<LapModel> _laps = [];

  // ── Public getters ────────────────────────────────────────────────────

  /// Elapsed time in milliseconds.
  int get elapsedMs => _stopwatch.elapsedMilliseconds;

  /// Duration of the current (incomplete) lap in ms.
  int get currentLapMs => elapsedMs - _lastLapMs;

  /// Current state of the stopwatch.
  StopwatchState get state => _state;

  /// Whether the stopwatch is actively counting.
  bool get isRunning => _state == StopwatchState.running;

  /// Whether the stopwatch has been started at least once.
  bool get hasStarted => _state != StopwatchState.idle;

  /// Immutable list of recorded laps (newest first for display).
  List<LapModel> get laps => List.unmodifiable(_laps.reversed.toList());

  /// Fastest lap (null when fewer than 2 laps).
  LapModel? get fastestLap => _laps.length >= 2
      ? _laps.reduce((a, b) => a.lapTimeMs < b.lapTimeMs ? a : b)
      : null;

  /// Slowest lap (null when fewer than 2 laps).
  LapModel? get slowestLap => _laps.length >= 2
      ? _laps.reduce((a, b) => a.lapTimeMs > b.lapTimeMs ? a : b)
      : null;

  // ── Public actions ────────────────────────────────────────────────────

  /// Starts or resumes the stopwatch.
  void start() {
    if (_state == StopwatchState.running) return;

    _stopwatch.start();
    _state = StopwatchState.running;

    _ticker = Timer.periodic(const Duration(milliseconds: 30), (_) {
      notifyListeners();
    });

    notifyListeners();
  }

  /// Pauses the stopwatch without resetting.
  void pause() {
    if (_state != StopwatchState.running) return;

    _stopwatch.stop();
    _ticker?.cancel();
    _state = StopwatchState.paused;

    notifyListeners();
  }

  /// Records the current lap time and starts a new lap.
  void lap() {
    if (!isRunning) return;

    final lapTime = currentLapMs;
    _laps.add(
      LapModel(
        lapNumber: _laps.length + 1,
        lapTimeMs: lapTime,
        totalTimeMs: elapsedMs,
      ),
    );
    _lastLapMs = elapsedMs;

    notifyListeners();
  }

  /// Resets the stopwatch and clears all laps.
  void reset() {
    _stopwatch
      ..stop()
      ..reset();

    _ticker?.cancel();
    _ticker = null;

    _state = StopwatchState.idle;
    _lastLapMs = 0;
    _laps.clear();

    notifyListeners();
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
