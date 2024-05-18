import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback openDrawer;
  final GlobalKey<ScaffoldState> scaffoldKey;

  NavMenu({
    required this.title,
    required this.scaffoldKey,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey.shade200, // Background color
          child: Text('A'), // Placeholder for the profile picture
          foregroundColor: Colors.black,
        ),
      ],
      leading: MediaQuery.of(context).size.width < 500
          ? IconButton(
              icon: Icon(Icons.menu),
              onPressed: openDrawer,
            )
          : null, // Hide the hamburger menu button on larger screens
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
