import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final List<String> roles;
  final String firstName;
  final String lastName;
  final List<String> projects;
  final double rating;
  final List<String> reviews;
  final List<String> specialties;
  final Map<String, int> availability;
  final List<String> certifications;

  AppUser({
    required this.uid,
    required this.roles,
    required this.firstName,
    required this.lastName,
    required this.projects,
    required this.rating,
    required this.reviews,
    required this.specialties,
    required this.availability,
    required this.certifications,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppUser(
      uid: doc.id,
      roles: List<String>.from(data['roles'] ?? []),
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      projects: List<String>.from(data['projects'] ?? []),
      rating: (data['rating'] ?? 0).toDouble(),
      reviews: List<String>.from(data['reviews'] ?? []),
      specialties: List<String>.from(data['specialties'] ?? []),
      availability: Map<String, int>.from(data['availability'] ?? {}),
      certifications: List<String>.from(data['certifications'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'roles': roles,
      'firstName': firstName,
      'lastName': lastName,
      'projects': projects,
      'rating': rating,
      'reviews': reviews,
      'specialties': specialties,
      'availability': availability,
      'certifications': certifications,
    };
  }
}
