import 'package:expert_app/model/expert_info.dart';

import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatelessWidget {
  final ExpertInfo expertInfo;
  const MyHeaderDrawer({required this.expertInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 80,
              child: Image.network(expertInfo.imageUrl)
              // decoration: const BoxDecoration(
              //     //  shape: BoxShape.circle,
              //     image: DecorationImage(
              //         image: NetworkImage(expertInfo.imageUrl))),
              ),
          Text(
            expertInfo.name,
            style: kTextStyle,
          ),
          kHeight10,
          Text(
            expertInfo.email,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
