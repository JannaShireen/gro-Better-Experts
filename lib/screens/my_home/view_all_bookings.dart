import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/screens/user_profile/user_profile.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:flutter/material.dart';

class ViewAllBookings extends StatelessWidget {
  const ViewAllBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 154, 153, 153),
        appBar: AppBar(
          title: const Text('All Bookings'),
          backgroundColor: Colors.black87,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Experts')
                .doc(currentuserId)
                .collection('bookings')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading(); // While waiting for data to load, show a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // If there's an error, show an error message
              } else {
                // If data is available, build the list
                final bookings = snapshot.data?.docs;
                if (bookings == null || bookings.isEmpty) {
                  return const Text(
                      "No bookings available"); // If there are no bookings, display a message
                }

                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index].data();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(
                              userId: booking[
                                  'user_id'], // Replace 'user_id' with the actual field name in your booking document that stores the user's ID
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: const Color.fromARGB(255, 244, 240, 203),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 13, 13, 13),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              '${index + 1}', // Display the index starting from 1
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            booking['user_name'] ??
                                '', // Replace 'name' with the actual field name in your booking document
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time: ${booking['time'] ?? ''}', // Replace 'time' with the actual field name in your booking document
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton.icon(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                ),
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: ((context) {
                                  //   return const CallPage(callID: '123');
                                  // })));
                                  // Add onPressed functionality here
                                },
                                label: const Text(
                                  'Connect',
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: const Icon(
                                  Icons.video_call,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
