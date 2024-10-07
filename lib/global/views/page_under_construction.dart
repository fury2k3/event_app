import 'package:event_app/global/utils/media_res.dart';
import 'package:event_app/global/views/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        child: Center(child: Lottie.asset(MediaRes.pageUnderConstruction)),
      ),
    );
  }
}
