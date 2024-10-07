import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/features/forgot-password/presentation/widgets/full_dots_indicators.dart';
import 'package:event_app/features/on_boarding/model/on_boarding_model.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: OnBoardingModel.onBoardingList().map((onBoardingModel) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    onBoardingModel.image,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    onBoardingModel.title,
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    onBoardingModel.description,
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 60),
                  FullDotsIndicators(
                    index: currentIndex,
                    activeColor: appPrimaryColor,
                    height: 6,
                    width: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GlobalButton(
                      onPressed: () {
                        if (currentIndex <
                            (OnBoardingModel.onBoardingList().length - 1)) {
                          setState(() {
                            currentIndex++;
                          });
                          pageController.animateToPage(
                            currentIndex,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease,
                          );
                        } else {
                          Navigator.of(context).pushReplacementNamed(loginPage);
                        }
                      },
                      textContent: currentIndex <
                              (OnBoardingModel.onBoardingList().length - 1)
                          ? 'NEXT'
                          : 'START',
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
