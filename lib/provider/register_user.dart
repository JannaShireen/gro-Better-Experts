import 'dart:io';

import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/model/user_model.dart';
import 'package:expert_app/services/auth.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUserState extends ChangeNotifier {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  File? image;
  String question1 = '';
  String question2 = '';
  String question3 = '';
  String selectedQualification = '';
  String selectedCategory = '';
  DateTime fromTime = DateTime.now();
  DateTime toTime = DateTime.now();

  List<String> qualifications = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Ph.D.'
  ];
  List<String> categories = [
    'Life Coach',
    'Counselling Psychologist',
    'Positivity Coach',
    'Relationship Coach',
    'Peer Listener',
    'Therapist',
    'Career Mentor'
  ];

  void setFromTime(DateTime time) {
    fromTime = time;
    notifyListeners();
  }

  void setToTime(DateTime time) {
    toTime = time;
    notifyListeners();
  }

  DateTime date = DateTime.now();
  // Gender gender = Gender.Male;
  final formKey = GlobalKey<FormState>();

  Future<void> selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<dynamic> registerUser() async {
    try {
      loading = true;
      notifyListeners();

      UserModel result =
          await _auth.registerWithEmailAndPassword(email, password, name);
      // print('Account created.');
      String imagePath = await DatabaseService(uid: result.uid)
          .updateImageToStorage(result.uid, image!);
      //  print('Image path stored');

      ExpertInfo expertInfo = ExpertInfo(
        id: result.uid,
        name: name,
        email: email,
        qualification: selectedQualification,
        category: selectedCategory,
        question1: question1,
        question2: question2,
        question3: question3,
        imageUrl: imagePath,
        fromTime: fromTime,
        toTime: toTime,
      );
      //   print('Expert Info object created');
      await DatabaseService(uid: expertInfo.id).addUserData(expertInfo);
      // await _auth.updateExpertProfile(expertInfo);
      // print('Added to database');
      loading = false;
      notifyListeners();

      return result;
    } catch (error) {
      loading = false;
      notifyListeners();
      return null;
    }
  }
}
