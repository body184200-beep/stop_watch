/// Represents a single alarm entry.
class AlarmModel {
  final int id;
  final int hour;
  final int minute;
  final String label;
  bool isEnabled;
  final List<bool> repeatDays; // Mon-Sun (7 elements)

  AlarmModel({
    required this.id,
    required this.hour,
    required this.minute,
    this.label = 'Alarm',
    this.isEnabled = true,
    List<bool>? repeatDays,
  }) : repeatDays = repeatDays ?? List.filled(7, false);

  String get formattedTime {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get period => hour < 12 ? 'AM' : 'PM';

  String get repeatLabel {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final active = [
      for (int i = 0; i < 7; i++)
        if (repeatDays[i]) days[i],
    ];
    if (active.isEmpty) return 'Once';
    if (active.length == 7) return 'Every day';
    if (active.length == 5 &&
        repeatDays[0] &&
        repeatDays[1] &&
        repeatDays[2] &&
        repeatDays[3] &&
        repeatDays[4]) {
      return 'Weekdays';
    }
    return active.join(', ');
  }

  AlarmModel copyWith({bool? isEnabled}) {
    return AlarmModel(
      id: id,
      hour: hour,
      minute: minute,
      label: label,
      isEnabled: isEnabled ?? this.isEnabled,
      repeatDays: repeatDays,
    );
  }
}
