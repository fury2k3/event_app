import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.title,
    required this.location,
    required this.date,
    required this.tickets,
    required this.buttonLabel,
    super.key,
  });
  final String title;
  final String location;
  final String date;
  final String tickets;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.displayMedium,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(location)),
                Expanded(child: Text(date)),
                Expanded(child: Text(tickets)),
              ],
            ),
            const SizedBox(height: 24),
            GlobalButton(textContent: buttonLabel),
          ],
        ),
      ),
    );
  }
}
