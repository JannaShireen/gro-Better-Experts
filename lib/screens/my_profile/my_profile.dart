import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/screens/my_profile/edit_profile.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Experts')
            .doc(currentuserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data, show a loading indicator or skeleton screen
            return const Loading();
          } else if (snapshot.hasError) {
            // If there's an error in fetching data, show an error message
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            // If there's no data available, show a message or an empty state
            return const Text('No data available');
          } else {
            final expertInfo = ExpertInfo.fromSnap(snapshot.data!);
            return SafeArea(
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(gradient: gradientColor),
                  child: CustomScrollView(slivers: [
                    SliverAppBar(
                      backgroundColor: kBackgroundColor,
                      title: Text(
                        expertInfo.name.toUpperCase(),
                        style: headingTextStyle,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.7,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    image: DecorationImage(
                                      image: NetworkImage(expertInfo.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                kHeight20,
                                Container(
                                  margin: const EdgeInsets.only(left: 85),
                                  child: Column(
                                    children: [
                                      Text(
                                        expertInfo.category,
                                        style: kTextStyle,
                                      ),
                                      kHeight10,
                                      expertInfo.fee != null
                                          ? Text(
                                              'Fee : ${expertInfo.fee} INR per Hour',
                                              style: kTextStyle,
                                            )
                                          : const Text(
                                              'Fee not added yet',
                                              style: kTextStyle,
                                            ),
                                      kHeight10,
                                      Text(
                                        ' ${expertInfo.sessionCount}  Sessions',
                                        style: kTextStyle,
                                      ),
                                      kHeight20,
                                    ],
                                  ),
                                ),
                                Text(
                                  'Tentative Availability (in IST)',
                                  style: headingTextStyle,
                                ),
                                kHeight10,
                                Text(
                                  'Mon - Sat    ${DateFormat.Hm().format(expertInfo.fromTime)} - ${DateFormat.Hm().format(expertInfo.toTime)}',
                                  style: kTextStyle,
                                ),
                                kHeight20,
                                Text(
                                  'About',
                                  style: headingTextStyle,
                                ),
                                kHeight10,
                                expertInfo.about != null
                                    ? Text(
                                        expertInfo.about,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      )
                                    : const Text('Not added'),
                                kHeight30,
                                Text(
                                  'What can you ask me:',
                                  style: headingTextStyle,
                                ),
                                kHeight20,
                                Text(
                                  '♦️ ${expertInfo.question1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                kHeight10,
                                Text(
                                  '♦️ ${expertInfo.question2}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                kHeight10,
                                Text(
                                  '♦️ ${expertInfo.question3}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditProfile(
                                                  userId: currentuserId)));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kButtonColor)),
                                    child: const Text('Edit Profile'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          }
        });
  }
}
