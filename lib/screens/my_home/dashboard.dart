import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/screens/my_home/view_all_bookings.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';

import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  final ExpertInfo expertInfo;
  const DashBoard({required this.expertInfo, super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    return Container(
      decoration: const BoxDecoration(gradient: gradientColor),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Hello,',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 30),
            child: Text(
              '${expertInfo.name.toUpperCase()} 👋🏼',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          kHeight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Appoinment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ViewAllBookings()));
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
          kHeight10,
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Experts')
                  .doc(currentuserId)
                  .collection('bookings')
                  .where('date',
                      isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
                      isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
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
                    return const Center(
                      child: Text(
                        "No bookings today",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ); // If there are no bookings, display a message
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index].data();
                      return Container(
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
                      );
                    },
                  );
                }
              },
            ),
          )

          // TodaysAppointmentsTab(
          //  doctorId: expertInfo.id,
          //  )
        ]),
      ),
    );
  } //else
}

class TodaysAppointmentsTab extends StatelessWidget {
  final String doctorId;

  const TodaysAppointmentsTab({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    // final today = DateTime.now();
    // final appointmentsCollection = FirebaseFirestore.instance
    //     .collection('Experts')
    //     .doc('doctorId') //
    //     .collection('bookings');

    // return StreamBuilder<QuerySnapshot>(
    //   stream:
    //       appointmentsCollection.where('date', isEqualTo: today).snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }

    //     if (snapshot.hasError) {
    //       return Text(
    //         'Error: ${snapshot.error}',
    //         style: const TextStyle(color: Colors.red),
    //       );
    //     }

    // final appointments = snapshot.data!.docs;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          // final appointment =
          //     appointments[index].data() as Map<String, dynamic>;
          return Container(
            padding: const EdgeInsets.all(15),
            width: 100,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color.fromARGB(255, 190, 186, 142)),
            child: ListTile(
              // leading: ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: Image.network(
              //     appointment!.imageUrl,
              //     height: 130,
              //   ),
              // ),
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Samaha Musthafa',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Time: 2.00 PM',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kButtonColor),
                            ),
                            onPressed: () {},
                            child: const Text('Connect ')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

//       },
//     );
//   }
// }

// class AllAppointmentsTab extends StatelessWidget {
//   final String doctorId;

//   const AllAppointmentsTab({super.key, required this.doctorId});

//   @override
//   Widget build(BuildContext context) {
//     final appointmentsCollection = FirebaseFirestore.instance
//         .collection('Experts')
//         .doc(
//             'expert_id') // Replace 'expert_id' with the appropriate ID for your expert data.
//         .collection('bookings');

//     return StreamBuilder<QuerySnapshot>(
//       stream: appointmentsCollection.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }

//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         final appointments = snapshot.data!.docs;

//         return ListView.builder(
//           itemCount: appointments.length,
//           itemBuilder: (context, index) {
//             final appointment =
//                 appointments[index].data() as Map<String, dynamic>;
//             return ListTile(
//               title: Text(appointment['name']),
//               subtitle: Text('Time: ${appointment['date'].toString()}'),
//             );
//           },
//         );
//       },
//     );
//   }
// }
