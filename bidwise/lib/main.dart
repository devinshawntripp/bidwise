import 'package:flutter/material.dart';
import 'package:bidwise/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BidWise',
      theme: ThemeData(
        // Define the light theme settings here.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Use your preferred seed color for light theme
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // Define the dark theme settings here.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Use your preferred seed color for dark theme
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark, // Use system theme mode by default
      home: const HomePage(title: 'BidWise'),
    );
  }
}

