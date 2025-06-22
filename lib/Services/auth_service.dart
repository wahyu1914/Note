import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Stream<User?> get userStream => _auth.userChanges();

  static bool get isEmailVerified => user?.emailVerified ?? false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) {
            credential.user?.sendEmailVerification();
            credential.user?.updateDisplayName(fullName);
          });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() => _auth.signOut();
}
