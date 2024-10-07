import 'package:event_app/core/routes/app_routes.dart';
import 'package:event_app/core/services/injection_container.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/profile/widgets/logout_bottom_sheet.dart';
import 'package:event_app/features/profile/widgets/logout_button.dart';
import 'package:event_app/features/profile/widgets/personal_details.dart';
import 'package:event_app/features/profile/widgets/profile_header.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController birthDateController;

  @override
  void initState() {
    fullNameController = TextEditingController(text: fullName);
    emailController = TextEditingController(text: email);
    phoneNumberController = TextEditingController(text: phoneNumber);
    birthDateController = TextEditingController(text: birthDate);
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  void logout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LogoutUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            Navigator.of(context).pushReplacementNamed(loginPage);
          }
        },
        builder: (authContext, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const ProfileHeader(),
                      const SizedBox(height: 30),
                      PersonalDetails(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        phoneNumberController: phoneNumberController,
                        birthDateController: birthDateController,
                      ),
                      LogoutButton(
                        logout: () async {
                          await showModalBottomSheet<void>(
                            context: context,
                            builder: (context) {
                              return LogoutBottomSheet(
                                logout: () => logout(authContext),
                              );
                            },
                          );
                        },
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
