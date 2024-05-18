import 'package:bidwise/models/app_user.dart';
import 'package:bidwise/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppUser? user = Provider.of<UserProvider>(context, listen: false).user;
    print("USER: $user");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                if (user !=
                    null) // Ensure user is not null before accessing rating
                  RatingBarIndicator(
                    rating: user.rating.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
              // Navigate to the Home screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to the Profile screen
              Navigator.popAndPushNamed(context, '/profile');
            },
          ),
          if (user != null && !user.roles.contains('Contractor'))
            ListTile(
              leading: const Icon(Icons.drive_file_rename_outline_sharp),
              title: const Text('Your Projects'),
              onTap: () {
                // Navigate to the Projects Screen
                Navigator.popAndPushNamed(context, '/projects');
              },
            ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/auth', (route) => false); // Redirect to login page
            },
          ),
          // Add more ListTile widgets for other menu items
        ],
      ),
    );
  }
}
