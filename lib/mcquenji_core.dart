import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_core/src/infra/infra.dart';

export 'src/domain/domain.dart';
export 'src/presentation/presentation.dart';
export 'src/utils/utils.dart';

/// Core module of all McQuenji projects.
///
/// Provides basic services and utilities for all projects, such as [NetworkService] and [ConnectivityService].
///
/// This module is intended to be imported in the main module of the project.
///
/// ```dart
/// class AppModule extends Module {
///  @override
///  List<Module> get imports => [CoreModule()];
/// }
/// ````
class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..add<BaseOptions>(BaseOptions.new)
      ..add<Dio>(Dio.new)
      ..addLazySingleton<ConnectivityService>(
        kIsWeb ? WebConnectivitiyService.new : DnsLookupConnectivityService.new,
      )
      ..add<NetworkService>((ConnectivityService conn, Dio dio) {
        if (!conn.isConnected) return OfflineNetworkService();

        return DioNetworkService(dio);
      });
  }
}

/// Type alias for a JSON object.
typedef JSON = Map<String, dynamic>;
