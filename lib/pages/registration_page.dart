import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/widgets/note_button.dart';
import 'package:project_note/widgets/note_form_field.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';

import '../core/constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'In order to sync your notes to cloud, you have to register/sign in to the app',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  NoteFormField(
                    labelText: 'Full name',
                    fillColor: white,
                    filled: true,
                  ),
                  SizedBox(height: 8),
                  NoteFormField(
                    labelText: 'Email',
                    fillColor: white,
                    filled: true,
                  ),
                  SizedBox(height: 8),
                  NoteFormField(
                    labelText: 'Password',
                    fillColor: white,
                    filled: true,
                    suffixIcon: Icon(FontAwesomeIcons.eye),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: NoteButton(
                      label: 'Create My Account',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Or register with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: NoteIconButtonOutlined(
                          icon: FontAwesomeIcons.google,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: NoteIconButtonOutlined(
                          icon: FontAwesomeIcons.facebook,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: gray700),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
