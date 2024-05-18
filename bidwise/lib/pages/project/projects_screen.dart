import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bidwise/models/project.dart';
import 'package:bidwise/pages/project/add_project_screen.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Projects'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add New Project',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProjectScreen()),
              );
            },
          ),
        ],
      ),
      body: user != null
          ? _buildProjectList(user.uid)
          : Center(child: Text('Please log in to see your projects')),
    );
  }

  Widget _buildProjectList(String ownerId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('projects')
          .where('ownerId', isEqualTo: ownerId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No projects found.'));
        }

        final projects = snapshot.data!.docs
            .map((doc) => Project.fromFirestore(doc))
            .toList();

        return ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return ListTile(
              title: Text(project.title),
              subtitle: Text(project.description),
              onTap: () {
                // Navigate to project detail screen
              },
            );
          },
        );
      },
    );
  }
}
