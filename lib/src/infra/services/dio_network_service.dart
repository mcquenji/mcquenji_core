import 'package:dio/dio.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Implementation of [NetworkService] using [Dio].
class DioNetworkService extends NetworkService {
  /// The [Dio] instance to use for network requests.
  final Dio dio;

  /// Implementation of [NetworkService] using [Dio].
  DioNetworkService(this.dio);

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    _logRequest('DELETE', url, null, headers, queryParameters);

    final response = await dio
        .delete(
          url,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .timeout(NetworkService.timeout);

    _logResponse(response);

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.data,
      headers: response.headers.map,
      requestUri: response.requestOptions.uri,
    );
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    _logRequest('GET', url, null, headers, queryParameters);

    final response = await dio
        .get(
          url,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .timeout(NetworkService.timeout);

    _logResponse(response);

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.data,
      headers: response.headers.map,
      requestUri: response.requestOptions.uri,
    );
  }

  @override
  Future<HttpResponse> patch(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    _logRequest('PATCH', url, body, headers, queryParameters);

    final response = await dio
        .patch(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .timeout(NetworkService.timeout);

    _logResponse(response);

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.data,
      headers: response.headers.map,
      requestUri: response.requestOptions.uri,
    );
  }

  @override
  Future<HttpResponse> post(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    _logRequest('POST', url, body, headers, queryParameters);

    final response = await dio
        .post(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .timeout(NetworkService.timeout);

    _logResponse(response);

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.data,
      headers: response.headers.map,
      requestUri: response.requestOptions.uri,
    );
  }

  @override
  Future<HttpResponse> put(
    String url,
    Object body, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    _logRequest('PUT', url, body, headers, queryParameters);

    final response = await dio
        .put(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .timeout(NetworkService.timeout);

    _logResponse(response);

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.data,
      headers: response.headers.map,
      requestUri: response.requestOptions.uri,
    );
  }

  void _logResponse(Response response) {
    log('''
${response.requestOptions.method} request received response
Response: ${response.data}
Status code: ${response.statusCode}
Headers: ${response.headers.map}
Request URI: ${response.requestOptions.uri}
    ''');
  }

  void _logRequest(
    String method,
    String url,
    Object? body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  ) {
    log('Sending $method request to $url with body: $body, headers: $headers, queryParameters: $queryParameters');
  }

  @override
  void dispose() {
    dio.close();
  }

  @override
  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
