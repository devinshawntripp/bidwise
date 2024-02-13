import 'package:flutter/material.dart';


//create a home page that has a sign up button and an auto login that happens on iphon when you open the app
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});


  final String title;

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to BidWise'),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              'Welcome to BidWise',
            )
          ],
        ),
      )
    );
  }
}

