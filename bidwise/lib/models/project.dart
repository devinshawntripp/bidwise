import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final List<String> images;
  final String? videoUrl;
  final Timestamp createdAt;

  Project({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.images,
    this.videoUrl,
    required this.createdAt,
  });

  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Project(
      id: doc.id,
      ownerId: data['ownerId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      videoUrl: data['videoUrl'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'images': images,
      'videoUrl': videoUrl,
      'createdAt': createdAt,
    };
  }
}
