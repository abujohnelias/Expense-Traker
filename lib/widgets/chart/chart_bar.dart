import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 2,
                  cornerSmoothing: 1,
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.3,
                ),
              ),
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
