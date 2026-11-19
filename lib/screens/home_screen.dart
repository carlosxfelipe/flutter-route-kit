import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _githubRepoUrl =
      'https://github.com/carlosxfelipe/flutter-route-kit';

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _copyRepositoryUrl(BuildContext context) async {
    try {
      await Clipboard.setData(const ClipboardData(text: _githubRepoUrl));
      if (!context.mounted) return;
      _showSnackBar(context, 'GitHub repository URL copied to clipboard');
    } catch (_) {
      if (!context.mounted) return;
      _showSnackBar(context, 'Could not copy GitHub repository URL');
    }
  }

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
        onRightIconPressed: () => _showSnackBar(context, '3 new notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
          const SizedBox(height: 12),
          Text('Resources', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          AppListCard(
            icon: Icons.code,
            title: 'GitHub Repository',
            subtitle: 'carlosxfelipe/flutter-route-kit',
            onTap: () => _copyRepositoryUrl(context),
          ),
        ],
      ),
    );
  }
}
