import 'package:expert_app/screens/my_home/dashboard.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:expert_app/shared/constants/constants.dart';

import 'package:flutter/material.dart';

import 'widgets/mydrawerlist.dart';
import 'widgets/myheader_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService(uid: currentuserId).getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                    'Error fetching user details ${snapshot.error.toString()}'),
              ),
            );
          } else {
            final expertInfo = snapshot.data;

            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kBackgroundColor,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(33.0),
                      child: Image.network(
                        expertInfo!.imageUrl,
                        height: 37.0,
                        width: 37.0,
                      ),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(children: [
                      MyHeaderDrawer(expertInfo: expertInfo),
                      const MyDrawerList(),
                    ]),
                  ),
                ),
              ),
              body: DashBoard(expertInfo: expertInfo),
            );
          }
        });
  }
}
