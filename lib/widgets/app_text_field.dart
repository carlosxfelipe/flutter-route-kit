import 'package:material_ui/material_ui.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enableVisibilityToggle = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.borderRadius = 14,
  });

  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enableVisibilityToggle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final int maxLines;
  final double borderRadius;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(widget.borderRadius);

    final effectiveSuffix =
        widget.suffixIcon ??
        (widget.enableVisibilityToggle
            ? IconButton(
                onPressed: () => setState(() => _isObscured = !_isObscured),
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null);

    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      enabled: widget.enabled,
      maxLines: _isObscured ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: effectiveSuffix,
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(borderRadius: radius),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
