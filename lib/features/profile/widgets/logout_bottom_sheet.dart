import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:flutter/material.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({
    required this.logout,
    super.key,
  });
  final void Function() logout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Text(
              'Logout',
              style: theme.textTheme.displayLarge?.copyWith(
                color: redErrorLoginInputColor,
              ),
            ),
            const Divider(height: 20),
            Text(
              'Are you sure you want to logout ?',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GlobalButton(
                    textContent: 'Cancel',
                    textColor: appPrimaryColor.withGreen(44),
                    backgroundColor: appPrimaryColor.withOpacity(.1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GlobalButton(
                    textContent: 'Yes, Logout',
                    onPressed: logout,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
