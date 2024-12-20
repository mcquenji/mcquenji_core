import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_core/src/infra/infra.dart';
import 'package:rxdart/subjects.dart';

/// Implementation of [ConnectivityService] that pings a server to check connectivity.
///
/// This implementation should only be used on web platforms. Use [DnsLookupConnectivityService] for other platforms.
class WebConnectivitiyService extends ConnectivityService {
  late final Timer _updateLoop;
  late final BehaviorSubject<bool> _controller;

  final Dio _dio;

  /// The address to lookup to check connectivity.
  static const String pingAddress = '/';

  /// Implementation of [ConnectivityService] that uses DNS lookups to check connectivity.
  ///
  /// Conneciivity is determined by checking if the DNS lookup of [pingAddress] returns any results.
  /// The connection status is re-evaluated at [updateInterval].
  WebConnectivitiyService(this._dio) {
    _controller = BehaviorSubject();
    _updateLoop = Timer.periodic(ConnectivityService.updateInterval, _update);

    _init();
  }

  Future<bool> _checkConnection() async {
    try {
      final response = await _dio.get(pingAddress);

      if (response.statusCode == null) return false;

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      return false;
    }
  }

  Future<void> _init() async {
    _isConnected = await _checkConnection();
    _controller.add(_isConnected);

    log('initialized');
    log("The device is ${_isConnected ? "online" : "offline"}");
    log('Checking connectivity every ${ConnectivityService.updateInterval.inSeconds} seconds on $pingAddress...');
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
    super.dispose();
    _updateLoop.cancel();
    await _controller.close();
  }
}
