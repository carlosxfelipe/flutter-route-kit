import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../screens/screens.dart';

// Set to false to disable the login flow and start directly on /home.
const bool _requireAuth = true;
final ValueNotifier<bool> _isAuthenticated = ValueNotifier<bool>(false);

final GoRouter appRouter = GoRouter(
  initialLocation: _requireAuth ? '/login' : '/home',
  refreshListenable: _requireAuth ? _isAuthenticated : null,
  redirect: _requireAuth
      ? (context, state) {
          final isLoggedIn = _isAuthenticated.value;
          final isGoingToLogin = state.matchedLocation == '/login';

          if (!isLoggedIn && !isGoingToLogin) return '/login';
          if (isLoggedIn && isGoingToLogin) return '/home';
          return null;
        }
      : null,
  routes: [
    if (_requireAuth)
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            LoginScreen(onLoginSuccess: () => _isAuthenticated.value = true),
      ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const PlaceholderScreen(
                title: 'Profile',
                description:
                    'Account screen. Manage user details and preferences here.',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
