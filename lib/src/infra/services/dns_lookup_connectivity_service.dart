import 'dart:async';
import 'dart:io';

import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:rxdart/subjects.dart';

/// Implementation of [ConnectivityService] that uses DNS lookups to check connectivity.
///
/// Conneciivity is determined by checking if the DNS lookup of [lookupAddress] returns any results.
/// The connection status is re-evaluated at [ConnectivityService.updateInterval].
class DnsLookupConnectivityService extends ConnectivityService {
  late final Timer _updateLoop;
  late final BehaviorSubject<bool> _controller;

  /// The address to lookup to check connectivity.
  static const String lookupAddress = 'google.com';

  /// Implementation of [ConnectivityService] that uses DNS lookups to check connectivity.
  ///
  /// Conneciivity is determined by checking if the DNS lookup of [lookupAddress] returns any results.
  /// The connection status is re-evaluated at [ConnectivityService.updateInterval].
  DnsLookupConnectivityService() {
    _controller = BehaviorSubject();
    _updateLoop = Timer.periodic(ConnectivityService.updateInterval, _update);

    _init();
  }

  Future<bool> _checkConnection() async {
    final result = await InternetAddress.lookup(lookupAddress);

    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }

  Future<void> _init() async {
    _isConnected = await _checkConnection();
    _controller.add(_isConnected);

    log('initialized');
    log("The device is ${_isConnected ? "online" : "offline"}");
    log('Checking connectivity every ${ConnectivityService.updateInterval.inSeconds} seconds on $lookupAddress...');
  }

  Future<void> _update(Timer timer) async {
    final isConnected = await _checkConnection();

    if (isConnected == _isConnected) return;

    log('Connectivity changed: $isConnected');

    _isConnected = _isConnected;
    _controller.add(_isConnected);
  }

  bool _isConnected = true;

  @override
  bool get isConnected => _isConnected;

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  @override
  Future<void> dispose() async {
    _updateLoop.cancel();
    await _controller.close();
  }
}
