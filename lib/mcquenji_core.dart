export 'src/domain/domain.dart';
export 'src/presentation/presentation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_core/src/impl/impl.dart';

/// Core module of all McQuenji projects.
///
/// Provides basic services and utilities for all projects, such as [NetworkService] and [ConnectivityService].
///
/// This module is intended to be imported in the main module of the project.
///
/// ```dart
/// class AppModule extends Module {
///  @override
///  List<Module> get imports => [McQuenjiCore()];
/// }
/// ````
class McQuenjiCore extends Module {
  @override
  void exportedBinds(i) {
    i.add(Dio.new);

    i.addLazySingleton<ConnectivityService>(
      () => DnsLookupConnectivityService(),
    );

    i.add<NetworkService>(() {
      final connecteivityService = i.get<ConnectivityService>();

      if (!connecteivityService.isConnected) return OfflineNetworkService();

      return DioNetworkService(i.get<Dio>());
    });
  }
}
