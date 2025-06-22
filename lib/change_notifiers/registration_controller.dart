import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_note/Services/auth_service.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/core/dialog.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullName = '';
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get fullName => _fullName.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword({
    required BuildContext context,
  }) async {
    isLoading = true;
    try {
      if (_isRegisterMode) {
        AuthService.register(
          fullName: fullName,
          email: email,
          password: password,
        );

        if (!context.mounted) return;
        showMessageDialog(
          context: context,
          message:
              'A verification email was sent to the provided email address. Please confirm your email to proceed to the app.',
        );
        //reload user
        while (!AuthService.isEmailVerified) {
          await Future.delayed(
            const Duration(seconds: 5),
            () => AuthService.user?.reload(),
          );
        }
      } else {
        
        // Sign in user
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An unknown error occured',
      );
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(context: context, message: 'An unknown error occured');
    } finally {
      isLoading = false;
    }
  }
}
