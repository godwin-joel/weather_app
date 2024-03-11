import 'package:flutter/material.dart';

class OrientationWidget extends StatelessWidget {
  const OrientationWidget({
    required this.portraitWidget,
    required this.landscapeWidget,
    super.key,
  });

  final Widget portraitWidget;
  final Widget landscapeWidget;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? portraitWidget
            : landscapeWidget;
      },
    );
  }
}
