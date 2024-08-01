/// Exception thrown when the device is offline.
class OfflineException implements Exception {
  /// The URL that the request was made to.
  final String url;

  /// Exception thrown when the device is offline.
  OfflineException(this.url);

  @override
  String toString() => 'Device is offline. Cannot make request to $url.';
}
