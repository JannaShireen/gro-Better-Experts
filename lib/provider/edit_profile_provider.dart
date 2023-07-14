import 'dart:io';

import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  File? _photo;
  File? get photo => _photo;
  String photoUrl = '';
  String error = '';
  bool loading = false;
  String name = '';
  String? fromTime;
  String? toTime;

  final formKey = GlobalKey<FormState>();

  void setError(String message) {
    error = message;
    notifyListeners();
  }

  void setPhoto(File? photo) {
    _photo = photo;
    notifyListeners();
  }

  void setFromTime(String time) {
    fromTime = time;
    notifyListeners();
  }

  void setToTime(String time) {
    toTime = time;
    notifyListeners();
  }

  Future<void> getPhoto(BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      _photo = photoTemp;
      notifyListeners();
    }
  }

  Future<void> updateUserDetails(ExpertInfo expertInfo) async {
    // loading = true;
    // notifyListeners();

    if (_photo != null) {
      final imageUrl = await DatabaseService(uid: expertInfo.id)
          .updateImageToStorage(expertInfo.id, _photo!);
      expertInfo.imageUrl = imageUrl;
    }

    // expertInfo.fromTime = fromTime;
    // expertInfo.toTime = toTime;

    await DatabaseService(uid: expertInfo.id).updateUserData(expertInfo);

    // loading = false;
    // notifyListeners();
  }
}
