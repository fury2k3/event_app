import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoOptionDialogWithIcon extends StatelessWidget {
  const TwoOptionDialogWithIcon({
    required this.text,
    required this.confirmButtonText,
    required this.disableButtonText,
    required this.title,
    required this.icon,
    super.key,
  });
  final String text;
  final String confirmButtonText;
  final String disableButtonText;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Icon(
            icon,
            color: blackAppBarTextColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: theme.textTheme.displayMedium,
          ),
        ],
      ),
      content: Text(
        text,
        style: theme.textTheme.headlineMedium,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: blueTextColor,
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(disableButtonText),
        ),
        CupertinoDialogAction(
          textStyle: theme.textTheme.displaySmall?.copyWith(
            color: blueTextColor,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
