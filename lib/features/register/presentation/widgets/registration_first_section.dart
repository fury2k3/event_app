import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:flutter/material.dart';

class RegistrationFirstSection extends StatelessWidget {
  const RegistrationFirstSection({
    required this.userNameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.nextButton,
    required this.formKey,
    required this.autoValidate,
    super.key,
  });

  final TextEditingController userNameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final void Function() nextButton;
  final GlobalKey formKey;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginTextFormBloc(
                hint: LocaleKeys.auth_hint_username.tr(),
                controller: userNameController,
                title: LocaleKeys.auth_username.tr(),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: LoginTextFormBloc(
                      hint: LocaleKeys.auth_hint_first_name.tr(),
                      controller: firstNameController,
                      title: LocaleKeys.auth_first_name.tr(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: LoginTextFormBloc(
                      hint: LocaleKeys.auth_hint_last_name.tr(),
                      controller: lastNameController,
                      title: LocaleKeys.auth_last_name.tr(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LoginTextFormBloc(
                hint: LocaleKeys.auth_hint_email.tr(),
                controller: emailController,
                title: LocaleKeys.auth_email.tr(),
                isNotEmail: false,
              ),
              const SizedBox(height: 20),
              GlobalButton(
                textContent: LocaleKeys.next.tr(),
                onPressed: nextButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
