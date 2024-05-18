import 'package:bidwise/Components/drawer_menu.dart';
import 'package:bidwise/Components/nav/nav_menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String title = 'Profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavMenu(
        title: widget.title,
        scaffoldKey: _scaffoldKey,
        openDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50, // Adjust the size as needed
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Placeholder for user image
            ),
            const SizedBox(height: 20),
            const Text('John Doe',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('john.doe@example.com', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
