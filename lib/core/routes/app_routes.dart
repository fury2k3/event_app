import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/presentation/add_new_event/add_new_event_page.dart';
import 'package:event_app/features/event/presentation/event_details/event_details_page.dart';
import 'package:event_app/features/forgot-password/presentation/forgot_password_screen.dart';
import 'package:event_app/features/home_tab/home_tab.dart';
import 'package:event_app/features/login/presentation/login_page.dart';
import 'package:event_app/features/on_boarding/presentation/on_boarding_screen.dart';
import 'package:event_app/features/payment/presentation/widgets/payment_sccess.dart';
import 'package:event_app/features/register/presentation/register_page.dart';
import 'package:event_app/features/splash/presentation/splash_screen.dart';
import 'package:event_app/features/support/pressentation/support_screen.dart';
import 'package:event_app/global/views/page_under_construction.dart';
import 'package:flutter/material.dart';

const String splashScreen = '/';
const String onBoardingScreen = '/onBoardingScreen';
const String loginPage = '/login';
const String registerPage = '/register';
const String forgotPassword = '/forgot-password';
const String homePage = '/homePage';
const String eventPage = '/eventPage';
const String addEventPage = '/add-eventPage';
const String supportPage = '/supportPage';
const String paymentSuccessPage = '/paymentSuccessPage';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return _pageBuilder(
        (_) => const SplashScreen(),
        settings: settings,
      );
    case onBoardingScreen:
      return _pageBuilder(
        (_) => const OnBoardingScreen(),
        settings: settings,
      );
    case loginPage:
      return _pageBuilder(
        (_) => const LoginPage(),
        settings: settings,
      );
    case registerPage:
      return _pageBuilder(
        (_) => const RegisterPage(),
        settings: settings,
      );
    case homePage:
      return _pageBuilder(
        (_) => const MainScreen(),
        settings: settings,
      );
    case forgotPassword:
      return _pageBuilder(
        (_) => const ForgotPasswordScreen(),
        settings: settings,
      );
    case supportPage:
      return _pageBuilder(
        (_) => const SupportScreen(),
        settings: settings,
      );
    case addEventPage:
      return _pageBuilder(
        (_) => const AddNewEventPage(),
        settings: settings,
      );
    case eventPage:
      final arguments = settings.arguments! as EventModel;
      return _pageBuilder(
        (_) => EventDetailsPage(
          eventModel: arguments,
        ),
        settings: settings,
      );
    case paymentSuccessPage:
      return _pageBuilder(
        (_) => const PaymentSuccessfulScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
