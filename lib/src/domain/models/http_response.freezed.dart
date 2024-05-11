// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HttpResponse<T> {
  /// The status code of the response.
  int? get statusCode => throw _privateConstructorUsedError;

  /// The parsed body of the response.
  T? get body => throw _privateConstructorUsedError;

  /// The headers of the response.
  Map<String, List<String>> get headers => throw _privateConstructorUsedError;

  /// The request URI of the response.
  Uri get requestUri => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HttpResponseCopyWith<T, HttpResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpResponseCopyWith<T, $Res> {
  factory $HttpResponseCopyWith(
          HttpResponse<T> value, $Res Function(HttpResponse<T>) then) =
      _$HttpResponseCopyWithImpl<T, $Res, HttpResponse<T>>;
  @useResult
  $Res call(
      {int? statusCode,
      T? body,
      Map<String, List<String>> headers,
      Uri requestUri});
}

/// @nodoc
class _$HttpResponseCopyWithImpl<T, $Res, $Val extends HttpResponse<T>>
    implements $HttpResponseCopyWith<T, $Res> {
  _$HttpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = freezed,
    Object? body = freezed,
    Object? headers = null,
    Object? requestUri = null,
  }) {
    return _then(_value.copyWith(
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as T?,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      requestUri: null == requestUri
          ? _value.requestUri
          : requestUri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HttpResponseImplCopyWith<T, $Res>
    implements $HttpResponseCopyWith<T, $Res> {
  factory _$$HttpResponseImplCopyWith(_$HttpResponseImpl<T> value,
          $Res Function(_$HttpResponseImpl<T>) then) =
      __$$HttpResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {int? statusCode,
      T? body,
      Map<String, List<String>> headers,
      Uri requestUri});
}

/// @nodoc
class __$$HttpResponseImplCopyWithImpl<T, $Res>
    extends _$HttpResponseCopyWithImpl<T, $Res, _$HttpResponseImpl<T>>
    implements _$$HttpResponseImplCopyWith<T, $Res> {
  __$$HttpResponseImplCopyWithImpl(
      _$HttpResponseImpl<T> _value, $Res Function(_$HttpResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = freezed,
    Object? body = freezed,
    Object? headers = null,
    Object? requestUri = null,
  }) {
    return _then(_$HttpResponseImpl<T>(
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as T?,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      requestUri: null == requestUri
          ? _value.requestUri
          : requestUri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$HttpResponseImpl<T> extends _HttpResponse<T> {
  _$HttpResponseImpl(
      {this.statusCode,
      this.body,
      required final Map<String, List<String>> headers,
      required this.requestUri})
      : _headers = headers,
        super._();

  /// The status code of the response.
  @override
  final int? statusCode;

  /// The parsed body of the response.
  @override
  final T? body;

  /// The headers of the response.
  final Map<String, List<String>> _headers;

  /// The headers of the response.
  @override
  Map<String, List<String>> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  /// The request URI of the response.
  @override
  final Uri requestUri;

  @override
  String toString() {
    return 'HttpResponse<$T>(statusCode: $statusCode, body: $body, headers: $headers, requestUri: $requestUri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpResponseImpl<T> &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.requestUri, requestUri) ||
                other.requestUri == requestUri));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      statusCode,
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(_headers),
      requestUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpResponseImplCopyWith<T, _$HttpResponseImpl<T>> get copyWith =>
      __$$HttpResponseImplCopyWithImpl<T, _$HttpResponseImpl<T>>(
          this, _$identity);
}

abstract class _HttpResponse<T> extends HttpResponse<T> {
  factory _HttpResponse(
      {final int? statusCode,
      final T? body,
      required final Map<String, List<String>> headers,
      required final Uri requestUri}) = _$HttpResponseImpl<T>;
  _HttpResponse._() : super._();

  @override

  /// The status code of the response.
  int? get statusCode;
  @override

  /// The parsed body of the response.
  T? get body;
  @override

  /// The headers of the response.
  Map<String, List<String>> get headers;
  @override

  /// The request URI of the response.
  Uri get requestUri;
  @override
  @JsonKey(ignore: true)
  _$$HttpResponseImplCopyWith<T, _$HttpResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
