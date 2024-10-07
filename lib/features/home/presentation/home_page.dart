import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:event_app/features/home/presentation/widgets/event_list_view.dart';
import 'package:event_app/features/home_tab/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fakeEvent = [EventModel()];
  List<EventModel> eventList = <EventModel>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<EventBloc>(
      create: (context) => sl<EventBloc>()..add(GetEventList()),
      child: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventListLoaded) {
            eventList = state.eventsList;
          } else if (state is EventFailure) {}
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Skeletonizer(
                    enabled: state is EventLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeHeader(),
                        eventHeadline(theme, 'Latest Events'),
                        EventListView(
                          eventList:
                              state is EventLoading ? fakeEvent : eventList,
                        ),
                        const SizedBox(height: 20),
                        eventHeadline(theme, 'Trending Events'),
                        EventListView(eventList: eventList),
                        const SizedBox(height: 20),
                        eventHeadline(theme, 'Events in Tunis'),
                        EventListView(eventList: eventList),
                        const SizedBox(height: 20),
                        eventHeadline(theme, 'Events in Sousse'),
                        EventListView(eventList: eventList),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget eventHeadline(ThemeData themeData, String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: themeData.textTheme.displayMedium,
      ),
    );
  }
}
