import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class LoginTextForm extends StatelessWidget {
  const LoginTextForm({
    required this.hint,
    required this.controller,
    required this.validateData,
    super.key,
    this.isNotEmail = true,
    this.obscureText = false,
    this.isPassword = false,
    this.setVisibility,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly,
    this.textInputType,
    this.maxLine = 1,
    this.minLine,
  });
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validateData;
  final bool obscureText;
  final bool isNotEmail;
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
    final theme = Theme.of(context);
    final height = (maxLine ?? 1) > 1 ? ((maxLine ?? 1) * 24.0) : null;
    return SizedBox(
      height: height,
      child: TextFormField(
        style: theme.textTheme.headlineSmall,
        cursorColor: geryTextLoginInputColor,
        maxLines: maxLine,
        minLines: minLine,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.transparent,

          // Background color
          hintText: hint,
          // Placeholder text
          hintStyle: theme.textTheme.headlineSmall
              ?.copyWith(color: geryHintLoginInputColor),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: geryInputLoginBorderColor,
            ),
          ),
          helperText: ' ',
          helperStyle: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.transparent,
            height: 0.5,
          ),

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: geryInputLoginBorderColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: geryTextLoginInputColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: redErrorLoginInputColor,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: redErrorLoginInputColor,
            ),
          ),
          errorStyle: theme.textTheme.headlineSmall?.copyWith(
            color: redErrorLoginInputColor,
            height: 0.5,
          ),

          prefixIcon: prefixIcon,
          suffixIcon: (isPassword ?? false)
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                  color: appPrimaryColor,
                  onPressed: setVisibility,
                )
              : suffixIcon,
        ),
        validator: validateData,
        obscureText: obscureText,
        readOnly: readOnly ?? false,
        keyboardType: textInputType ??
            (isNotEmail ? TextInputType.text : TextInputType.emailAddress),
        controller: controller,
        textCapitalization: isNotEmail == true
            ? TextCapitalization.words
            : TextCapitalization.sentences,
      ),
    );
  }
}
