import 'package:material_ui/material_ui.dart';

enum AppButtonVariant { filled, tonal, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.leftIcon,
    this.rightIcon,
    this.isDisabled = false,
    this.isLoading = false,
    this.fullWidth = false,
    this.height = 48,
    this.borderRadius = 14,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final bool isDisabled;
  final bool isLoading;
  final bool fullWidth;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;
    final style = _buildStyle(context);
    final child = _buildContent();

    return switch (variant) {
      AppButtonVariant.filled => FilledButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.tonal => FilledButton.tonal(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
    };
  }

  ButtonStyle _buildStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(fullWidth ? double.infinity : 0, height),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      side: variant == AppButtonVariant.outlined
          ? WidgetStateProperty.resolveWith((states) {
              final color = states.contains(WidgetState.disabled)
                  ? colorScheme.outlineVariant.withValues(alpha: 0.5)
                  : colorScheme.outlineVariant;
              return BorderSide(color: color);
            })
          : null,
    );
  }

  Widget _buildContent() {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leftIcon != null) ...[
          Icon(leftIcon, size: 18),
          const SizedBox(width: 8),
        ],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
        if (rightIcon != null) ...[
          const SizedBox(width: 8),
          Icon(rightIcon, size: 18),
        ],
      ],
    );

    if (!isLoading) {
      return content;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: content,
        ),
        const SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      ],
    );
  }
}
