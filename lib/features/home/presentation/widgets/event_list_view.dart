import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/home/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  const EventListView({
    required this.eventList,
    super.key,
  });

  final List<EventModel> eventList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return EventCard(
            eventModel: eventList[index],
            buyTicket: () {
              Navigator.pushNamed(
                context,
                eventPage,
                arguments: eventList[index],
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
        itemCount: eventList.length,
      ),
    );
  }
}
