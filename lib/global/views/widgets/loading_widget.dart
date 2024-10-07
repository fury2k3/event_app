import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.height,
    this.color,
  });
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: color ?? appPrimaryColor,
          size: height ?? 45,
        ),
      ),
    );
  }
}
