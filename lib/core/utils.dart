import 'package:flutter/material.dart';

// ─── Time Formatting ───────────────────────────────────────────────────────

/// Formats milliseconds into HH:MM:SS.cc (centiseconds)
String formatTime(int milliseconds) {
  final int centiseconds = (milliseconds ~/ 10) % 100;
  final int seconds = (milliseconds ~/ 1000) % 60;
  final int minutes = (milliseconds ~/ 60000) % 60;
  final int hours = milliseconds ~/ 3600000;

  if (hours > 0) {
    return '${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}.${_pad(centiseconds)}';
  }
  return '${_pad(minutes)}:${_pad(seconds)}.${_pad(centiseconds)}';
}

/// Formats milliseconds into a short MM:SS string for laps
String formatTimShort(int milliseconds) {
  final int seconds = (milliseconds ~/ 1000) % 60;
  final int minutes = (milliseconds ~/ 60000) % 60;
  return '${_pad(minutes)}:${_pad(seconds)}';
}

String _pad(int n) => n.toString().padLeft(2, '0');

// ─── Theme Helper ─────────────────────────────────────────────────────────

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
