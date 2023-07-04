import 'package:expert_app/home/home_screen.dart';
import 'package:expert_app/model/user_model.dart';
import 'package:expert_app/screens/authenticate/authenicate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return HomeScreen();

      //return either home or authenticate widget
    }
  }
}
