import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

export 'services/services.dart';
export 'datasources/datasources.dart';
export 'models/models.dart';

/// A class that provides logging functionality.
///
/// Each class that extends this class should have a unique [namespace].
abstract class ILoggable {
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
    Logger("$namespace.$runtimeType").log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }
}

/// A versatile serializer interface for converting objects between different formats.
///
/// Primarily used in [Datasource]s to transform objects from one representation to another,
/// such as converting Dart objects to JSON and vice versa.
///
/// - [Deserialized]: The original type of the object before serialization (e.g., a Dart object).
/// - [Serialized]: The transformed type of the object after serialization (e.g., a JSON object).
///
/// ---
///
/// Consider a scenario where you need to save and retrieve data from a data store, such as a database or a cloud service.
/// The serializer facilitates:
/// - Converting model objects into a format suitable for storage (serialization).
/// - Restoring stored data back into model objects (deserialization).
abstract class IGenericSerializer<Deserialized, Serialized> {
  /// Serializes the given [data] into a [Serialized] object.
  Deserialized serialize(Serialized data);

  /// Deserializes the given [data] into a [Deserialized] object.
  Serialized deserialize(Deserialized data);
}

/// Type alias for JSON objects used to make the code more readable.
typedef JSON = Map<String, dynamic>;
