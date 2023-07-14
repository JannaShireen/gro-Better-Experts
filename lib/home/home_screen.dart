import 'package:expert_app/provider/bottom_navigation_bar_provider.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/services/auth.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/mydrawerlist.dart';
import 'widgets/myheader_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    ExpertProvider expertProvider = Provider.of(context, listen: false);
    await expertProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Consumer<BottomState>(
      builder: (context, value, _) {
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(children: const [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ]),
              ),
            ),
          ),
          body: Center(
            child: value.widgetOptions.elementAt(value.selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            backgroundColor: kDefaultIconLightColor,
            selectedItemColor: kDefaultIconDarkColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: kPrimaryColor,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: kPrimaryColor),
                label: 'Clients',
              ),
            ],
            currentIndex: value.selectedIndex,
            onTap: (index) {
              value.onItemTapped(index);
            },
          ),
        );
      },
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text('doctors home page'),
    //           OutlinedButton.icon(
    //             style: OutlinedButton.styleFrom(
    //               textStyle: const TextStyle(color: Colors.green),
    //             ),
    //             onPressed: () async {
    //               await auth.Logout();
    //             },
    //             icon: const Icon(
    //               Icons.power_settings_new,
    //               color: Colors.white,
    //             ),
    //             label: const Text(
    //               'Log Out',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
