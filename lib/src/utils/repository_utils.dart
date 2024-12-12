// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:modular_core/modular_core.dart';

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
@Deprecated('Use `repositoryConfig` instead.')
BindConfig<T> cubitConfig<T extends Cubit>() {
  return BindConfig(
    notifier: (cubit) => cubit.stream,
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
///     i.addLazySingleton<MyRepo>(MyRepo.new, config: cubitConfig());
///   }
/// }
/// ```
BindConfig<R> repositoryConfig<R extends Repository>() {
  return BindConfig<R>(
    notifier: (repo) => repo.stream,
    onDispose: (repo) => repo.dispose(),
  );
}

/// Utility extension on [Injector].
extension RepositoryInjectorExt on Injector {
  /// Registers a [Repository] with the [Injector].
  ///
  /// This is a shorthand for `addLazySingleton<MyRepo>(MyRepo.new, config: repoConfig())`.
  void addRepository<R extends Repository>(
    Function constructor, {
    BindConfig<R>? config,
  }) {
    addLazySingleton<R>(
      constructor,
      config: config ?? repositoryConfig<R>(),
    );
  }

  /// Registers a [TickRepository] with the given [interval].
  @Deprecated('Use Repository.updateInterval instead')
  void addTickRepository(
    TickInterval interval, {
    bool paused = false,
  }) {
    addRepository<TickRepository>(
      () => TickRepository(interval, paused: paused),
    );
  }
}

/// Utility extension on repositories with an asynchronous state.
extension AsyncRepoExt<State> on Repository<AsyncValue<State>> {
  /// Emits [AsyncValue.error] with the given [error] and [stackTrace].
  void error(Object error, [StackTrace? stackTrace]) {
    emit(AsyncValue.error(error, stackTrace));
  }

  /// Emits [AsyncValue.loading].
  void loading() {
    emit(AsyncValue.loading());
  }

  /// Emits [AsyncValue.data] with the given [data].
  void data(State data) {
    emit(AsyncValue.data(data));
  }

  /// Guards the given [future] and emits the result.
  ///
  /// See [AsyncValue.guard] for more information.
  Future<void> guard(
    Future<State> Function() future, {
    void Function(State)? onData,
    void Function(Object, StackTrace?)? onError,
  }) async {
    emit(
      await AsyncValue.guard(
        future,
        onData: onData,
        onError: onError,
      ),
    );
  }
}
