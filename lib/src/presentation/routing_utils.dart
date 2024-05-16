import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A widget that wraps a [RouterOutlet] with the ability to activate a child route on default.
class InitialRouterOutlet extends StatelessWidget {
  /// A widget that wraps a [RouterOutlet] with the ability to activate a child route on default.
  const InitialRouterOutlet({super.key, required this.initialRoute});

  /// The path of the child route to activate on default.
  ///
  /// ```dart
  /// r.child(
  ///    "/",
  ///    child: (_) => const InitialRouterOutlet(
  ///        initialRoute: "/login",
  ///    ),
  ///    children: [
  ///      ParallelRoute(
  ///        name: "/login",
  ///        child: (_) => const LoginScreen(),
  ///      ),
  ///      ParallelRoute(
  ///        name: "/register",
  ///        child: (_) => const RegisterScreen(),
  ///      ),
  ///    ],
  /// );
  /// ```
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    Modular.to.pushReplacementNamed("${Modular.to.path}$initialRoute");

    return const RouterOutlet();
  }
}
