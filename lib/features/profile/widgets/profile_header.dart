import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:event_app/global/utils/media_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
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
                'Profile',
                style: theme.textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(supportPage);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(MediaRes.supportIcon),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.save,
                        color: appPrimaryColor,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 1,
          color: geryHintLoginInputColor,
        ),
        Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage(profileAvatar),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: updateProfileAvatar,
                      child: const Icon(Icons.photo_camera_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(email),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
