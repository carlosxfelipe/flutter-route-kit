import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static const Color seedColor = Colors.blue;

  static ThemeData light({Color seedColor = seedColor}) {
    return _build(Brightness.light, seedColor);
  }

  static ThemeData dark({Color seedColor = seedColor}) {
    return _build(Brightness.dark, seedColor);
  }

  static ThemeData _build(Brightness brightness, Color seedColor) {
    final isDark = brightness == Brightness.dark;
    final baseScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    // Neutral surface overrides: `surface` and `surfaceContainerLowest` share
    // the same base color, so cards/containers should use `surfaceContainer*`
    // or `outlineVariant` borders for separation. `outline` keeps the seed tint.
    final colorScheme = isDark
        ? baseScheme.copyWith(
            surface: Colors.black,
            surfaceContainerLowest: Colors.black,
            surfaceContainerLow: const Color(0xFF0D0D10),
            surfaceContainer: const Color(0xFF141418),
            surfaceContainerHigh: const Color(0xFF1C1C22),
            surfaceContainerHighest: const Color(0xFF24242C),
            onSurface: const Color(0xFFF5F5F7),
            onSurfaceVariant: const Color(0xFFB8B8C4),
            outlineVariant: const Color(0xFF2C2C35),
          )
        : baseScheme.copyWith(
            surface: Colors.white,
            surfaceContainerLowest: Colors.white,
            surfaceContainerLow: const Color(0xFFF7F7FA),
            surfaceContainer: const Color(0xFFF2F2F7),
            surfaceContainerHigh: const Color(0xFFECECF2),
            surfaceContainerHighest: const Color(0xFFE5E5EC),
            onSurface: const Color(0xFF141418),
            onSurfaceVariant: const Color(0xFF494954),
            outlineVariant: const Color(0xFFDADAE3),
          );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardThemeData(surfaceTintColor: Colors.transparent),
    );
  }
}
