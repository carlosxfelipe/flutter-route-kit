import 'package:material_ui/material_ui.dart';

import 'header_actions.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.leading,
    this.rightIcon,
    this.onRightIconPressed,
    this.rightIconTooltip,
    this.rightIconBadgeCount,
    this.rightIconBadgeMaxCount = 9,
    this.showRightIconBadge = false,
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
  final int? rightIconBadgeCount;
  final int rightIconBadgeMaxCount;
  final bool showRightIconBadge;
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
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: buildHeaderActions(
        actions: actions,
        rightIcon: rightIcon,
        onRightIconPressed: onRightIconPressed,
        rightIconTooltip: rightIconTooltip,
        rightIconBadgeCount: rightIconBadgeCount,
        rightIconBadgeMaxCount: rightIconBadgeMaxCount,
        showRightIconBadge: showRightIconBadge,
      ),
      bottom: bottom,
      title: Text(title),
    );
  }
}
