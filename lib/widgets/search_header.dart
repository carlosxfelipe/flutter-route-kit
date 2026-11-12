import 'package:material_ui/material_ui.dart';

class SearchHeader extends StatefulWidget implements PreferredSizeWidget {
  const SearchHeader({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.leading,
    this.rightIcon,
    this.onRightIconPressed,
    this.rightIconTooltip,
    this.actions,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final Widget? leading;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final String? rightIconTooltip;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late TextEditingController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant SearchHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onTextChanged);
      if (_ownsController) {
        _controller.dispose();
      }
      _ownsController = widget.controller == null;
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _handleClear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveActions = <Widget>[
      ...?widget.actions,
      if (widget.rightIcon != null)
        IconButton(
          onPressed: widget.onRightIconPressed,
          tooltip: widget.rightIconTooltip,
          icon: Icon(widget.rightIcon),
        ),
    ];

    return AppBar(
      toolbarHeight: kToolbarHeight + 8,
      leading: widget.leading,
      titleSpacing: widget.leading == null ? 16 : 0,
      actions: effectiveActions.isEmpty ? null : effectiveActions,
      title: SearchBar(
        controller: _controller,
        autoFocus: widget.autofocus,
        hintText: widget.hintText,
        textInputAction: TextInputAction.search,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
          colorScheme.surfaceContainerHigh,
        ),
        constraints: const BoxConstraints(minHeight: 48, maxHeight: 48),
        leading: const Icon(Icons.search),
        trailing: [
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: _handleClear,
              tooltip: 'Clear',
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}
