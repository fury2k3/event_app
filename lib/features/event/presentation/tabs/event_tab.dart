import 'package:event_app/features/event/presentation/widgets/event_admin_card.dart';
import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  const EventTab({
    required this.isComingSoon,
    super.key,
  });
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        EventAdminCard(
          title: 'Neon Lights',
          location: 'Tunis, Tunisia',
          date: '30 Aug, 2024',
          tickets: '150 Tickets',
          buttonLabel: isComingSoon ? 'Download Ticket' : 'Review Event',
        ),
        // Add more EventCards here as needed
      ],
    );
  }
}
