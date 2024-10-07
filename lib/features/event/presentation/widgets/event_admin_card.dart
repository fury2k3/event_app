import 'package:event_app/features/event/presentation/enum/event_action.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

class EventAdminCard extends StatelessWidget {
  const EventAdminCard({
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.displayMedium,
                  ),
                ),
                PopupMenuButton<EventAction>(
                  icon: const Icon(Icons.more_vert),
                  color: globalBackgroundColor,
                  onSelected: (action) {
                    switch (action) {
                      case EventAction.edit:
                        // Handle edit action
                        break;
                      case EventAction.delete:
                        // Handle delete action
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return EventAction.values.map((action) {
                      return PopupMenuItem<EventAction>(
                        value: action,
                        height: 40,
                        child: Row(
                          children: [
                            Icon(getActionIcon(action)),
                            const SizedBox(width: 8),
                            Text(getActionLabel(action)),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
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
          ],
        ),
      ),
    );
  }
}
