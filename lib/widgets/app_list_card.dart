import 'package:material_ui/material_ui.dart';

class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.leading,
    this.trailing,
    this.showChevron = true,
    this.onTap,
    this.borderRadius = 12,
    this.margin = const EdgeInsets.only(bottom: 8),
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Widget? leading;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveLeading =
        leading ??
        (icon != null
            ? Icon(icon, color: iconColor ?? colorScheme.primary)
            : null);
    final effectiveTrailing =
        trailing ?? (showChevron ? const Icon(Icons.chevron_right) : null);

    return Padding(
      padding: margin,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ListTile(
          leading: effectiveLeading,
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: effectiveTrailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
