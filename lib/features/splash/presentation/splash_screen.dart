import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
    slidingAnimation.addListener(() {
      setState(() {});
    });
  }

  void navigate({
    required bool isUserConnected,
  }) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(
        onBoardingScreen,
        //isUserConnected ? homePage : loginPage,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(GetUserIsConnectedEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is LoggedOutState) {
            navigate(isUserConnected: false);
          } else if (state is LoggedInState) {
            navigate(isUserConnected: true);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              builder: (context, _) {
                return SlideTransition(
                  position: slidingAnimation,
                  child: Text(
                    'Event App',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: globalBackgroundColor,
                    ),
                  ),
                );
              },
              animation: slidingAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
