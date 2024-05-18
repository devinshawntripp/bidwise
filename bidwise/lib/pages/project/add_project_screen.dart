import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bidwise/models/project.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _images = <String>[]; // Implement image picking
  String? _videoUrl; // Implement video picking

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Project'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _addProject();
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProject() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final project = Project(
        id: '',
        ownerId: user.uid,
        title: _titleController.text,
        description: _descriptionController.text,
        images: _images,
        videoUrl: _videoUrl,
        createdAt: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('projects')
          .add(project.toFirestore());
    }
  }
}
