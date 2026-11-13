import 'package:material_ui/material_ui.dart';

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isScrollControlled = true,
  bool showDragHandle = true,
  EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 4, 20, 24),
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: true,
    showDragHandle: showDragHandle,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) =>
        _AppBottomSheetBody(title: title, padding: padding, child: child),
  );
}

class _AppBottomSheetBody extends StatelessWidget {
  const _AppBottomSheetBody({
    this.title,
    required this.padding,
    required this.child,
  });

  final String? title;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close',
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
