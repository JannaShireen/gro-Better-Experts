import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

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
            decoration: const BoxDecoration(
                //  shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/gabriel.jpeg'))),
          ),
          const Text(
            'Gabriel Guevara',
            style: kTextStyle,
          ),
          kHeight10,
          const Text(
            'gabriel guevara@gmail.com',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
