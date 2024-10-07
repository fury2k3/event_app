import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_field.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextFormBloc extends StatelessWidget {
  const LoginTextFormBloc({
    required this.hint,
    required this.controller,
    required this.title,
    this.validateData,
    this.isNotEmail,
    this.obscureText = false,
    this.isPassword = false,
    this.setVisibility,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
    this.readOnly,
    this.textInputType,
    this.maxLine = 1,
    this.minLine,
  });

  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validateData;
  final bool obscureText;
  final bool? isNotEmail;
  final String title;
  final bool? isPassword;
  final bool? readOnly;
  final VoidCallback? setVisibility;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? minLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTextFormTitle(title: title),
          LoginTextForm(
            controller: controller,
            hint: hint,
            validateData: validateData,
            isNotEmail: isNotEmail ?? true,
            obscureText: obscureText,
            isPassword: isPassword,
            setVisibility: setVisibility,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            readOnly: readOnly,
            textInputType: textInputType,
            maxLine: maxLine,
            minLine: minLine,
          ),
        ],
      ),
    );
  }
}
