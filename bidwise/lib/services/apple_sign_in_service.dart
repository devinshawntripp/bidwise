import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {
  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Use credential to authenticate with your backend
  }
}
