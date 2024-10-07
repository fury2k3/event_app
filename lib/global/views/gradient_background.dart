import 'package:event_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        width: context.width,
        height: context.height,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [.2, .4, .6, .8],
          colors: [
            Colors.grey.shade50,
            Colors.grey.shade100,
            Colors.grey.shade200,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: child,
    );
  }
}
