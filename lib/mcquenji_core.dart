/// # McQuenji's Core Module
///
/// This is the core module for all my flutter projects. It contains all the basic functionalities that I use in all my projects. It is a work in progress and I will keep updating it as I go along.
///
/// ## Usage
///
/// To use this module in your project, add the following to your `pubspec.yaml` file:
///
/// ```yaml
/// dependencies:
///   mcquenji_core:
///     git:
///       url: https://github.com/mcquenji/mcquenji_core.git
/// ```
///
/// Then run `flutter pub get` to install the package.
///
/// After that, import the module in your app's main module this:
///
/// ```dart
/// import 'package:mcquenji_core/mcquenji_core.dart';
///
/// class AppModule extends Module {
///     @override
///     List<Module> get imports => [CoreModule()];
/// }
/// ```
///
/// Now you can use all services and utilities provided by the module in your app.
///
/// ```dart
/// final networkService = Modular.get<NetworkService>();
///
/// networkService.get('https://api.example.com').then((response) {
///     print(response.body);
/// });
/// ```
///
/// ## Logging
///
/// All enteties (i.e. services, datasources, repositories) have a logger that can be used to log messages. The logger is a `Logger` instance from the `logging` package. The logger is named after the entity's runtime type.
///
/// To process the logs you can either use the `LogHandlerService` or create your own log handler.
///
/// ```dart
/// void main() {
///    // Call this AFTER modular is initialized
///    final handler = Modular.get<LogHandlerService>();
///    Logger.root.onRecord.listen(handler);
/// }
///
/// ## Services
///
/// Services are classes that complete the most low-level tasks in the app. They are the only classes that can interact with the outside world. All other classes should depend on services to get their work done.
///
/// ### Defining a new service
///
/// To define a new service, create a new abstract class that extends the `Service` class.
///
/// ```dart
/// abstract class MyService extends Service {
///     @override
///     String get name => 'MyService';
///
///     // Your service implementation here
/// }
/// ```
///
/// After that, create a new class that extends the abstract class and implements the required methods.
///
/// ```dart
/// class MyServiceImpl extends MyService {
///     @override
///     Future<void> init() async {
///         // Initialize your service here
///     }
///
///     // Implement other methods here
/// }
/// ```
///
/// Finally, register the service in the module the service is used in. If the service is also used in other modules, export it.
///
/// ```dart
/// class MyModule extends Module {
///     @override
///     List<Module> get imports => [McQuenjiCore()];
///
///     @override
///     void binds(i){
///         i.add<MyService>(MyServiceImpl.new);
///     }
///
///     @override
///     exportBinds(i) {
///         i.add<MyService>(MyServiceImpl.new);
///     }
/// }
/// ```
///
/// ## Datasources
///
/// Datasources are classes that interact with the data layer of the app. They are responsible for fetching and storing data from and to the data layer.
///
/// ### Defining a new datasource
///
/// To define a new datasource, create a new abstract class that extends the `Datasource` class.
///
/// ```dart
/// abstract class MyDatasource extends Datasource {
///     @override
///     String get name => 'MyDatasource';
///
///     MyDatasource(MyService service);
///
///     // Your datasource implementation here
/// }
/// ```
///
/// After that, the steps are the same as defining a new service.
///
/// ## Repositories
///
/// Repositories are classes that provide tailored methods for a specific UI screen or feature. They are also responsible for state management and as extend `Cubit`.
///
/// ### Defining a new repository
///
/// To define a new repository, create a new class that extends the `Repository` class.
///
/// ```dart
/// class MyRepository<MyState> extends Repository<MyState> {
///     MyRepository(MyService service, MyDatasource datasource) : super(myIntialState);
///
///     // Your repository implementation here
/// }
/// ```
library mcquenji_core;

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

  /// Whether the application is running in debug mode.
  ///
  /// It is recommended to set this value in the main method of your application to enable or disable debug mode.
  ///
  /// ```dart
  /// void main() {
  ///   CoreModule.debugMode = kDebugMode;
  ///   runApp(ModularApp(module: AppModule()));
  /// }
  static bool debugMode = false;

  /// Callback function that is called when the [Dio] instance is initialized.
  /// You can use this function to configure the [Dio] instance before it is used.
  ///
  /// For example, you can add sentry tracing to the [Dio] instance if you are using sentry.
  ///
  /// By default, this function sets the [BaseOptions.validateStatus] to `(_) => true`.
  static void Function(Dio dio) onInitDio = (dio) {
    dio.options.validateStatus = (_) => true;
  };

  @override
  void exportedBinds(Injector i) {
    i
      // modular has a bug where the type of parameters in brackets is
      // not inferred correctly. In this instance, the type of `BaseOptions` is
      // inferred as `[BaseOptions]` which is incorrect. So we have to use the
      // the lambda to force the correct type.
      // ignore: unnecessary_lambdas
      ..add<Dio>(() {
        final dio = Dio();
        onInitDio(dio);

        return dio;
      })
      ..addLazySingleton<ConnectivityService>(
        isWeb ? WebConnectivitiyService.new : DnsLookupConnectivityService.new,
      )
      ..addLazySingleton<LogHandlerService>(
        debugMode ? DebugLogHandlerService.new : ReleaseLogHandlerService.new,
      )
      ..add<NetworkService>((ConnectivityService conn, Dio dio) {
        if (!conn.isConnected) return OfflineNetworkService();

        return DioNetworkService(dio);
      });
  }
}

/// Type alias for a JSON object.
typedef JSON = Map<String, dynamic>;
