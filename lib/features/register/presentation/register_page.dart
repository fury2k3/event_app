import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/register/presentation/widgets/register_ui.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/views/gradient_background.dart';
import 'package:event_app/global/views/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late PageController _pageController;
  late TextEditingController _userNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _autoValidateFirstForm = false;
  bool _autoValidateSecondForm = false;

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

  void next() {
    setState(() {
      _autoValidateFirstForm = true;
    });
  }

  void confirmButton(BuildContext context) {
    print('confirm button pressed');
    setState(() {
      _autoValidateSecondForm = true;
    });
    BlocProvider.of<AuthBloc>(context).add(
      AuthSignUpEvent(
        email: _emailController.text.toLowerCase().trim(),
        password: _passwordController.text,
        username: _userNameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      ),
    );
  }

  @override
  void initState() {
    _pageController = PageController();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignUpFailureState) {
            AppSnackBar.showSnackBar(context, state.message);
          } else if (state is AuthSignUpSuccessState) {
            AppSnackBar.showSuccessSnackBar(
              context,
              'Your account has been created successfully ',
            );
            Navigator.of(context).pushReplacementNamed(loginPage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: GradientBackground(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
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
                      const SizedBox(height: 55),
                      Expanded(
                        child: RegisterUi(
                          pageController: _pageController,
                          userNameController: _userNameController,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          emailController: _emailController,
                          nextButton: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                            );
                          },
                          firstFormKey: firstFormKey,
                          firstAutoValidate: _autoValidateFirstForm,
                          passwordController: _passwordController,
                          showPassword: _obscurePassword,
                          confirmPasswordController: _confirmPasswordController,
                          showConfirmPassword: _obscureConfirmPassword,
                          confirmButton: () => confirmButton(context),
                          secondFormKey: secondFormKey,
                          autoValidateSecondForm: _autoValidateSecondForm,
                          setVisibility: setPasswordVisibility,
                          isLoading: state is AuthLoadingState,
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
}
