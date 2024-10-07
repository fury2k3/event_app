import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.saveChanges,
    this.updateProfileAvatar,
  });

  final void Function()? saveChanges;
  final void Function()? updateProfileAvatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'EVENTIFY',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.notifications,
                    color: appPrimaryColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 1,
          color: geryHintLoginInputColor,
        ),
      ],
    );
  }
}
