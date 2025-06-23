import 'package:flutter/material.dart';
import 'package:project_note/change_notifiers/registration_controller.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/core/validator.dart';
import 'package:project_note/widgets/note_back_button.dart';
import 'package:project_note/widgets/note_button.dart';
import 'package:project_note/widgets/note_form_field.dart';
import 'package:provider/provider.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  late final TextEditingController emailController;

  GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NoteBackButton(),
        title: Text('Recover Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Dont worry!', textAlign: TextAlign.center),
            SizedBox(height: 24),
            NoteFormField(
              key: emailKey,
              controller: emailController,
              fillColor: white,
              filled: true,
              labelText: 'Email',
              validator: Validator.emailValidator,

            ),
            SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isLoading,
                builder: (_, isLoading, __) => NoteButton(
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: white,),
                        )
                      : Text('Send me a recovery link!'),
                  onPressed: isLoading ? null : () {
                    if (emailKey.currentState?.validate() ?? false) {
                      context.read<RegistrationController>().resetPassword(
                        context: context,
                        email: emailController.text.trim(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
