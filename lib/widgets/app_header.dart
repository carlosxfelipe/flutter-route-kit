import 'package:material_ui/material_ui.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.leading,
    this.rightIcon,
    this.onRightIconPressed,
    this.rightIconTooltip,
    this.actions,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.bottom,
  });

  final String title;
  final Widget? leading;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final String? rightIconTooltip;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final effectiveActions = <Widget>[
      ...?actions,
      if (rightIcon != null)
        IconButton(
          onPressed: onRightIconPressed,
          tooltip: rightIconTooltip,
          icon: Icon(rightIcon),
        ),
    ];

    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: effectiveActions.isEmpty ? null : effectiveActions,
      bottom: bottom,
      title: Text(title),
    );
  }
}
