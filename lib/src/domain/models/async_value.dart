import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_value.freezed.dart';

/// Represents a value that is asynchronously loaded.
///
/// Inspired by the [AsyncValue](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue-class.html) class from the [riverpod](https://riverpod.dev/) package.
@freezed
class AsyncValue<T> with _$AsyncValue<T> {
  AsyncValue._();

  factory AsyncValue.__({
    required T? data,
    required bool isLoading,
    required Object? error,
    required StackTrace? stackTrace,
  }) = _AsyncValue;

  /// Creates an [AsyncValue] with the given value.
  factory AsyncValue.data(T data) => AsyncValue.__(
        data: data,
        isLoading: false,
        error: null,
        stackTrace: null,
      );

  // const AsyncValue(T data) = AsyncValue._(
  //       value: data,
  //       isLoading: false,
  //       error: null,
  //       stackTrace: null,
  //     );

  /// Creates an [AsyncValue] that is loading.
  factory AsyncValue.loading() => AsyncValue.__(
        data: null,
        isLoading: true,
        error: null,
        stackTrace: null,
      );

  /// Creates an [AsyncValue] with the given error.
  factory AsyncValue.error(Object error, [StackTrace? stackTrace]) =>
      AsyncValue.__(
        data: null,
        isLoading: false,
        error: error,
        stackTrace: stackTrace,
      );

  /// `true` if [data] can savely be accessed. `false` otherwise.
  bool get hasData => !isLoading && error == null;

  /// `true` if an error occurred. `false` otherwise.
  bool get hasError => error != null;

  /// Reuturns a result [R] based on the current state.
  ///
  /// - [data] is called if [hasData] is `true`.
  /// - [loading] is called if [isLoading] is `true`.
  /// - [error] is called if [hasError] is `true`.
  R when<R>({
    required R Function(T data) data,
    required R Function() loading,
    required R Function(Object error, StackTrace? stackTrace) error,
  }) {
    if (hasData) {
      return data(this.data as T);
    } else if (isLoading) {
      return loading();
    } else {
      return error(this.error!, stackTrace);
    }
  }

  /// A utility method to handle asynchronous operations safely, capturing any
  /// errors that might occur during the execution of the provided [future].
  ///
  /// If the given [future] fails an [AsyncValue.error] will be returned. [AsyncValue.data] otherwhise.
  static Future<AsyncValue<T>> guard<T>(FutureOr<T> Function() future) async {
    try {
      final result = await future();

      return AsyncValue.data(result);
    } catch (e, stackTrace) {
      return AsyncValue.error(e, stackTrace);
    }
  }
}
