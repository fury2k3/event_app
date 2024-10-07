import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:event_app/features/purchases/presentation/tabs/purchase_tab.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  List<PurchaseModel> allHistory = <PurchaseModel>[];
  List<PurchaseModel> historyEvents = <PurchaseModel>[];
  List<PurchaseModel> upComingEvents = <PurchaseModel>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<EventBloc>(
      create: (context) => sl<EventBloc>()..add(GetEventHistoryList()),
      child: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventHistoryListLoaded) {
            final now = DateTime.now();
            allHistory = state.purchaseList;

            for (final purchase in allHistory) {
              if (purchase.event!.getDate().isBefore(now)) {
                historyEvents.add(purchase);
              } else {
                upComingEvents.add(purchase);
              }
            }
          }
        },
        builder: (context, state) {
          return state is EventLoading
              ? const LoadingScreen()
              : DefaultTabController(
                  length: 2,
                  child: SafeArea(
                    child: Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        title: Text(
                          'My Purchases',
                          style: theme.textTheme.displaySmall,
                        ),
                        centerTitle: true,
                      ),
                      body: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: borderColor),
                              ),
                              child: TabBar(
                                tabs: const [
                                  Tab(text: 'Purchases'),
                                  Tab(text: 'History'),
                                ],
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                indicator: BoxDecoration(
                                  color: appPrimaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                labelStyle: theme.textTheme.displaySmall,
                                unselectedLabelStyle:
                                    theme.textTheme.displaySmall,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                PurchaseTab(
                                  isComingSoon: true,
                                  listEvents: upComingEvents,
                                ),
                                PurchaseTab(
                                  isComingSoon: false,
                                  listEvents: historyEvents,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
