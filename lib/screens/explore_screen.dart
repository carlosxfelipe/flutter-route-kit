import 'package:material_ui/material_ui.dart';

import '../widgets/widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isLoading = false;
  bool _notificationsEnabled = true;
  String _searchQuery = '';
  String _selectedView = 'Day';
  String _selectedLayout = 'List';

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppHeader(title: 'Explore'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('AppButton Variants'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(label: 'Filled', onPressed: () {}),
              AppButton(
                label: 'Tonal',
                variant: AppButtonVariant.tonal,
                onPressed: () {},
              ),
              AppButton(
                label: 'Outlined',
                variant: AppButtonVariant.outlined,
                onPressed: () {},
              ),
              AppButton(
                label: 'Text',
                variant: AppButtonVariant.text,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Icons & States'),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'Left Icon',
                leftIcon: Icons.add,
                onPressed: () {},
              ),
              AppButton(
                label: 'Right Icon',
                variant: AppButtonVariant.outlined,
                rightIcon: Icons.arrow_forward,
                onPressed: () {},
              ),
              AppButton(label: 'Disabled', isDisabled: true, onPressed: () {}),
              AppButton(
                label: 'Tap to Load',
                variant: AppButtonVariant.tonal,
                isLoading: _isLoading,
                onPressed: _simulateLoading,
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Full Width Button',
            leftIcon: Icons.check_circle_outline,
            fullWidth: true,
            onPressed: () {},
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppSearchHeader'),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AppSearchHeader(
                hintText: 'Try searching...',
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Query: "$_searchQuery"',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 24),
          const _SectionTitle('AppListCard'),
          AppListCard(
            icon: Icons.palette_outlined,
            title: 'Theme & Appearance',
            subtitle: 'Default card with icon and chevron',
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('AppListCard tapped')),
                );
            },
          ),
          AppListCard(
            icon: Icons.notifications_active_outlined,
            title: 'Push Notifications',
            subtitle: 'Custom trailing widget',
            showChevron: false,
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
            onTap: () {
              setState(() => _notificationsEnabled = !_notificationsEnabled);
            },
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppBannerCard'),
          AppBannerCard(
            icon: Icons.auto_awesome_outlined,
            title: 'Featured Banner',
            description: 'Supports custom icon, colors, tap handler and an optional footer action.',
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            footer: AppButton(
              label: 'Learn more',
              variant: AppButtonVariant.outlined,
              rightIcon: Icons.arrow_forward,
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('AppBannerCard action')),
                  );
              },
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppEmptyState'),
          AppEmptyState(
            icon: Icons.inbox_outlined,
            title: 'No items yet',
            description: 'Use AppEmptyState for empty lists, search results, or offline views.',
            actionLabel: 'Create item',
            actionIcon: Icons.add,
            onActionPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('AppEmptyState action')),
                );
            },
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppTextField'),
          const AppTextField(
            label: 'Username',
            hintText: 'Enter your handle',
            prefixIcon: Icons.alternate_email,
          ),
          const SizedBox(height: 12),
          const AppTextField(
            label: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            enableVisibilityToggle: true,
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppBottomSheet'),
          AppButton(
            label: 'Open bottom sheet',
            leftIcon: Icons.vertical_align_top_outlined,
            variant: AppButtonVariant.outlined,
            fullWidth: true,
            onPressed: () {
              showAppBottomSheet<void>(
                context: context,
                title: 'Quick Actions',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppListCard(
                      icon: Icons.share_outlined,
                      title: 'Share link',
                      subtitle: 'Copy route URL to clipboard',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 10),
                    AppListCard(
                      icon: Icons.bookmark_border_outlined,
                      title: 'Save preset',
                      subtitle: 'Store current configuration',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppAvatar'),
          const Row(
            children: [
              AppAvatar(
                name: 'Carlos Araujo',
                radius: 24,
                showOnlineBadge: true,
              ),
              SizedBox(width: 12),
              AppAvatar(name: 'Ada Lovelace', radius: 24),
              SizedBox(width: 12),
              AppAvatar(radius: 20, showOnlineBadge: true),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionTitle('AppSegmentedSwitcher'),
          AppSegmentedSwitcher<String>(
            options: const [
              SegmentedSwitcherOption(
                value: 'Day',
                label: 'Day',
                icon: Icons.today_outlined,
              ),
              SegmentedSwitcherOption(
                value: 'Week',
                label: 'Week',
                icon: Icons.view_week_outlined,
              ),
              SegmentedSwitcherOption(
                value: 'Month',
                label: 'Month',
                icon: Icons.calendar_month_outlined,
              ),
            ],
            selected: _selectedView,
            onChanged: (value) => setState(() => _selectedView = value),
          ),
          const SizedBox(height: 8),
          Text(
            'Selected view: $_selectedView',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          AppSegmentedSwitcher<String>(
            options: const [
              SegmentedSwitcherOption(
                value: 'List',
                label: 'List',
                icon: Icons.view_list_outlined,
              ),
              SegmentedSwitcherOption(
                value: 'Grid',
                label: 'Grid',
                icon: Icons.grid_view_outlined,
              ),
            ],
            selected: _selectedLayout,
            onChanged: (value) => setState(() => _selectedLayout = value),
          ),
          const SizedBox(height: 8),
          Text(
            'Selected layout: $_selectedLayout',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
