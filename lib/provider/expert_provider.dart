import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class ExpertProvider with ChangeNotifier {
  ExpertInfo? _expertInfo;
  final DatabaseService db = DatabaseService(uid: currentuserId);

  ExpertInfo? get getUser => _expertInfo;

  Future<void> refreshUser() async {
    ExpertInfo expertInfo = await db.getUserDetails();
    _expertInfo = expertInfo;
    notifyListeners();
  }
}
