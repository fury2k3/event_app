import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    this.logout,
  });

  final void Function()? logout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: logout,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: redErrorLoginInputColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.logout,
              color: redErrorLoginInputColor,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log out',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: redErrorLoginInputColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Log out of account',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: redErrorLoginInputColor,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
