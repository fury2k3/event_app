import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_title.dart';
import 'package:event_app/global/views/widgets/common_date_picker/common_date_picker.dart';
import 'package:flutter/material.dart';

class CommonDatePickerBloc extends StatelessWidget {
  const CommonDatePickerBloc({
    required this.hint,
    required this.controller,
    required this.title,
    super.key,
    this.validateData,
    this.countryCode,
    this.duration,
  });
  final String hint;
  final TextEditingController controller;
  final String title;
  final FormFieldValidator<String>? validateData;
  final String? countryCode;
  final String? duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTextFormTitle(title: title),
          CommonDatePicker(
            hint: hint,
            controller: controller,
            validateData: validateData,
          ),
        ],
      ),
    );
  }
}
