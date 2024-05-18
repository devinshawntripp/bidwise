import 'package:bidwise/pages/project/projects_screen.dart';
import 'package:bidwise/pages/setup/setup_page_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bidwise/pages/home_page.dart';
import 'package:bidwise/pages/profile_screen.dart';
import 'package:bidwise/pages/auth_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String auth = '/auth';
  static const String profile = '/profile';
  static const String setup = '/setup';
  static const String projects = '/projects';
  static const String addProject = '/add/project';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    User? user = FirebaseAuth.instance.currentUser;

    switch (settings.name) {
      case home:
        // Protect the home route
        return user != null
            ? MaterialPageRoute(builder: (context) => const HomePage())
            : _unauthorizedRoute();
      case auth:
        return MaterialPageRoute(builder: (context) => AuthScreen());
      case setup:
        // Protect the setup route
        return user != null
            ? MaterialPageRoute(
                builder: (context) => SetupPage(firebaseUser: user))
            : _unauthorizedRoute();
      case projects:
        // Protect the setup route
        return user != null
            ? MaterialPageRoute(builder: (context) => ProjectsScreen())
            : _unauthorizedRoute();
      case addProject:
        // Protect the setup route
        return user != null
            ? MaterialPageRoute(builder: (context) => ProjectsScreen())
            : _unauthorizedRoute();
      case profile:
        // Protect the profile route
        return user != null
            ? MaterialPageRoute(builder: (context) => const ProfileScreen())
            : _unauthorizedRoute();
      default:
        // Handling undefined route
        return MaterialPageRoute(
            builder: (context) =>
                AuthScreen()); // Default to auth screen if route is not defined
    }
  }

  static Route<dynamic> _unauthorizedRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Unauthorized Access", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/auth'),
                child: const Text("Go to Login"),
              )
            ],
          ),
        ),
      );
    });
  }
}
