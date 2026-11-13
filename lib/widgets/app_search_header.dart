import 'package:material_ui/material_ui.dart';

import 'header_actions.dart';

class AppSearchHeader extends StatefulWidget implements PreferredSizeWidget {
  const AppSearchHeader({
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
    this.rightIconBadgeCount,
    this.rightIconBadgeMaxCount = 9,
    this.showRightIconBadge = false,
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
  final int? rightIconBadgeCount;
  final int rightIconBadgeMaxCount;
  final bool showRightIconBadge;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  State<AppSearchHeader> createState() => _AppSearchHeaderState();
}

class _AppSearchHeaderState extends State<AppSearchHeader> {
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
  void didUpdateWidget(covariant AppSearchHeader oldWidget) {
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

    return AppBar(
      toolbarHeight: kToolbarHeight + 8,
      leading: widget.leading,
      titleSpacing: widget.leading == null ? 16 : 0,
      actions: buildHeaderActions(
        actions: widget.actions,
        rightIcon: widget.rightIcon,
        onRightIconPressed: widget.onRightIconPressed,
        rightIconTooltip: widget.rightIconTooltip,
        rightIconBadgeCount: widget.rightIconBadgeCount,
        rightIconBadgeMaxCount: widget.rightIconBadgeMaxCount,
        showRightIconBadge: widget.showRightIconBadge,
      ),
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
