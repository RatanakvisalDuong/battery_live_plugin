import Flutter
import UIKit

public class BatteryLivePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterEventChannel(name: "battery_live_plugin", binaryMessenger: registrar.messenger())
    let instance = BatteryLivePlugin()
    channel.setStreamHandler(instance)
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    UIDevice.current.isBatteryMonitoringEnabled = true
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(batteryLevelChanged),
      name: UIDevice.batteryLevelDidChangeNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(batteryStateChanged),
      name: UIDevice.batteryStateDidChangeNotification,
      object: nil
    )
    sendBatteryInfo()
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self)
    UIDevice.current.isBatteryMonitoringEnabled = false
    eventSink = nil
    return nil
  }

  @objc private func batteryLevelChanged() { sendBatteryInfo() }
  @objc private func batteryStateChanged() { sendBatteryInfo() }

  private func sendBatteryInfo() {
    guard let sink = eventSink else { return }
    let level = Int(UIDevice.current.batteryLevel * 100)
    let isCharging = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    sink(["level": level, "isCharging": isCharging])
  }
}
