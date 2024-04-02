import 'package:companymanager/data.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double value;
  final double height;
  const AnimatedProgressBar(
      {super.key,
      required this.value,
      this.height = Sizes.progressBarDefaultHeight});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return Container(
          padding: const EdgeInsets.all(Sizes.progressBarContainerPadding),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: AnimationTime.progressBarMilliseconds,
                ),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floorValue(value),
                decoration: BoxDecoration(
                  color: _colorGenerator(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _floorValue(double value, [minimum = 0.0]) {
    return value.sign <= minimum ? minimum : value;
  }

  _colorGenerator(double value) {
    int rgb = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rgb).withRed(255 - rgb);
  }
}
