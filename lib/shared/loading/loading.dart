import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: const Center(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
