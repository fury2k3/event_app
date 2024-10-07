import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/features/purchases/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';

class PurchaseTab extends StatelessWidget {
  const PurchaseTab({
    required this.isComingSoon,
    required this.listEvents,
    super.key,
  });
  final List<PurchaseModel> listEvents;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: listEvents
          .map(
            (purchase) => EventCard(
              title: purchase.event?.name ?? '',
              location: purchase.event?.location ?? '',
              date: purchase.event?.date ?? '',
              tickets: '${purchase.event?.availableTickets} Tickets',
              buttonLabel: isComingSoon ? 'Download Ticket' : 'Review Event',
            ),
          )
          .toList(),
    );
  }
}
