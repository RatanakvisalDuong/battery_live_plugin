import 'package:flutter_test/flutter_test.dart';
import 'package:battery_live_plugin/battery_live_plugin.dart';
import 'package:battery_live_plugin/battery_live_plugin_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatteryLivePluginPlatform
    with MockPlatformInterfaceMixin
    implements BatteryLivePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  test('getBatteryInfo', () async {
    expect(BatteryLivePlugin.getBatteryInfo(), isA<Stream<BatteryInfo>>());
  });
}
