import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Obtain the auth token from the account
        // You can then use this token to authenticate with your backend
      }
    } catch (error) {
      print(error);
    }
  }
}