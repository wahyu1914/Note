import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/widgets/note_button.dart';
import 'package:project_note/widgets/note_form_field.dart';
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register'),
                SizedBox(height: 16),
                Text(
                  'In order to sync your notes to cloud, you have to register/sign in to the app',
                ),
                SizedBox(height: 48),
                NoteFormField(hintText: 'Full name'),
                SizedBox(height: 8),
                NoteFormField(hintText: 'Email'),
                SizedBox(height: 8),
                NoteFormField(hintText: 'Password'),
                NoteButton(label: 'Create My Account', onPressed: () {}),
                SizedBox(height: 32),
                Row(
                  children: [
                    Divider(),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Or register with'),
                    ),
                    Divider(),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    NoteIconButtonOutlined(
                      icon: FontAwesomeIcons.google,
                      onPressed: () {},
                    ),
                    SizedBox(width: 16),
                    NoteIconButtonOutlined(
                      icon: FontAwesomeIcons.facebook,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [TextSpan(text: 'Sign in')],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
