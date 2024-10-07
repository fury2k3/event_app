import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/network_image.dart';
import 'package:flutter/material.dart';

class EventDetailsHeader extends StatelessWidget {
  const EventDetailsHeader({
    required this.eventCover,
    required this.eventName,
    required this.eventLocation,
    required this.eventDate,
    required this.eventNbrTickets,
    super.key,
  });

  final String eventCover;
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventNbrTickets;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ImageNetworkWidget(
          imageUrl: eventCover,
          width: double.infinity,
        ),
        const SizedBox(height: 8),
        Text(
          eventName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            color: appPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                eventLocation,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            Flexible(
              child: Text(
                eventDate,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            Flexible(
              child: Text(
                eventNbrTickets,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
