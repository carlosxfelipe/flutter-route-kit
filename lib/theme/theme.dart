import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

export 'theme_mode.dart';

// Swap the active AppTheme implementation by changing the export below.
export 'custom_blue_theme.dart';

// export 'deep_purple_theme.dart';

/// Builds a [SystemUiOverlayStyle] synchronized with [theme], defaulting the
/// Android navigation bar color to [ThemeData.scaffoldBackgroundColor].
SystemUiOverlayStyle systemOverlayStyleFor(
  ThemeData theme, {
  Color? navigationBarColor,
}) {
  final iconBrightness = theme.brightness == Brightness.dark
      ? Brightness.light
      : Brightness.dark;

  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: iconBrightness,
    statusBarBrightness: theme.brightness,
    systemNavigationBarColor:
        navigationBarColor ?? theme.scaffoldBackgroundColor,
    systemNavigationBarIconBrightness: iconBrightness,
    systemNavigationBarDividerColor: Colors.transparent,
  );
}
