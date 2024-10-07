import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/login/presentation/widgets/login_ui.dart';
import 'package:event_app/global/views/gradient_background.dart';
import 'package:event_app/global/views/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _autoValidate = false;

  void setPasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    emailController = TextEditingController(text: 'borhenn.fatnassi@gmail.com');
    passwordController = TextEditingController(text: 'azerty8188');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignInFailureState) {
            AppSnackBar.showSnackBar(context, state.message);
          } else if (state is AuthSignInSuccessState) {
            Navigator.of(context).pushReplacementNamed(homePage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: GradientBackground(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      LoginUi(
                        emailController: emailController,
                        passwordController: passwordController,
                        obscurePassword: _obscureText,
                        setVisibility: setPasswordVisibility,
                        autoValidate: _autoValidate,
                        formKey: formKey,
                        login: () => _login(context),
                        goToForgotPassword: () =>
                            _navigateToForgotPassword(context),
                        goToRegister: () => _navigateToRegister(context),
                        isLoading: state is AuthLoadingState,
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

  void _login(BuildContext context) {
    setState(() {
      _autoValidate = true;
    });
    if (formKey.currentState?.validate() ?? false) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      if (!authBloc.isClosed) {
        authBloc.add(
          AuthSignInEvent(
            email: emailController.text.trim(),
            password: passwordController.text,
          ),
        );
      }
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(registerPage);
  }

  void _navigateToForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(forgotPassword);
  }
}
