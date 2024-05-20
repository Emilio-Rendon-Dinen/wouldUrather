import 'package:dares_game/presentation/home/home_notifier.dart';
import 'package:dares_game/presentation/home/home_screen.dart';
import 'package:dares_game/presentation/preferences/preferences_notifier.dart';
import 'package:dares_game/presentation/preferences/preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Routes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter getConfig([
    String? initialRoute,
  ]) {
    return GoRouter(
      initialLocation: initialRoute ?? '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => HomeNotifier(),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/preferences',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final int categoryId = state.extra as int;
            return ChangeNotifierProvider(
              create: (context) => PreferencesNotifier(
                categoryId: categoryId,
              ),
              child: const PreferencesScreen(),
            );
          },
        ),
      ],
    );
  }
}
