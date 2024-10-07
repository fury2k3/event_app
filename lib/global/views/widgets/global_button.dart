import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    required this.textContent,
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(backgroundColor ?? appPrimaryColor),
        ),
        onPressed: onPressed,
        child: Text(
          textContent,
          style: theme.textTheme.displaySmall?.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
