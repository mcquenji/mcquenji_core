import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:modular_core/modular_core.dart';

/// {@template tick_repository}
/// A repository that emits ticks at a specified interval.
/// The emitted ticks can be used to trigger periodic updates in the application.
///
/// This repository generates periodic ticks and emits them as events.
/// It can be [pause]d and [resume]d. When paused, it will not emit any ticks.
///
/// To use this repository watch it in your repository and override the [build] method to handle the ticks:
///
/// ```dart
/// class MyRepository extends Repository<Value> {
///   final TickRepository _tickRepository;
///
///   MyRepository(this._tickRepository) : super(Value.new) {
///     watch(_tickRepository);
///   }
///
///   @override
///   FutureOr<void> build() async {
///     // Refresh the state of the repository
///   }
/// }
/// ```
///
/// You also must register an instance in your [Module] by calling the [RepositoryInjectorExt.addTickRepository] method:
///
/// ```dart
/// @override
/// void binds(Injector i) {
///   i.addTickRepository(TickInterval(seconds: 1));
/// }
/// ```
/// {@endtemplate}
@Deprecated('Use Repository.updateInterval instead')
class TickRepository extends Repository<Tick> {
  final TickInterval _interval;

  bool _paused = false;

  /// {@macro tick_repository}
  @Deprecated('Use Repository.updateInterval instead')
  TickRepository(this._interval, {bool paused = false}) : super(Tick.first()) {
    _paused = paused;
  }

  @override
  Duration get updateInterval => _interval;

  @override
  Level get level => Level.FINEST;

  @override
  FutureOr<void> build(Trigger trigger) async {
    if (_paused) {
      log('Currently paused, skipping tick');
      return;
    }

    emit(Tick());

    log('New tick emitted, next tick in $_interval');
  }

  /// Pauses the tick emission.
  @Deprecated('Use Repository.updateInterval instead')
  void pause() {
    if (_paused) return;

    _paused = true;

    log('Paused tick emission');
  }

  /// Resumes the tick emission.
  ///
  /// This will not emit a tick immediately, but will resume the emission of ticks at the next interval.
  @Deprecated('Use Repository.updateInterval instead')
  void resume() {
    if (!_paused) return;

    _paused = false;

    log('Resumed tick emission');
  }
}

/// An interval at which [TickRepository] should emit ticks.
@immutable
@Deprecated('Use Repository.updateInterval instead')
class TickInterval extends Duration {
  /// An interval at which [TickRepository] should emit ticks.
  @Deprecated('Use Repository.updateInterval instead')
  const TickInterval({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) : super(
          microseconds: microseconds +
              Duration.microsecondsPerMillisecond * milliseconds +
              Duration.microsecondsPerSecond * seconds +
              Duration.microsecondsPerMinute * minutes +
              Duration.microsecondsPerHour * hours +
              Duration.microsecondsPerDay * days,
        );
}

/// A tick emitted by the [TickRepository].
@immutable
@Deprecated('Use Repository.updateInterval instead')
class Tick {
  /// If `true`, this is the first tick emitted by the [TickRepository].
  final bool isFirst;

  /// The timestamp at which the tick was emitted.
  final DateTime timestamp = DateTime.now();

  /// A tick emitted by the [TickRepository].
  @Deprecated('Use Repository.updateInterval instead')
  Tick() : isFirst = false;

  /// A tick emitted by the [TickRepository].
  ///
  /// This is the first tick emitted by the repository.
  @Deprecated('Use Repository.updateInterval instead')
  Tick.first() : isFirst = true;

  /// This will always return `false` unless [other] is identical to this instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tick && other.timestamp == timestamp && other.isFirst == isFirst;

  @override
  int get hashCode => timestamp.hashCode ^ isFirst.hashCode;

  @override
  String toString() => 'Tick(isFirst: $isFirst, timestamp: $timestamp)';
}

/// Type alias for [TickRepository].
@Deprecated('Use Repository.updateInterval instead')
typedef Ticks = TickRepository;
