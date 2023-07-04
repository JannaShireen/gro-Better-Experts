import 'package:expert_app/screens/my_profile/my_profile.dart';
import 'package:expert_app/services/auth.dart';
import 'package:flutter/material.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Container(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Appoinments'),
            onTap: () {
              // Handle home menu item tap
              Navigator.pop(context); // Close the drawer

              //   print('Show all appointments');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My  Profile'),
            onTap: () {
              // Handle home menu item tap
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyProfile())); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () {
              // Handle home menu item tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: const Text('Log Out'),
            onTap: () async {
              // Handle home menu item tap
              //  Navigator.pop(context);

              await auth.Logout();
              // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}

 
// enum DrawerSections {
//   dashboard,
//   contacts,
//   events,
//   notes,
//   settings,
//   notifications,
//   privacy_policy,
//   send_feedback,
// }