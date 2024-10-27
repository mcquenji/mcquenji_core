import 'package:dio/dio.dart';
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
/// ```
///
/// **IMPORTANT:** If you are using this module in a web project, make sure to set [CoreModule.isWeb] to `true` in the main method of your application.
/// {@macro is_web_example}
class CoreModule extends Module {
  /// Whether the current platform is web.
  ///
  /// It is recommended to set this value in the main method of your application.
  ///
  /// {@template is_web_example}
  ///
  /// ```dart
  /// void main() {
  ///   CoreModule.isWeb = kIsWeb;
  ///   runApp(ModularApp(module: AppModule()));
  /// }
  /// ```
  /// {@endtemplate}
  ///
  /// If you are writing server-side code, you can ignore this step.
  static bool isWeb = false;

  @override
  void exportedBinds(Injector i) {
    i
      ..add<BaseOptions>(() => BaseOptions(validateStatus: (_) => true))
      // modular has a bug where the type of parameters in brackets is
      // not inferred correctly. In this instance, the type of `BaseOptions` is
      // inferred as `[BaseOptions]` which is incorrect. So we have to use the
      // the lambda to force the correct type.
      // ignore: unnecessary_lambdas
      ..add<Dio>((BaseOptions o) => Dio(o))
      ..addLazySingleton<ConnectivityService>(
        isWeb ? WebConnectivitiyService.new : DnsLookupConnectivityService.new,
      )
      ..add<NetworkService>((ConnectivityService conn, Dio dio) {
        if (!conn.isConnected) return OfflineNetworkService();

        return DioNetworkService(dio);
      });
  }
}

/// Type alias for a JSON object.
typedef JSON = Map<String, dynamic>;
