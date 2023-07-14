import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpertProvider with ChangeNotifier {
  ExpertInfo? _expertInfo;
  final DatabaseService db =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  ExpertInfo? get getUser => _expertInfo;

  Future<void> refreshUser() async {
    ExpertInfo expertInfo = await db.getUserDetails();
    _expertInfo = expertInfo;
    notifyListeners();
  }
}
