import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// This function is to be used when binding a [Cubit] to a [Module].
///
/// ```dart
/// class AppModule extends Module {
///   @override
///   void binds(i){
///     i.addLazySingleton(MyCubit.new, config: cubitConfig());
///   }
/// }
/// ```
@Deprecated("Use `repoConfig` instead.")
BindConfig<T> cubitConfig<T extends Cubit>() {
  return BindConfig(
    notifier: (cubit) {},
    onDispose: (cubit) => cubit.close(),
  );
}

/// This function is to be used when binding a [Repository] to a [Module].
/// Use [RepositoryInjectorExt.addRepository] instead of manually calling this function.
///
/// ```dart
/// class AppModule extends Module {
///   @override
///   void binds(i){
///     i.addLazySingleton(MyCubit.new, config: cubitConfig());
///   }
/// }
/// ```
BindConfig<T> repositoryConfig<T extends Repository>() {
  return BindConfig(
    notifier: (cubit) {},
    onDispose: (cubit) => cubit.close(),
  );
}

/// Utility extension on [Repository].
extension RepositoryStreamExt<State> on Repository<State> {
  /// Listens to changes emitted by the [Repository].
  ///
  /// The current [State] will be emitted immediately after subscribing and subsequent changes will be forwareded.
  StreamSubscription<State> listen(
    void Function(State)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    onData?.call(state);

    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

/// Utility extension on [Injector].
extension RepositoryInjectorExt on Injector {
  /// Registers a [Repository] with the [Injector].
  ///
  /// This is a shorthand for `addLazySingleton(create, config: repoConfig())`.
  void addRepository<T extends Repository>(
    T Function() constructor, {
    BindConfig<T>? config,
  }) {
    addLazySingleton(constructor, config: config ?? repositoryConfig());
  }
}
