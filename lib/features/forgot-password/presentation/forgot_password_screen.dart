import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/forgot-password/presentation/content/index.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/global/dialogs/dialogs.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late PageController pageController;

  late TextEditingController emailController;
  late TextEditingController resetCodeController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void setPasswordVisibility(int index) {
    if (index == 0) {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    } else {
      setState(() {
        _obscureConfirmPassword = !_obscureConfirmPassword;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    emailController = TextEditingController();
    resetCodeController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    pageController.dispose();
    emailController.dispose();
    resetCodeController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is ResetPasswordFailureState) {
            if (state.isInternetFailure) {
              final result = await AppDialog.showNoInternetDialog(
                context: context,
              );
              if (result && context.mounted) {
                final stepNumber = pageController.page;
                if (stepNumber == 0) {
                  sendResetCode(context);
                }
              }
            } else {
              AppSnackBar.showSnackBar(
                context,
                state.message,
              );
            }
          }
          if (state is ResetCodeSendState) {
            if (context.mounted) {
              AppSnackBar.showSuccessSnackBar(
                context,
                'A reset code has been sent to your email.',
              );
              await pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
          if (state is ResetCodeConfirmedState) {
            AppSnackBar.showSuccessSnackBar(
              context,
              'Reset code verified! You can now set a new password.',
            );
            await pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
          if (state is PasswordUpdatedState) {
            AppSnackBar.showSuccessSnackBar(
              context,
              'Your password has been successfully updated! You can now log in '
              'with your new password.',
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: appPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Align(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: appPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 440,
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ForgotPassword1Section(
                              emailController: emailController,
                              sendResetCode: () => sendResetCode(context),
                              isLoading: state is ResetCodeSendLoadingState,
                              firstFormKey: firstFormKey,
                            ),
                            ForgotPassword2Section(
                              resetCodeController: resetCodeController,
                              isLoading:
                                  state is ResetCodeConfirmedLoadingState,
                              confirmResetCode: () => confirmResetCode(context),
                            ),
                            ForgotPassword3Section(
                              newPasswordController: newPasswordController,
                              confirmNewPasswordController:
                                  confirmNewPasswordController,
                              isLoading: state is PasswordUpdatedLoadingState,
                              updatePassword: () => updatePassword(context),
                              formKey: secondFormKey,
                              showPassword: _obscurePassword,
                              showConfirmPassword: _obscureConfirmPassword,
                              setVisibility: setPasswordVisibility,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void sendResetCode(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (!authBloc.isClosed &&
        (firstFormKey.currentState?.validate() ?? false)) {
      authBloc.add(
        SendResetCodeEvent(
          email: emailController.text.trim(),
        ),
      );
    }
  }

  void confirmResetCode(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (!authBloc.isClosed) {
      authBloc.add(
        ConfirmResetCodeEvent(
          email: emailController.text,
          resetCode: resetCodeController.text.trim(),
        ),
      );
    }
  }

  void updatePassword(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (!authBloc.isClosed &&
        (secondFormKey.currentState?.validate() ?? false)) {
      authBloc.add(
        UpdatePasswordEvent(
          email: emailController.text,
          newPassword: newPasswordController.text,
        ),
      );
    }
  }
}
