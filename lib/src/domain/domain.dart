import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

export 'datasources/datasources.dart';
export 'models/models.dart';
export 'services/services.dart';

/// {@template loggable}
/// A class that provides logging functionality.
///
/// Each class that extends this class should have a unique [namespace].
/// {@endtemplate}
abstract class ILoggable {
  /// {@macro loggable}
  const ILoggable();

  /// The namespace to log messages under.
  /// e.g. 'Service.Auth'
  ///
  /// Note: The runtime type of the class is automatically appended to the namespace.
  String get namespace;

  /// The level to log messages at.
  Level get level;

  /// The level to log error messages at.
  ///
  /// Defaults to [Level.SEVERE].
  Level get errorLevel => Level.SEVERE;

  /// Logs a message with an optional error and stack trace.
  ///
  /// If [error] is provided, the message is logged at [errorLevel].
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger('$namespace.$runtimeType').log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }
}

/// Debug log handler that prints log messages to the console.
///
/// To use this see [Logger.onRecord].
///
/// ```dart
/// Logger.root.onRecord.listen(debugLogHandler);
/// ```
void debugLogHandler(LogRecord r) {
  // print is only called when configured as a log handler
  // ignore: avoid_print
  print(r.formatColored());
}

/// {@template generic_serializer}
/// A versatile serializer interface for converting objects between different formats.
///
/// Primarily used in [Datasource]s to transform objects from one representation to another,
/// such as converting Dart objects to JSON and vice versa.
///
/// - [Deserialized]: The original type of the object before serialization (e.g., a Dart object).
/// - [Serialized]: The transformed type of the object after serialization (e.g., a JSON object).
///
/// Additionally, this interface implements [JsonConverter] so you can use it as a converter when working with freezed models.
///
///
/// ---
///
/// Consider a scenario where you need to save and retrieve data from a data store, such as a database or a cloud service.
/// The serializer facilitates:
/// - Converting model objects into a format suitable for storage (serialization).
/// - Restoring stored data back into model objects (deserialization).
///
/// ---
///
/// **Usage**
///
/// ```dart
/// class MySerializer extends IGenericSerializer<Value, JSON> {
///    // Your implementation here
/// }
///
/// @JsonSerializable()
/// class Example {
///   @MySerializer()
///   final Value property;
/// }
/// ```
/// {@endtemplate}
abstract class IGenericSerializer<Deserialized, Serialized>
    implements JsonConverter<Deserialized, Serialized> {
  /// {@macro generic_serializer}
  const IGenericSerializer();

  /// Serializes the given [data] into a [Serialized] object.
  Serialized serialize(Deserialized data);

  /// Deserializes the given [data] into a [Deserialized] object.
  Deserialized deserialize(Serialized data);

  @override
  Deserialized fromJson(Serialized json) => deserialize(json);

  @override
  Serialized toJson(Deserialized object) => serialize(object);
}

/// Type alias for JSON objects used to make the code more readable.
typedef JSON = Map<String, dynamic>;
