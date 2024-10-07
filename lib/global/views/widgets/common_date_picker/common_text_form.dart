import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class CommonTextForm extends StatelessWidget {
  const CommonTextForm({
    required this.hint,
    required this.controller,
    required this.validateData,
    super.key,
    this.onChanged,
    this.isNotEmail,
    this.showErrorText = true,
    this.obscureText = false,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.setVisibility,
  });
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validateData;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool? isNotEmail;
  final bool? isPassword;
  final Widget? prefixIcon;
  final VoidCallback? setVisibility;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final bool showErrorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: showErrorText ? null : 50,
      child: TextFormField(
        style: theme.textTheme.headlineSmall,
        cursorColor: appPrimaryColor,
        decoration: InputDecoration(
          filled: true,
          isDense: showErrorText ? true : null,
          fillColor: globalBackgroundColor, // Background color
          hintText: hint, // Placeholder text
          hintStyle: theme.textTheme.headlineSmall?.copyWith(
            color: descriptionGreyColor,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.grey,
            ), // Border color and width
          ),
          helperText: showErrorText ? ' ' : null,
          helperStyle: showErrorText
              ? theme.textTheme.headlineSmall
                  ?.copyWith(color: Colors.transparent, height: 0.5)
              : null,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: geryInputLoginBorderColor,
            ), // Border color and width
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: appPrimaryColor,
            ), // Focus border color and width
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: redErrorLoginInputColor,
            ), // Error border color and width
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: redErrorLoginInputColor,
            ), // Error border color and width
          ),
          errorStyle: theme.textTheme.headlineSmall?.copyWith(
            color: redErrorLoginInputColor,
            height: showErrorText ? 0.5 : 0,
          ),
          suffixIcon: (isPassword ?? false)
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                  color: theme.highlightColor,
                  onPressed: setVisibility,
                )
              : null,
          prefixIcon: prefixIcon,
        ),
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        validator: validateData,
        obscureText: obscureText,
        readOnly: readOnly,
        keyboardType: TextInputType.text,
        controller: controller,
        textCapitalization: (isNotEmail ?? false)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
      ),
    );
  }
}
