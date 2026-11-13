import 'package:material_ui/material_ui.dart';

import 'app_button.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.actionIcon,
    this.onActionPressed,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? description;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: iconColor ?? colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: 6),
              Text(
                description!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 20),
              AppButton(
                label: actionLabel!,
                leftIcon: actionIcon,
                variant: AppButtonVariant.tonal,
                onPressed: onActionPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
