import 'package:go_router/go_router.dart';

import 'package:flutter_route_kit/screens/screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
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
              builder: (context, state) => const PlaceholderScreen(
                title: 'Explore',
                description:
                    'Discovery screen. Browse sections or features here.',
              ),
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
