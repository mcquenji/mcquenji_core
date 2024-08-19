import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

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
class TickRepository extends Repository<Tick> {
  final TickInterval _interval;
  late final Timer _timer;

  bool _paused = false;

  /// {@macro tick_repository}
  TickRepository(this._interval, {bool paused = false}) : super(Tick.first()) {
    _timer = Timer.periodic(_interval, _tick);
    _paused = paused;
  }

  @override
  Level get level => Level.FINEST;

  void _tick(Timer timer) {
    if (_paused) {
      log('Currently paused, skipping tick');
      return;
    }

    emit(Tick());

    log('New tick emitted, next tick in $_interval');
  }

  /// Pauses the tick emission.
  void pause() {
    if (_paused) return;

    _paused = true;

    log('Paused tick emission');
  }

  /// Resumes the tick emission.
  ///
  /// This will not emit a tick immediately, but will resume the emission of ticks at the next interval.
  void resume() {
    if (!_paused) return;

    _paused = false;

    log('Resumed tick emission');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

/// An interval at which [TickRepository] should emit ticks.
@immutable
class TickInterval extends Duration {
  /// An interval at which [TickRepository] should emit ticks.
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
class Tick {
  /// If `true`, this is the first tick emitted by the [TickRepository].
  final bool isFirst;

  /// The timestamp at which the tick was emitted.
  final DateTime timestamp = DateTime.now();

  /// A tick emitted by the [TickRepository].
  Tick() : isFirst = false;

  /// A tick emitted by the [TickRepository].
  ///
  /// This is the first tick emitted by the repository.
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
typedef Ticks = TickRepository;
