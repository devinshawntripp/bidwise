import 'package:bidwise/models/app_user.dart';
import 'package:bidwise/providers/user_provider.dart';
import 'package:bidwise/services/Users/app_user_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bidwise/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      getUserWithRoles(firebaseUser).then((userWithRoles) {
        if (userWithRoles != null) {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(userWithRoles);
          Navigator.pushNamed(context, '/home');
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  var user = await _authService.signInWithGoogle();
                  print("I am here");
                  if (user != null) {
                    var userWithRoles = await getUserWithRoles(user);
                    print("USER WITH ROLES: $userWithRoles");

                    if (userWithRoles != null) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setUser(userWithRoles);
                      Navigator.pushNamed(context, '/home');
                    } else {
                      // Optional: Create user with default roles if not set
                      // await createUserWithRoles(user, ['user']);
                      Navigator.pushNamed(context, '/setup');
                    }
                  }
                } catch (e) {
                  print("Error during authentication: $e");
                }
              },
              child: Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: () => _authService.signInWithApple(),
              child: Text('Sign in with Apple'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool success = await _authService.authenticateBiometric();
                if (success) {
                  // Handle successful biometric authentication
                  // This might involve navigating to the home screen or showing a success message
                } else {
                  // Handle authentication failure
                }
              },
              child: Text('Login with FaceID / Fingerprint'),
            ),
            // You can add more sign-in methods here
          ],
        ),
      ),
    );
  }
}
