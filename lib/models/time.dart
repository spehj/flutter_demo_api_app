// Time class
class Time {
  final int id;
  final int duration;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool running;

  Time({
    required this.id,
    required this.duration,
    this.startTime,
    this.endTime,
    required this.running,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    /// Factory constructor to create Time object from JSON
    return Time(
        id: json['id'], duration: json['duration'], running: json['running']);
  }
}
