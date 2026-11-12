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
          const _SectionTitle('SearchHeader'),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SearchHeader(
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
