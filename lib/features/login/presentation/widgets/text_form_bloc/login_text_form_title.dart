import 'package:flutter/material.dart';

class LoginTextFormTitle extends StatelessWidget {
  const LoginTextFormTitle({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.displaySmall,
      ),
    );
  }
}
