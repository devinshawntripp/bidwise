import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class PlatformAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Authenticate to access BidWise',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
