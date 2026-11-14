import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        rightIconBadgeCount: 3,
        onRightIconPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('3 new notifications')),
            );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AppBannerCard(
            title: 'Welcome to Flutter Route Kit',
            description: 'Starter template configured with go_router and a persistent bottom navigation shell.',
          ),
          const SizedBox(height: 20),
          Text('Quick Navigation', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final item in shortcuts)
            AppListCard(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              onTap: () => context.go(item.route),
            ),
          const SizedBox(height: 20),
          Text('Preferences', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              return AppListCard(
                icon: Icons.settings_outlined,
                title: 'Appearance',
                subtitle: 'Theme: ${mode.label}',
                onTap: () {
                  showAppBottomSheet<void>(
                    context: context,
                    title: 'Appearance',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'App theme',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        const ThemeSwitcher(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
