import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_route_kit/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const shortcuts = [
      (
        icon: Icons.explore_outlined,
        title: 'Explore',
        subtitle: 'Browse features and sections',
        route: '/explore',
      ),
      (
        icon: Icons.person_outline,
        title: 'Profile',
        subtitle: 'Account and preferences',
        route: '/profile',
      ),
    ];

    return Scaffold(
      appBar: AppHeader(
        title: 'Home',
        rightIcon: Icons.notifications_none,
        rightIconTooltip: 'Notifications',
        onRightIconPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: colorScheme.primaryContainer,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Flutter Route Kit',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Starter template configured with go_router and a persistent bottom navigation shell.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Quick Navigation', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final item in shortcuts) ...[
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(item.icon, color: colorScheme.primary),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go(item.route),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
