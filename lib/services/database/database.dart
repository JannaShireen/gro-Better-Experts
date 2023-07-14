import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/model/expert_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference expertCollection =
      FirebaseFirestore.instance.collection('Experts');

//First time registration
  Future addUserData(ExpertInfo expertInfo) async {
    try {
      return await expertCollection.doc(uid).set(expertInfo.toJson());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Profile updation
  Future updateUserData(ExpertInfo expertInfo) async {
    try {
      return await expertCollection.doc(uid).update(expertInfo.toJson());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> updateImageToStorage(String uid, File imageFile) async {
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$uid/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw Exception('Image upload failed');
      // Handle the error appropriately
    }
  }

  Stream<ExpertInfo> getUserDetailsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => ExpertInfo.fromSnap(snapshot));
  }

  Future<ExpertInfo> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firebaseFirestore
        .collection('Experts')
        .doc(currentUser.uid)
        .get();
    return ExpertInfo.fromSnap(snap);
  }
}
