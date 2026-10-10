/// Represents a single lap entry in the stopwatch.
class LapModel {
  final int lapNumber;
  final int lapTimeMs;    // time for this lap only
  final int totalTimeMs;  // cumulative elapsed time

  const LapModel({
    required this.lapNumber,
    required this.lapTimeMs,
    required this.totalTimeMs,
  });
}
