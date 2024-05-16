export 'src/domain/domain.dart';
export 'src/presentation/presentation.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
///  List<Module> get imports => [CoreModule()];
/// }
/// ````
class CoreModule extends Module {
  @override
  void exportedBinds(i) {
    i.add(() => Dio());

    i.addLazySingleton<ConnectivityService>(
      kIsWeb ? WebConnectivitiyService.new : DnsLookupConnectivityService.new,
    );

    i.add<NetworkService>(() {
      final connecteivityService = i.get<ConnectivityService>();

      if (!connecteivityService.isConnected) return OfflineNetworkService();

      return DioNetworkService(i.get<Dio>());
    });
  }
}

/// This function is to be used when binding a [Cubit] to a [Module].
///
/// ```dart
/// class AppModule extends Module {
///   @override
///   void binds(i){
///     i.bindLazySingleton(MyCubit.new, config: cubitConfig());
///   }
/// }
/// ```
BindConfig<T> cubitConfig<T extends Cubit>() {
  return BindConfig(
    notifier: (cubit) => cubit.stream,
    onDispose: (cubit) => cubit.close(),
  );
}
