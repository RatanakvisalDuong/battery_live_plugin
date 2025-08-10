import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_live_plugin_platform_interface.dart';

/// An implementation of [BatteryLivePluginPlatform] that uses method channels.
class MethodChannelBatteryLivePlugin extends BatteryLivePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_live_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
