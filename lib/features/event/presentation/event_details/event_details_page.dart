import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/domain/usecases/make_event_purchase_usecase.dart';
import 'package:event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:event_app/features/event/presentation/event_details/widgets/event_details_header.dart';
import 'package:event_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:event_app/global/utils/media_res.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:event_app/global/views/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    required this.eventModel,
    super.key,
  });

  final EventModel eventModel;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int _quantity = 1;
  late double _singlePrice;

  late double _totalPrice = 10.46;

  @override
  void initState() {
    _singlePrice = widget.eventModel.price ?? 0.0;
    _totalPrice = _singlePrice * _quantity;
    super.initState();
  }

  void incrementQuantity() {
    if (_quantity < (widget.eventModel.availableTickets ?? 0)) {
      _quantity++;
      _totalPrice = _singlePrice * _quantity;

      setState(() {});
    }
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      _totalPrice = _singlePrice * _quantity;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentBloc>(
          create: (context) => sl<PaymentBloc>(),
        ),
        BlocProvider(
          create: (context1) => sl<EventBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is StripePaymentSuccess) {
                makePurchase(context);
              } else if (state is StripePaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<EventBloc, EventState>(
            listener: (context, state) {
              if (state is EventPurchasedSuccessfully) {
                // Handle event purchase success if needed
                Navigator.pushNamed(context, paymentSuccessPage);
              }
            },
          ),
        ],
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.eventModel.name ?? '',
                  style: theme.textTheme.displaySmall,
                ),
                centerTitle: true,
              ),
              body: state is EventLoading
                  ? const LoadingScreen()
                  : SafeArea(
                      child: Stack(
                        children: [
                          ListView(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            children: [
                              EventDetailsHeader(
                                eventCover: widget.eventModel.eventCover ?? '',
                                eventName: widget.eventModel.name ?? '',
                                eventLocation: widget.eventModel.location ?? '',
                                eventDate: widget.eventModel.date ?? '',
                                eventNbrTickets:
                                    '${widget.eventModel.availableTickets} '
                                    'Tickets',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                            MediaRes.personImage,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Navorri Events',
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (index) => Icon(
                                                  index != 4
                                                      ? Icons.star
                                                      : Icons.star_half,
                                                  color: Colors.amber,
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(.25),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' WhatsApp ',
                                          style: theme.textTheme.displaySmall
                                              ?.copyWith(
                                            color: Colors.green,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.call_rounded,
                                          color: Colors.green,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Description',
                                style: theme.textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: appPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.eventModel.description ?? '',
                              ),
                            ],
                          ),
                          BlocBuilder<PaymentBloc, PaymentState>(
                            builder: (context, state) {
                              return Positioned(
                                bottom: 12,
                                left: 20,
                                right: 20,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Quantity',
                                                style:
                                                    theme.textTheme.labelSmall,
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                height: 50,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors
                                                      .systemGrey5,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: decrementQuantity,
                                                      child: SvgPicture.asset(
                                                        MediaRes.minusIcon,
                                                        height: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      '$_quantity',
                                                      style: theme.textTheme
                                                          .displayMedium,
                                                    ),
                                                    InkWell(
                                                      onTap: incrementQuantity,
                                                      child: SvgPicture.asset(
                                                        MediaRes.plusIcon,
                                                        height: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            '${_totalPrice.toStringAsFixed(2)} '
                                            '$appCurrency',
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.labelMedium
                                                ?.copyWith(
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    if (state is PaymentLoading)
                                      const LoadingScreen()
                                    else
                                      GlobalButton(
                                        textContent: 'Buy Now',
                                        onPressed: () =>
                                            proceedToPayment(context),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  void proceedToPayment(BuildContext context) {
    BlocProvider.of<PaymentBloc>(context).add(
      PayWithStripeEvent(
        amount: (_totalPrice * 100).toInt().toString(),
        currency: 'EUR',
        customerId: 'bornii',
      ),
    );
  }

  void makePurchase(BuildContext context) {
    BlocProvider.of<EventBloc>(context).add(
      PurchaseEvent(
        params: MakeEventPurchaseParams(
          eventId: widget.eventModel.id ?? '',
          nbrTickets: _quantity,
        ),
      ),
    );
  }
}
