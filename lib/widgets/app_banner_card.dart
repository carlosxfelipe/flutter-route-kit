import 'package:material_ui/material_ui.dart';

class AppBannerCard extends StatelessWidget {
  const AppBannerCard({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 12,
    this.onTap,
    this.footer,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final resolvedBg = backgroundColor ?? colorScheme.primaryContainer;
    final resolvedFg = foregroundColor ?? colorScheme.onPrimaryContainer;

    final content = Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: resolvedFg),
            const SizedBox(height: 12),
          ],
          Text(title, style: textTheme.titleLarge?.copyWith(color: resolvedFg)),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: textTheme.bodyMedium?.copyWith(color: resolvedFg),
            ),
          ],
          if (footer != null) ...[const SizedBox(height: 16), footer!],
        ],
      ),
    );

    return Card(
      color: resolvedBg,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: onTap != null ? InkWell(onTap: onTap, child: content) : content,
    );
  }
}
