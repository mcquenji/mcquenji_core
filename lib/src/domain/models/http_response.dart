import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

part 'http_response.freezed.dart';

/// A response received from an HTTP request made by a [NetworkService].
@freezed
class HttpResponse<T> with _$HttpResponse<T> {
  const HttpResponse._();

  /// A response received from an HTTP request.
  factory HttpResponse({
    /// The status code of the response.
    int? statusCode,

    /// The parsed body of the response.
    T? body,

    /// The headers of the response.
    required Map<String, List<String>> headers,

    /// The request URI of the response.
    required Uri requestUri,
  }) = _HttpResponse;

  /// `true` if the status code indicates success.
  bool get isOk =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;

  /// `true` if the status code indicates failure.
  bool get isNotOk => !isOk;

  /// Raises an [HttpException] if the status code [isNotOk].
  void raiseForStatusCode() {
    if (isNotOk) {
      throw HttpException(
        'Request failed with status code $statusCode',
        uri: requestUri,
      );
    }
  }

  /// Transforms the body of the response to the type [U].
  HttpResponse<U> transform<U>(U Function(T) transform) {
    return HttpResponse(
      statusCode: statusCode,
      body: body != null ? transform(body as T) : null,
      headers: headers,
      requestUri: requestUri,
    );
  }
}
