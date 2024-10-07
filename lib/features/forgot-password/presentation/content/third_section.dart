import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/forgot-password/presentation/widgets/full_dots_indicators.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassword3Section extends StatelessWidget {
  const ForgotPassword3Section({
    required this.updatePassword,
    required this.isLoading,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.formKey,
    required this.showPassword,
    required this.showConfirmPassword,
    super.key,
    this.setVisibility,
  });
  final bool isLoading;
  final GlobalKey formKey;

  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final void Function() updatePassword;

  final bool showPassword;
  final bool showConfirmPassword;

  final void Function(int index)? setVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FullDotsIndicators(index: 2),
            const SizedBox(height: 50),
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_password.tr(),
              controller: newPasswordController,
              title: LocaleKeys.auth_password.tr(),
              isPassword: true,
              obscureText: showPassword,
              setVisibility: () {
                setVisibility?.call(0);
              },
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
              ),
            ),
            const SizedBox(height: 10),
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_re_password.tr(),
              controller: confirmNewPasswordController,
              title: LocaleKeys.auth_confirm_password.tr(),
              isPassword: true,
              obscureText: showConfirmPassword,
              setVisibility: () {
                setVisibility?.call(1);
              },
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
              ),
            ),
            const SizedBox(height: 45),
            if (isLoading)
              const LoadingScreen()
            else
              GlobalButton(
                textContent: 'Continue',
                onPressed: updatePassword.call,
              ),
          ],
        ),
      ),
    );
  }
}
