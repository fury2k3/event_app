import 'dart:io';

import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/event/domain/usecases/create_event_usecase.dart';
import 'package:event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/media_res.dart';
import 'package:event_app/global/validator/validation.dart';
import 'package:event_app/global/views/widgets/app_snackbar.dart';
import 'package:event_app/global/views/widgets/common_date_picker/common_date_picker_bloc.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({super.key});

  @override
  State<AddNewEventPage> createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  late TextEditingController eventNameController;
  late TextEditingController eventDateController;
  late TextEditingController eventLocationController;
  late TextEditingController eventPriceController;
  late TextEditingController eventAvailableTicketController;
  late TextEditingController eventDescriptionController;

  final formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  File? _image;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _createEvent({
    required BuildContext context,
  }) async {
    if (!autoValidate) {
      setState(() {
        autoValidate = true;
      });
    }
    if (formKey.currentState?.validate() ?? false) {
      if (_image == null) {
        AppSnackBar.showSnackBar(
          context,
          'Please upload an image cover for the event.',
        );
      } else {
        BlocProvider.of<EventBloc>(context).add(
          CreateEvent(
            eventParams: CreateEventParams(
              eventName: eventNameController.text.trim(),
              eventDate: eventDateController.text,
              eventLocation: eventLocationController.text.trim(),
              eventPrice: eventPriceController.text.trim(),
              eventAvailableTicket: eventAvailableTicketController.text,
              eventDescription: eventDescriptionController.text,
              eventImage: _image,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    eventNameController = TextEditingController(text: 'event name');
    eventDateController = TextEditingController(text: '12.09.2024');
    eventLocationController = TextEditingController(text: 'Tunis');
    eventPriceController = TextEditingController(text: '120');
    eventAvailableTicketController = TextEditingController(text: '50');
    eventDescriptionController =
        TextEditingController(text: 'this is an event description');
    super.initState();
  }

  @override
  void dispose() {
    eventNameController.dispose();
    eventDateController.dispose();
    eventLocationController.dispose();
    eventPriceController.dispose();
    eventAvailableTicketController.dispose();
    eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<EventBloc>(
      create: (context) => sl<EventBloc>(),
      child: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventCreatedSuccessfully) {
            eventNameController.clear();
            eventDateController.clear();
            eventLocationController.clear();
            eventPriceController.clear();
            eventAvailableTicketController.clear();
            eventDescriptionController.clear();

            _image = null;
            autoValidate = false;
            AppSnackBar.showSuccessSnackBar(
              context,
              'Event created successfully !',
            );
          } else if (state is EventFailure) {
            AppSnackBar.showSnackBar(context, state.message);
          }
        },
        builder: (eventContext, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                'Add New Event',
                style: theme.textTheme.displaySmall,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Form(
                    autovalidateMode: autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginTextFormBloc(
                          hint: 'e.g, Coachella',
                          controller: eventNameController,
                          title: 'Event Name',
                          validateData: Validation.validateText,
                        ),
                        CommonDatePickerBloc(
                          hint: 'Select Event Date',
                          controller: eventDateController,
                          title: 'Date',
                          validateData: Validation.validateText,
                        ),
                        LoginTextFormBloc(
                          hint: 'Select event location',
                          controller: eventLocationController,
                          title: 'Event Location',
                          suffixIcon: const Icon(
                            Icons.location_on_outlined,
                            size: 28,
                          ),
                          validateData: Validation.validateText,
                        ),
                        LoginTextFormBloc(
                          hint: 'Enter Price per ticket',
                          controller: eventPriceController,
                          title: 'Event Price',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'TND',
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: descriptionGreyColor,
                              ),
                            ),
                          ),
                          validateData: Validation.validateText,
                        ),
                        LoginTextFormBloc(
                          hint: 'Number of tickets available',
                          controller: eventAvailableTicketController,
                          title: 'Available Tickets',
                          validateData: Validation.validateText,
                        ),
                        LoginTextFormBloc(
                          hint: 'Event description',
                          controller: eventDescriptionController,
                          title: 'Description',
                          validateData: Validation.validateText,
                        ),
                        Text(
                          'Event Cover',
                          style: theme.textTheme.displaySmall,
                        ),
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            height: 160,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: descriptionGreyColor.withOpacity(.5),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: Colors.grey.withOpacity(.14),
                            ),
                            child: Center(
                              child: _image == null
                                  ? SvgPicture.asset(
                                      MediaRes.uploadIcon,
                                      height: 42,
                                      color: appPrimaryColor,
                                    )
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ),
                        if (state is EventLoading)
                          const LoadingScreen()
                        else
                          GlobalButton(
                            textContent: 'Create Event',
                            onPressed: () {
                              _createEvent(context: eventContext);
                            },
                          ),
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
}
