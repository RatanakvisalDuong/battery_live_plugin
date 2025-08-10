
import 'package:flutter/services.dart';

import 'battery_live_plugin_platform_interface.dart';

class BatteryLivePlugin {
  static const EventChannel eventChannel = EventChannel('battery_live_plugin');

  Future<String?> getPlatformVersion() {
    return BatteryLivePluginPlatform.instance.getPlatformVersion();
  }

  static Stream<BatteryInfo> getBatteryInfo(){
    return eventChannel.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return BatteryInfo(
        level: map['level'] ?? 0,
        isCharging: map['isCharging'] ?? false,
      );
    });
  }

}

class BatteryInfo {
  final int level;
  final bool isCharging;

  BatteryInfo({required this.level, required this.isCharging});

  @override
  String toString(){
    return "Battery Info: ${level}%, Charging: ${isCharging ? "Yes" : "No"}";
  }
}