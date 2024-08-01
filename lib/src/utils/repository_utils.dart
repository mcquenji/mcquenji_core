// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

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
@Deprecated('Use `repoConfig` instead.')
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
BindConfig<R> repositoryConfig<T, R extends Repository<T>>() {
  return BindConfig<R>(
    notifier: (repo) => repo.stream,
    onDispose: (repo) => repo.dispose(),
  );
}

/// Utility extension on [Injector].
extension RepositoryInjectorExt on Injector {
  /// Registers a [Repository] with the [Injector].
  ///
  /// This is a shorthand for `addLazySingleton(MyRepo.new, config: repoConfig())`.
  void addRepository<T, R extends Repository<T>>(
    Function constructor, {
    BindConfig<R>? config,
  }) {
    addLazySingleton<R>(
      constructor,
      config: config ?? repositoryConfig<T, R>(),
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
