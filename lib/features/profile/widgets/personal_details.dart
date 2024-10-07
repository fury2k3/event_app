import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/views/widgets/common_date_picker/common_date_picker_bloc.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.birthDateController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthDateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginTextFormBloc(
          hint: 'Full Name',
          controller: fullNameController,
          title: 'Full Name',
          readOnly: true,
        ),
        LoginTextFormBloc(
          hint: 'email',
          controller: emailController,
          title: 'Email',
          readOnly: true,
        ),
        CommonDatePickerBloc(
          hint: '../../..',
          controller: birthDateController,
          title: 'Birthdate',
        ),
        LoginTextFormBloc(
          hint: 'Phone number',
          controller: phoneNumberController,
          title: 'Phone Number',
          readOnly: true,
        ),
      ],
    );
  }
}
