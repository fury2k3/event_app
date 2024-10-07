import 'package:event_app/features/forgot-password/presentation/widgets/dots_indicator.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class FullDotsIndicators extends StatelessWidget {
  const FullDotsIndicators({
    required this.index,
    this.activeColor = successColor,
    this.width = 55,
    this.height = 10,
    super.key,
  });
  final int index;
  final Color? activeColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotsIndicator(
          color: index == 0 ? activeColor : geryHintLoginInputColor,
          height: height,
          width: width,
        ),
        DotsIndicator(
          color: index == 1 ? activeColor : geryHintLoginInputColor,
          height: height,
          width: width,
        ),
        DotsIndicator(
          color: index == 2 ? activeColor : geryHintLoginInputColor,
          height: height,
          width: width,
        ),
      ],
    );
  }
}
