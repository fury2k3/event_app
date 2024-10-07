import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class RegistrationSecondSection extends StatelessWidget {
  const RegistrationSecondSection({
    required this.passwordController,
    required this.confirmPasswordController,
    required this.confirmButton,
    required this.formKey,
    required this.autoValidate,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.isLoading,
    super.key,
    this.setVisibility,
  });

  final TextEditingController passwordController;
  final bool showPassword;
  final TextEditingController confirmPasswordController;
  final bool showConfirmPassword;

  final void Function(int index)? setVisibility;

  final Function confirmButton;
  final GlobalKey formKey;
  final bool autoValidate;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_password.tr(),
              controller: passwordController,
              title: LocaleKeys.auth_password.tr(),
              isPassword: true,
              obscureText: showPassword,
              setVisibility: () {
                setVisibility?.call(0);
              },
            ),
            const SizedBox(height: 10),
            LoginTextFormBloc(
              hint: LocaleKeys.auth_hint_re_password.tr(),
              controller: confirmPasswordController,
              title: LocaleKeys.auth_confirm_password.tr(),
              isPassword: true,
              obscureText: showConfirmPassword,
              setVisibility: () {
                setVisibility?.call(1);
              },
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const LoadingScreen()
            else
              GlobalButton(
                textContent: LocaleKeys.finish.tr(),
                onPressed: () => confirmButton(),
              ),
          ],
        ),
      ),
    );
  }
}
