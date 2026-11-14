import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import 'app_segmented_switcher.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key, this.selectedMode, this.onChanged});

  final ThemeMode? selectedMode;
  final ValueChanged<ThemeMode>? onChanged;

  static const _options = [
    SegmentedSwitcherOption(
      value: ThemeMode.light,
      label: 'Light',
      icon: Icons.light_mode_outlined,
    ),
    SegmentedSwitcherOption(
      value: ThemeMode.dark,
      label: 'Dark',
      icon: Icons.dark_mode_outlined,
    ),
    SegmentedSwitcherOption(
      value: ThemeMode.system,
      label: 'System',
      icon: Icons.brightness_auto_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedMode != null) {
      return _buildSwitcher(selectedMode!);
    }

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentMode, _) => _buildSwitcher(currentMode),
    );
  }

  Widget _buildSwitcher(ThemeMode currentMode) {
    return AppSegmentedSwitcher<ThemeMode>(
      options: _options,
      selected: currentMode,
      onChanged: onChanged ?? (mode) => themeModeNotifier.value = mode,
    );
  }
}
