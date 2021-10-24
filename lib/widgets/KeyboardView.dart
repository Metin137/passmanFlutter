import 'package:flutter/cupertino.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({
    Key? key,
    required this.child,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
