import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_core/src/infra/infra.dart';
import 'package:modular_core/modular_core.dart';

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
      // modular has a bug where the type of parameters in brackets is
      // not inferred correctly. In this instance, the type of `BaseOptions` is
      // inferred as `[BaseOptions]` which is incorrect. So we have to use the
      // the lambda to force the correct type.
      // ignore: unnecessary_lambdas
      ..add<Dio>((BaseOptions o) => Dio(o))
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
