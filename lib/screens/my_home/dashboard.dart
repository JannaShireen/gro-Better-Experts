import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    ExpertInfo? expertInfo = Provider.of<ExpertProvider>(context).getUser;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Hello, ${expertInfo?.name}'),
          const Text(
            'Requests',
            style: TextStyle(color: Colors.white),
          ),
          DividerTeal,
          const Text(
            'Todays\'s Appointments',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
