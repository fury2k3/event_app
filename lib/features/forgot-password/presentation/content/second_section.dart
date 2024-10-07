import 'package:event_app/features/forgot-password/presentation/widgets/full_dots_indicators.dart';
import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/validator/validation.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:event_app/global/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassword2Section extends StatelessWidget {
  const ForgotPassword2Section({
    required this.resetCodeController,
    required this.isLoading,
    required this.confirmResetCode,
    super.key,
  });

  final bool isLoading;

  final TextEditingController resetCodeController;
  final void Function() confirmResetCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FullDotsIndicators(index: 1),
          const SizedBox(height: 30),
          Text(
            'Type in the verification code sent',
            style: theme.textTheme.displaySmall,
          ),
          const SizedBox(height: 30),
          LoginTextFormBloc(
            hint: '6 Digit Code',
            controller: resetCodeController,
            title: 'Verification Code',
            validateData: Validation.validateEmail,
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 45),
          if (isLoading)
            const LoadingScreen()
          else
            GlobalButton(
              textContent: 'Continue',
              onPressed: confirmResetCode.call,
            ),
        ],
      ),
    );
  }
}
