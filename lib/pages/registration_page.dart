import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/change_notifiers/registration_controller.dart';
import 'package:project_note/core/validator.dart';
import 'package:project_note/widgets/note_button.dart';
import 'package:project_note/widgets/note_form_field.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController registrationController;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    registrationController = context.read();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    formKey = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isRegisterMode,
                builder: (_, isRegisterMode, __) => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isRegisterMode ? 'Register' : 'Sign In',
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
                      if (isRegisterMode) ...[
                        NoteFormField(
                          controller: nameController,
                          labelText: 'Full name',
                          fillColor: white,
                          filled: true,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: Validator.nameValidator,
                        ),
                        SizedBox(height: 8),
                      ],
                      NoteFormField(
                        controller: emailController,
                        labelText: 'Email address',
                        fillColor: white,
                        filled: true,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validator.emailValidator,
                      ),
                      SizedBox(height: 8),
                      Selector<RegistrationController, bool>(
                        selector: (_, controller) =>
                            controller.isPasswordHidden,

                        builder: (_, isPasswordHidden, __) => NoteFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          fillColor: white,
                          filled: true,
                          obscureText: isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              registrationController.isPasswordHidden =
                                  !isPasswordHidden;
                            },
                            child: Icon(
                              isPasswordHidden
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                            ),
                          ),
                          validator: Validator.passwordValidator,
                        ),
                      ),
                      SizedBox(height: 12),
                      if (!isRegisterMode) ...[
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                      SizedBox(
                        height: 48,
                        child: NoteButton(
                          label: isRegisterMode
                              ? 'Create My Account'
                              : 'Log me in',
                          onPressed: () {
                            formKey.currentState?.validate();
                          },
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              isRegisterMode
                                  ? 'Or register with'
                                  : 'Or sign in with',
                            ),
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
                          text: isRegisterMode
                              ? 'Already have an account? '
                              : 'Dont have an account',
                          style: TextStyle(color: gray700),
                          children: [
                            TextSpan(
                              text: isRegisterMode ? 'Sign in' : 'Register',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  registrationController.isRegisterMode =
                                      !isRegisterMode;
                                },
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
        ),
      ),
    );
  }
}
