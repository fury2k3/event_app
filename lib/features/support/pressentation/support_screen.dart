import 'package:event_app/features/login/presentation/widgets/text_form_bloc/login_text_form_bloc.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/utils/media_res.dart';
import 'package:event_app/global/views/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController messageController;

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: appPrimaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(MediaRes.supportIcon),
                              const SizedBox(width: 10),
                              const Text(
                                'Contact Support',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    RichText(
                      text: TextSpan(
                        text:
                            'Need help with anything? Contact support and our '
                            'team will get back to you within 48 hours.\n',
                        style: theme.textTheme.headlineMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: '(contacteventify@gmail.com)',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: blueTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    LoginTextFormBloc(
                      hint: 'Your full name',
                      controller: fullNameController,
                      title: 'Full Name',
                    ),
                    LoginTextFormBloc(
                      hint: 'Your email address',
                      controller: emailController,
                      title: 'Email',
                    ),
                    LoginTextFormBloc(
                      hint: 'How can we help you?',
                      controller: messageController,
                      title: 'Message',
                      maxLine: 6,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GlobalButton(
                textContent: 'Send Message',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
