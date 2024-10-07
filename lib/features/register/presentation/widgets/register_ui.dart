import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/register/presentation/widgets/registration_first_section.dart';
import 'package:event_app/features/register/presentation/widgets/registration_second_section.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class RegisterUi extends StatelessWidget {
  const RegisterUi({
    required this.pageController,
    required this.userNameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.nextButton,
    required this.firstFormKey,
    required this.firstAutoValidate,
    required this.passwordController,
    required this.showPassword,
    required this.confirmPasswordController,
    required this.showConfirmPassword,
    required this.confirmButton,
    required this.secondFormKey,
    required this.autoValidateSecondForm,
    required this.isLoading,
    super.key,
    this.setVisibility,
  });
  final PageController pageController;

  // ---------- First Form -----------------------
  final TextEditingController userNameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final void Function() nextButton;
  final GlobalKey firstFormKey;
  final bool firstAutoValidate;

  // ---------- Second Form -----------------------

  final TextEditingController passwordController;
  final bool showPassword;
  final TextEditingController confirmPasswordController;
  final bool showConfirmPassword;

  final void Function(int index)? setVisibility;

  final Function confirmButton;
  final GlobalKey secondFormKey;
  final bool autoValidateSecondForm;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Align(
          child: Text(
            LocaleKeys.auth_sign_up.tr(),
            style: theme.textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            children: [
              RegistrationFirstSection(
                userNameController: userNameController,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                autoValidate: firstAutoValidate,
                nextButton: nextButton,
                formKey: firstFormKey,
              ),
              RegistrationSecondSection(
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                confirmButton: confirmButton,
                formKey: secondFormKey,
                autoValidate: autoValidateSecondForm,
                showPassword: showPassword,
                showConfirmPassword: showConfirmPassword,
                setVisibility: setVisibility,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
