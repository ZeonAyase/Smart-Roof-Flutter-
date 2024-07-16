import 'package:flutter/foundation.dart';

@immutable
class Sensor {
  const Sensor({
    required this.ldr,
    required this.rain,
  });

  Sensor.fromJson(Map<String, Object?> json)
      : this(
    ldr: json['LDR']! as num,
    rain: json['Rain']! as num,
  );

  final num ldr;
  final num rain;

  Map<String, Object?> toJson() {
    return {
      'LDR': ldr,
      'Rain': rain,
    };
  }
}