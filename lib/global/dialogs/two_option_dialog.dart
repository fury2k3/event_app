import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTwoOptionDialog extends StatelessWidget {
  const AppTwoOptionDialog({
    required this.content,
    required this.confirmButtonText,
    required this.disableButtonText,
    super.key,
  });
  final String content;
  final String confirmButtonText;
  final String disableButtonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoAlertDialog(
      content: Text(
        content,
        style: theme.textTheme.headlineMedium,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: appPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(disableButtonText),
        ),
        CupertinoDialogAction(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: appPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
