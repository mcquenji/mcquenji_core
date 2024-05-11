export 'src/domain/domain.dart';
export 'src/presentation/presentation.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Core module of all McQuenji projects.
///
/// Provides basic services and utilities for all projects, such as [NetworkService] and [ConnectivityService].
class Core extends Module {
  @override
  void binds(i) {}

  @override
  void exportedBinds(i) {}
}
