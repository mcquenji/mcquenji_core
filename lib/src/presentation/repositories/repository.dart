import 'dart:async';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:modular_core/modular_core.dart';
import 'package:rxdart/subjects.dart';

/// Contains information about the trigger that caused the repository to rebuild.
@Deprecated('BuildTrigger has been renamed to Trigger')
typedef BuildTrigger = Trigger;

/// {@template repository}
/// Base class for all repositories.
///
/// As repositories are responsible for managing the state of the application, they extend [Cubit].
/// {@endtemplate}
abstract class Repository<State> extends Cubit<State>
    implements Loggable, Disposable, Trigger {
  final List<StreamSubscription> _subscriptions = [];
  late final BehaviorSubject<State> _subject;

  Timer? _updateSchedule;

  var _buildCompleter = Completer<void>();

  var _dataCompleter = Completer<void>();
  var _errorCompleter = Completer<void>();
  var _loadingCompleter = Completer<void>();

  /// `true` if the repository emits [AsyncValue]s.
  late final bool isAsync;

  /// Future that completes after any ongoing build process is finished.
  Future<void> get ready => _buildCompleter.future;

  DateTime? _lastUpdate;

  late Duration _currentInterval;
  Duration get _maxInterval => updateInterval * 10;

  /// Determines whether refresh optimization is enabled.
  ///
  /// When set to true, the repository dynamically adjusts its update interval based on whether
  /// the most recent update actually changed the state:
  /// - **No state change:** The update interval increases exponentially (using a 1.5 growth factor)
  ///   up to a maximum of 10× the base [updateInterval]. This minimizes redundant updates.
  /// - **State change detected:** The update interval resets to the base [updateInterval] for more
  ///   frequent updates.
  ///
  /// Additionally, if an update is triggered outside of the regular loop while refresh optimization
  /// is enabled, the interval resets to [updateInterval].
  ///
  /// Override this getter to return `true` if you want your repository to use this dynamic behavior.
  ///
  /// *Will be turned on in the future by default as the optimization algorithm is improved.*
  bool get refreshOptimization => false;

  /// {@macro repository}
  Repository(State initialState) : super(initialState) {
    _subject = BehaviorSubject.seeded(initialState);

    refresh(const InitialBuildTrigger());

    if (initialState is AsyncValue) {
      isAsync = true;
    }

    if (updateInterval != Duration.zero) {
      _currentInterval = updateInterval;
      _scheduleNextUpdate();
      log('Automatic updates enabled at ${updateInterval.inMilliseconds} ms');
    } else {
      log('Automatic updates disabled');
    }
  }

  void _scheduleNextUpdate() {
    _updateSchedule?.cancel();
    _updateSchedule = Timer(_currentInterval, _update);
  }

  int _noChangeStreak = 0;

  Future<void> _update() async {
    final lastUpdateBefore = _lastUpdate;
    final now = DateTime.now();

    if (_lastUpdate != null &&
        now.difference(_lastUpdate!) < _currentInterval) {
      log('Update skipped: last update was too recent');

      if (refreshOptimization) {
        _logRefreshOptimization(
          'Update outside of update loop detected. Resetting update interval to ${updateInterval.inMilliseconds} ms',
        );

        _noChangeStreak = 0;
        _currentInterval = updateInterval;
      }

      _scheduleNextUpdate();
      return;
    }

    log('Automatic update triggered');

    try {
      await refresh(const UpdateTrigger());
    } catch (e, s) {
      log('Error during automatic update', e, s);
    }

    if (!refreshOptimization) {
      _scheduleNextUpdate();
      return;
    }

    // If _lastUpdate hasn't changed, no state change occurred.
    if (lastUpdateBefore == _lastUpdate) {
      _noChangeStreak++;
      // Use exponential backoff with a growth factor
      final newIntervalMs = updateInterval.inMilliseconds *
          math.pow(
            1.5,
            _noChangeStreak,
          );

      _currentInterval = Duration(
        milliseconds: math
            .min(
              newIntervalMs,
              _maxInterval.inMilliseconds,
            )
            .toInt(),
      );

      _logRefreshOptimization(
        'No state change detected. Streak: $_noChangeStreak. Increasing update interval to ${_currentInterval.inMilliseconds} ms',
      );
    } else {
      // A state change occurred, so reset the no-change streak.
      _noChangeStreak = 0;
      _currentInterval = updateInterval;
      _logRefreshOptimization(
        'State changed. Resetting update interval to ${_currentInterval.inMilliseconds} ms',
      );
    }

    _scheduleNextUpdate();
  }

  /// The interval at which the repository should update.
  /// If [Duration.zero], the repository will not update unless triggered by another repository.
  /// When automatic updates are enabled, the [build] method will be called with [UpdateTrigger] at the specified interval.
  ///
  /// Override this getter to enable automatic updates.
  Duration get updateInterval => Duration.zero;

  @override
  Level get level => Level.INFO;

  @override
  String get namespace => 'Repositories';

  @override
  Level get errorLevel => Level.SEVERE;

  @override
  void log(Object message, [Object? error, StackTrace? stackTrace]) {
    Logger('$namespace.$runtimeType').log(
      error != null ? errorLevel : level,
      message,
      error,
      stackTrace,
    );
  }

  void _logRefreshOptimization(
    Object message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    Logger('$namespace.$runtimeType.RefreshOptimization').log(
      error != null ? errorLevel : Level.FINEST,
      message,
      error,
      stackTrace,
    );
  }

  /// Watches another [repository] for changes.
  ///
  /// Call this method in the constructor of your repository and override the [build] method to handle changes.
  ///
  /// {@template repository_watch_example}
  /// **Example:**
  ///
  /// ```dart
  /// class MyRepository extends Repository<MyState> {
  ///   final OtherRepository _otherRepository;
  ///
  ///   MyRepository(this._otherRepository) : super(MyState.new) {
  ///     watch(_otherRepository);
  ///   }
  ///
  ///   @override
  ///   FutureOr<void> build(Type trigger) async {
  ///     final otherState = _otherRepository.state;
  ///
  ///     // Do something with otherState
  ///   }
  /// }
  /// ```
  ///
  /// For watching repositories that return an [AsyncValue], use [RepoWatchExt.watchAsync].
  /// **Note:** The repository watching must also return an [AsyncValue] to use [RepoWatchExt.watchAsync].
  /// {@endtemplate}
  @protected
  @nonVirtual
  void watch<T>(Repository<T> repository) {
    assert(repository != this, 'Cannot watch self');

    _subscriptions.add(
      repository.stream.listen(
        (value) => _didChangeDependencies<T>(
          value,
          repository,
        ),
      ),
    );
  }

  /// Called when a watched repository emits a new state.
  Future<void> _didChangeDependencies<T>(
    dynamic value,
    Repository<T> repository,
  ) async {
    Logger('$namespace.$runtimeType').log(
      Level.FINEST,
      'Received new $T from ${repository.runtimeType}: $value',
    );

    await refresh(repository);
  }

  /// Triggers a repository refresh.
  /// Catches all exceptions thrown during the build process.
  ///
  /// Call this method to manually refresh the repository.
  Future<void> refresh(Trigger trigger) async {
    final completer = Completer();

    _buildCompleter = completer;

    try {
      await build(trigger);
    } on WaitForDataException catch (e) {
      log('Aborting build: $e');
    } catch (e, s) {
      log('Error during build', e, s);
    } finally {
      completer.complete();
    }
  }

  /// Recalculates the state of the repository.
  /// Do not call this method directly, use [refresh] instead.
  ///
  /// This method is called when:
  ///
  /// - The repository is first initialized.
  /// - A repository watched via [watch] emits a new state.
  /// - This repository is updated (if [updateInterval] is not [Duration.zero]).
  ///
  /// Override this method to handle changes from said repositories.
  ///
  /// ---
  ///
  /// **Example:**
  ///
  /// ```dart
  /// class MyRepository extends Repository<MyState> {
  ///   final OtherRepository _otherRepository;
  ///
  ///   MyRepository(this._otherRepository) : super(MyState.new) {
  ///     watch(_otherRepository);
  ///   }
  ///
  ///   @override
  ///   FutureOr<void> build(BuildTrigger trigger) async {
  ///     if(trigger is InitialBuildTrigger) {
  ///       // Do something when the repository is first initialized
  ///     }
  ///
  ///     if(trigger is UpdateTrigger) {
  ///       // Do something when the repository is updated
  ///     }
  ///
  ///     if(trigger is OtherRepository) {
  ///       // Do something when the other repository emits a new state
  ///     }
  ///   }
  /// }
  /// ```
  @protected
  FutureOr<void> build(Trigger trigger) {}

  @override
  @mustCallSuper
  void dispose() {
    close();
    _subject.close();
    _updateSchedule?.cancel();

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    log('Disposed');
  }

  /// Shortcut for [Stream.listen].
  @nonVirtual
  StreamSubscription<State> listen(
    void Function(State)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  @nonVirtual
  Stream<State> get stream => _subject.stream;

  @override
  @mustCallSuper
  void emit(State state) {
    final logger = Logger('$namespace.$runtimeType');

    if (state == this.state) {
      logger.finest('State is the same as current state, skipping emit');
      return;
    }

    logger.finest('Emitted new state: $state');

    _lastUpdate = DateTime.now();

    super.emit(state);
    _subject.add(state);

    if (isAsync) {
      final asyncValue = state as AsyncValue;

      if (asyncValue.hasData) {
        if (!_dataCompleter.isCompleted) _dataCompleter.complete();

        _errorCompleter = Completer();
        _loadingCompleter = Completer();
      } else if (asyncValue.hasError) {
        if (!_errorCompleter.isCompleted) _errorCompleter.complete();

        _dataCompleter = Completer();
        _loadingCompleter = Completer();
      } else if (asyncValue.isLoading) {
        if (!_loadingCompleter.isCompleted) _loadingCompleter.complete();

        _dataCompleter = Completer();
        _errorCompleter = Completer();
      }
    }
  }
}

/// Extension for watching asynchronous repositories in asynchronous repositories.
extension RepoWatchExt<State> on Repository<AsyncValue<State>> {
  /// Does the same as [watch] but for repositories that return an [AsyncValue].
  ///
  /// - If [setLoading] is true, this repository will emit a new state with the loading state of the watched repository.
  /// - If [setError] is true, this repository will emit a new state with the error state of the watched repository.
  ///
  /// Use [waitForData] in [build] to wait for the data of the watched repository.
  ///
  /// In the event of [build] throwing an error, this repository will emit an error state.
  ///
  /// ---
  ///
  /// **Example:**
  ///
  /// ```dart
  /// class MyRepository extends Repository<AsyncValue<MyState>> {
  ///   final OtherRepository _otherRepository;
  ///
  ///   MyRepository(this._otherRepository) : super(MyState.new) {
  ///     watchAsync(_otherRepository);
  ///   }
  ///
  ///   @override
  ///   FutureOr<void> build() async {
  ///     final otherState = waitForData(_otherRepository);
  ///
  ///     // Do something with otherState
  ///   }
  /// }
  /// ```
  void watchAsync<T>(
    Repository<AsyncValue<T>> repository, {
    bool setLoading = true,
    bool setError = true,
  }) {
    assert(repository != this, 'Cannot watch self');

    void onError(Object e, StackTrace? s) {
      setError ? error(e, s) : log('Error in ${repository.runtimeType}', e, s);
    }

    void onLoading() {
      setLoading ? loading() : log('${repository.runtimeType} is loading');
    }

    _subscriptions.add(
      repository.stream.listen(
        (value) => value.when(
          data: (data) async {
            try {
              await _didChangeDependencies<AsyncValue<T>>(
                data,
                repository,
              );
            } on WaitForDataException catch (e) {
              log('Aborting build: $e');
            } catch (e, s) {
              error(e, s);
            }
          },
          loading: onLoading,
          error: onError,
        ),
      ),
    );
  }

  /// Call this in [build] to wait for the data of a repository.
  T waitForData<T>(Repository<AsyncValue<T>> repository) {
    if (!repository.state.hasData) {
      throw WaitForDataException(T);
    }

    return repository.state.requireData;
  }
}

/// Passed as trigger in [Repository.build] when called the first time.
class InitialBuildTrigger implements Trigger {
  /// Passed as trigger in [Repository.build] when called the first time.
  const InitialBuildTrigger();
}

/// Passed as trigger in [Repository.build] when called in the [Repository.updateInterval].
class UpdateTrigger implements Trigger {
  /// Passed as trigger in [Repository.build] when called in the [Repository.updateInterval].
  const UpdateTrigger();
}

/// Thrown when [RepoWatchExt.waitForData] is called on a repository that does not have data yet.
class WaitForDataException implements Exception {
  /// The type of the repository that does not have data yet.
  final Type type;

  /// Thrown when [RepoWatchExt.waitForData] is called on a repository that does not have data yet.
  WaitForDataException(this.type);

  @override
  String toString() => 'Repository of type $type does not have data yet.';
}

/// Contains information about the trigger that caused the repository to rebuild.
abstract class Trigger {}

/// Utility extension on repositories with an asynchronous state.
extension AsyncRepoExt<State> on Repository<AsyncValue<State>> {
  /// Emits [AsyncValue.error] with the given [error] and [stackTrace].
  void error(Object error, [StackTrace? stackTrace]) {
    emit(AsyncValue.error(error, stackTrace));
  }

  /// Emits [AsyncValue.loading].
  void loading() {
    emit(AsyncValue.loading());
  }

  /// Emits [AsyncValue.data] with the given [data].
  void data(State data) {
    emit(AsyncValue.data(data));
  }

  /// Guards the given [future] and emits the result.
  ///
  /// See [AsyncValue.guard] for more information.
  Future<void> guard(
    Future<State> Function() future, {
    void Function(State)? onData,
    void Function(Object, StackTrace?)? onError,
  }) async {
    emit(
      await AsyncValue.guard(
        future,
        onData: onData,
        onError: onError,
      ),
    );
  }

  /// A future that completes when this repository has data.
  ///
  /// ⚠️ Experimental API. Use with caution.
  Future<void> get hasData => _dataCompleter.future;

  /// A future that completes when this repository has an error.
  ///
  /// ⚠️ Experimental API. Use with caution.
  Future<void> get hasError => _errorCompleter.future;

  /// A future that completes when this repository is loading.
  ///
  /// ⚠️ Experimental API. Use with caution.
  Future<void> get isLoading => _loadingCompleter.future;
}
