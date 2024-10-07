import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppOneOptionDialog extends StatelessWidget {
  const AppOneOptionDialog({
    required this.content,
    required this.confirmButtonText,
    required this.title,
    super.key,
  });
  final String content;
  final String title;
  final String confirmButtonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoAlertDialog(
      content: Text(
        content,
        style: theme.textTheme.headlineMedium,
      ),
      title: Text(
        title,
        style: theme.textTheme.displayLarge,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: appPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
