import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    ExpertInfo? expertInfo = Provider.of<ExpertProvider>(context).getUser;
    return SafeArea(
        child: FutureBuilder(
            future: DatabaseService(uid: currentuserId).getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching user details'),
                );
              } else {
                final expertInfo = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Hello, ${expertInfo?.name} ',
                      style: kTextStyle,
                    ),
                    const Text(
                      'Todays\'s Appointments',
                      style: kTextStyle,
                    )
                  ],
                );
              }
            }));
  }
}
