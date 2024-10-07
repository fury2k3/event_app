import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/network_image.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    required this.eventModel,
    super.key,
    this.buyTicket,
  });

  final EventModel eventModel;
  final void Function()? buyTicket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ImageNetworkWidget(
                imageUrl: eventModel.eventCover ?? '',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 7),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  eventModel.name ?? '',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(eventModel.location ?? ''),
                ),
                Expanded(
                  child: Text(eventModel.date ?? ''),
                ),
                Expanded(
                  child: Text(
                    '${eventModel.availableTickets} Tickets',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    '${eventModel.price} $appCurrency',
                    style: theme.textTheme.displayMedium
                        ?.copyWith(color: const Color.fromARGB(255, 11, 49, 12)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GlobalButton(
                      onPressed: buyTicket,
                      textContent: 'Buy Ticket',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
