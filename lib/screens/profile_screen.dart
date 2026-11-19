import 'package:material_ui/material_ui.dart';

import '../router/app_router.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.onSignOut});

  final VoidCallback? onSignOut;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  void _setNotificationsEnabled(bool enabled) {
    setState(() => _notificationsEnabled = enabled);
  }

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showAppearanceSheet(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return showAppBottomSheet<void>(
      context: context,
      title: 'Appearance',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('App theme', style: textTheme.titleMedium),
          const SizedBox(height: 12),
          const ThemeSwitcher(),
        ],
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return showAppBottomSheet<void>(
      context: context,
      title: 'Sign out',
      child: Builder(
        builder: (sheetContext) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Are you sure you want to sign out of your account?',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Cancel',
                    variant: AppButtonVariant.outlined,
                    fullWidth: true,
                    onPressed: () => Navigator.of(sheetContext).pop(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    label: 'Sign out',
                    leftIcon: Icons.logout,
                    fullWidth: true,
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      (widget.onSignOut ?? authSession.signOut)();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppHeader(title: 'Profile'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const _ProfileCard(name: 'User Profile', email: 'user@example.com'),
          const SizedBox(height: 18),
          Text('Account', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          AppListCard(
            icon: Icons.manage_accounts_outlined,
            title: 'Edit Profile',
            subtitle: 'Update your name and personal info',
            onTap: () => _showComingSoon(context, 'Edit profile coming soon'),
          ),
          AppListCard(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: _notificationsEnabled ? 'Enabled' : 'Disabled',
            showChevron: false,
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: _setNotificationsEnabled,
            ),
            onTap: () => _setNotificationsEnabled(!_notificationsEnabled),
          ),
          AppListCard(
            icon: Icons.shield_outlined,
            title: 'Privacy & Security',
            subtitle: 'Password and session settings',
            onTap: () =>
                _showComingSoon(context, 'Privacy & Security coming soon'),
          ),
          const SizedBox(height: 10),
          Text('Preferences', style: textTheme.titleMedium),
          const SizedBox(height: 10),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              return AppListCard(
                icon: Icons.settings_outlined,
                title: 'Appearance',
                subtitle: 'Theme: ${mode.label}',
                onTap: () => _showAppearanceSheet(context),
              );
            },
          ),
          const SizedBox(height: 14),
          AppButton(
            label: 'Sign out',
            variant: AppButtonVariant.outlined,
            leftIcon: Icons.logout,
            fullWidth: true,
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          AppAvatar(name: name, radius: 36, showOnlineBadge: true),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
