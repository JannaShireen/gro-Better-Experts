import 'package:expert_app/screens/my_home/view_all_bookings.dart';
import 'package:expert_app/screens/my_profile/my_profile.dart';
import 'package:expert_app/services/auth.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: const Text('Appoinments'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ViewAllBookings()));
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
            onTap: () {
              _showLogoutConfirmationDialog(context);
            }
            // Close the drawer

            ),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    final AuthService auth = AuthService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await auth.Logout();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kButtonColor)),
              child: const Text('Logout'),
            ),
          ],
        );
      },
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