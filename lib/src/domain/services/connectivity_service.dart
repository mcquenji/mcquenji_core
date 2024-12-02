import 'package:mcquenji_core/mcquenji_core.dart';

/// Service for checking the connectivity of the device.
///
/// You can set [updateInterval] in your main method to change the interval at which connectivity is checked.
abstract class ConnectivityService extends Service {
  @override
  String get name => 'Connectivity';

  /// Emits the connectivity status of the device.
  ///
  /// The emitted value is `true` if the device has (re)established a connectetion to the internet, `false` otherwise.
  Stream<bool> get onConnectivityChanged;

  /// `true` if the device is connected to the internet, `false` otherwise.
  ///
  /// This is always the last value emitted by [onConnectivityChanged].
  bool get isConnected;

  /// The interval at which to check connectivity.
  static Duration updateInterval = const Duration(seconds: 1);
}
