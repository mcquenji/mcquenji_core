// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'async_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AsyncValue<T> {
  T? get data => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AsyncValueCopyWith<T, AsyncValue<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AsyncValueCopyWith<T, $Res> {
  factory $AsyncValueCopyWith(
          AsyncValue<T> value, $Res Function(AsyncValue<T>) then) =
      _$AsyncValueCopyWithImpl<T, $Res, AsyncValue<T>>;
  @useResult
  $Res call({T? data, bool isLoading, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class _$AsyncValueCopyWithImpl<T, $Res, $Val extends AsyncValue<T>>
    implements $AsyncValueCopyWith<T, $Res> {
  _$AsyncValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AsyncValueImplCopyWith<T, $Res>
    implements $AsyncValueCopyWith<T, $Res> {
  factory _$$AsyncValueImplCopyWith(
          _$AsyncValueImpl<T> value, $Res Function(_$AsyncValueImpl<T>) then) =
      __$$AsyncValueImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T? data, bool isLoading, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$AsyncValueImplCopyWithImpl<T, $Res>
    extends _$AsyncValueCopyWithImpl<T, $Res, _$AsyncValueImpl<T>>
    implements _$$AsyncValueImplCopyWith<T, $Res> {
  __$$AsyncValueImplCopyWithImpl(
      _$AsyncValueImpl<T> _value, $Res Function(_$AsyncValueImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$AsyncValueImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$AsyncValueImpl<T> extends _AsyncValue<T> {
  _$AsyncValueImpl(
      {required this.data,
      required this.isLoading,
      required this.error,
      required this.stackTrace})
      : super._();

  @override
  final T? data;
  @override
  final bool isLoading;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'AsyncValue<$T>.__(data: $data, isLoading: $isLoading, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AsyncValueImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      isLoading,
      const DeepCollectionEquality().hash(error),
      stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AsyncValueImplCopyWith<T, _$AsyncValueImpl<T>> get copyWith =>
      __$$AsyncValueImplCopyWithImpl<T, _$AsyncValueImpl<T>>(this, _$identity);
}

abstract class _AsyncValue<T> extends AsyncValue<T> {
  factory _AsyncValue(
      {required final T? data,
      required final bool isLoading,
      required final Object? error,
      required final StackTrace? stackTrace}) = _$AsyncValueImpl<T>;
  _AsyncValue._() : super._();

  @override
  T? get data;
  @override
  bool get isLoading;
  @override
  Object? get error;
  @override
  StackTrace? get stackTrace;
  @override
  @JsonKey(ignore: true)
  _$$AsyncValueImplCopyWith<T, _$AsyncValueImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
