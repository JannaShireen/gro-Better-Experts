import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String id;
  final String name;
  // Add other user properties as needed

  UserInfo({
    required this.id,
    required this.name,
    // Add other user properties as needed
  });

  factory UserInfo.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserInfo(
      id: snapshot.id,
      name: data?['name'] ?? '',
      // Add other user properties as needed
    );
  }
}
