import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static const Color seedColor = Colors.deepPurple;

  static ThemeData light({Color seedColor = seedColor}) {
    return _build(Brightness.light, seedColor);
  }

  static ThemeData dark({Color seedColor = seedColor}) {
    return _build(Brightness.dark, seedColor);
  }

  static ThemeData _build(Brightness brightness, Color seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
    );
  }
}
