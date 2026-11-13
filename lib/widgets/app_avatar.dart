import 'package:material_ui/material_ui.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.name,
    this.image,
    this.radius = 24,
    this.showOnlineBadge = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? name;
  final ImageProvider? image;
  final double radius;
  final bool showOnlineBadge;
  final Color? backgroundColor;
  final Color? foregroundColor;

  String _extractInitials(String? rawName) {
    if (rawName == null) return '';
    final parts = rawName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initials = _extractInitials(name);
    final bgColor = backgroundColor ?? colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? colorScheme.onPrimaryContainer;

    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      backgroundImage: image,
      child: image != null
          ? null
          : initials.isNotEmpty
          ? Text(
              initials,
              style: TextStyle(
                fontSize: radius * 0.72,
                fontWeight: FontWeight.w600,
              ),
            )
          : Icon(Icons.person_outline, size: radius),
    );

    if (!showOnlineBadge) {
      return avatar;
    }

    final badgeSize = radius * 0.52;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
