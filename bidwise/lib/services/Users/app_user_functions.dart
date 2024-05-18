import 'package:bidwise/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUser(
    User user,
    List<String> roles,
    String firstName,
    String lastName,
    List<String> projects,
    double rating,
    List<String> reviews,
    List<String> specialties,
    Map<String, int> availability,
    List<String> certifications) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'roles': roles,
    'firstName': firstName,
    'lastName': lastName,
    'projects': projects,
    'rating': rating,
    'reviews': reviews,
    'specialties': specialties,
    'availability':
        availability, // Ensure the map's value types are compatible with Firestore
    'certifications': certifications,
  });
}

Future<AppUser?> getUserWithRoles(User user) async {
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (snapshot.exists && snapshot.data() != null) {
      return AppUser.fromFirestore(snapshot);
    } else {
      return null; // Document does not exist
    }
  } catch (e) {
    print('Error getting user roles: $e');
    return null; // Return null in case of any error
  }
}
