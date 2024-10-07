import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/forgot-password/presentation/widgets/full_dots_indicators.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/validator/validation.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassword1Section extends StatelessWidget {
  const ForgotPassword1Section({
    required this.emailController,
    required this.sendResetCode,
    required this.isLoading,
    required this.firstFormKey,
    super.key,
  });

  final GlobalKey firstFormKey;

  final bool isLoading;
  final TextEditingController emailController;
  final void Function() sendResetCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: firstFormKey,
        child: Column(
          children: [
            const FullDotsIndicators(index: 0),
            const SizedBox(height: 30),
            Text(
              'Enter the email associated with your account and '
              "we'll send an email"
              ' with instructions to reset your password.',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 30),
            LoginTextFormBloc(
              hint: 'Your Email Here',
              controller: emailController,
              title: LocaleKeys.auth_email.tr(),
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 20,
              ),
              validateData: Validation.validateEmail,
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const LoadingScreen()
            else
              GlobalButton(
                textContent: 'Continue',
                onPressed: sendResetCode.call,
              ),
          ],
        ),
      ),
    );
  }
}
