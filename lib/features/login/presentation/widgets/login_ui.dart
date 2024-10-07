import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/login/google_sigin_api.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/validator/validation.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.autoValidate,
    required this.formKey,
    required this.isLoading,
    super.key,
    this.setVisibility,
    this.login,
    this.goToRegister,
    this.goToForgotPassword,
  });

  final GestureTapCallback? login;
  final GestureTapCallback? goToRegister;
  final GestureTapCallback? goToForgotPassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final void Function()? setVisibility;
  final bool autoValidate;
  final GlobalKey formKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      autovalidateMode:
          autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 25,
          ),
          shrinkWrap: true,
          children: [
            Align(
              child: Text(
                LocaleKeys.auth_sign_in.tr(),
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 40),
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_email.tr(),
              controller: emailController,
              title: LocaleKeys.auth_email.tr(),
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 20,
              ),
              validateData: Validation.validateEmail,
              isNotEmail: false,
            ),
            const SizedBox(height: 10),
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_password.tr(),
              controller: passwordController,
              title: LocaleKeys.auth_password.tr(),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                size: 20,
              ),
              isPassword: true,
              obscureText: obscurePassword,
              setVisibility: setVisibility,
              validateData: Validation.validatePassword,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: goToForgotPassword,
              child: Text(
                LocaleKeys.auth_forgot_password.tr(),
                style: theme.textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 30),
            if (isLoading)
              const LoadingScreen()
            else
              GlobalButton(
                textContent: LocaleKeys.auth_sign_in.tr(),
                onPressed: login,
              ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  LocaleKeys.auth_not_having_account.tr(),
                ),
                InkWell(
                  onTap: goToRegister,
                  child: Text(
                    LocaleKeys.auth_join_us.tr(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: blueTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const ElevatedButton(
              onPressed: GoogleSignInApi.login,
              child: Text(
                'Sign In with google',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
