import 'package:bidwise/Components/drawer_menu.dart';
import 'package:bidwise/Components/nav/nav_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = "BidWise";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: NavMenu(
        title: widget.title,
        scaffoldKey: _scaffoldKey,
        openDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: DrawerMenu(), // Use the DrawerMenu widget
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
            ),
          ],
        ),
      ),
    );
  }
}
