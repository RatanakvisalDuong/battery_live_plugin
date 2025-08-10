import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'battery_live_plugin_method_channel.dart';

abstract class BatteryLivePluginPlatform extends PlatformInterface {
  /// Constructs a BatteryLivePluginPlatform.
  BatteryLivePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryLivePluginPlatform _instance = MethodChannelBatteryLivePlugin();

  /// The default instance of [BatteryLivePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelBatteryLivePlugin].
  static BatteryLivePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatteryLivePluginPlatform] when
  /// they register themselves.
  static set instance(BatteryLivePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
