import 'package:material_ui/material_ui.dart';

class SegmentedSwitcherOption<T> {
  const SegmentedSwitcherOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final T value;
  final String label;
  final IconData icon;
}

class AppSegmentedSwitcher<T> extends StatelessWidget {
  const AppSegmentedSwitcher({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<SegmentedSwitcherOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: [
        for (final option in options)
          ButtonSegment<T>(
            value: option.value,
            label: Text(option.label),
            icon: Icon(option.icon),
          ),
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
