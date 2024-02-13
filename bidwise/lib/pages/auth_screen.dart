import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bidwise/services/auth_service.dart';
import 'package:bidwise/services/platform_auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PlatformAuthService _platformAuthService = PlatformAuthService();

  @override
  void initState() {
    super.initState();
    _attemptAutoLogin();
  }

  void _attemptAutoLogin() async {
    bool success = await _platformAuthService.authenticate();
    if (success) {
      // Navigate to home or next screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _platformAuthService.authenticate(),
              child: Text('Login with FaceID / Fingerprint'),
            ),
            // Additional buttons for other auth methods can be added here
          ],
        ),
      ),
    );
  }
}
