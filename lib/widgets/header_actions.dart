import 'package:material_ui/material_ui.dart';

/// Builds the combined `AppBar.actions` list from [actions] and an optional
/// [rightIcon] decorated with a Material 3 [Badge].
List<Widget>? buildHeaderActions({
  List<Widget>? actions,
  IconData? rightIcon,
  VoidCallback? onRightIconPressed,
  String? rightIconTooltip,
  int? rightIconBadgeCount,
  int rightIconBadgeMaxCount = 9,
  bool showRightIconBadge = false,
}) {
  final effectiveActions = <Widget>[
    ...?actions,
    if (rightIcon != null)
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          onPressed: onRightIconPressed,
          tooltip: rightIconTooltip,
          icon: _buildBadgedIcon(
            icon: rightIcon,
            badgeCount: rightIconBadgeCount,
            maxBadgeCount: rightIconBadgeMaxCount,
            showBadge: showRightIconBadge,
          ),
        ),
      ),
  ];

  return effectiveActions.isEmpty ? null : effectiveActions;
}

Widget _buildBadgedIcon({
  required IconData icon,
  required int? badgeCount,
  required bool showBadge,
  int maxBadgeCount = 9,
}) {
  final iconWidget = Icon(icon);

  if (badgeCount != null && badgeCount > 0) {
    final text = badgeCount > maxBadgeCount ? '$maxBadgeCount+' : '$badgeCount';
    return Badge(
      offset: const Offset(2, -4),
      label: Text(text),
      child: iconWidget,
    );
  }
  if (showBadge) {
    return Badge(child: iconWidget);
  }
  return iconWidget;
}
