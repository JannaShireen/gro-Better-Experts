import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/screens/my_profile/edit_profile.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    ExpertProvider expertProvider =
        Provider.of<ExpertProvider>(context, listen: false);
    await expertProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    ExpertInfo? expertInfo = Provider.of<ExpertProvider>(context).getUser;
    if (expertInfo == null) {
      // Handle the loading state or show an alternative UI
      return const Loading(); // Example: Show a progress indicator
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientColor),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      kHeight20,
                      //
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 2.9,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(expertInfo.imageUrl ??
                                    'https://www.donsdeliveries.com/wp-content/uploads/2022/08/imageholder-staff.jpeg'),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                      // SizedBox(
                      //     width: MediaQuery.of(context).size.width * 0.42,
                      //     height: MediaQuery.of(context).size.height * 0.22,
                      //     child: Image.network(expertInfo.imageUrl)

                      //     //
                      //     ),

                      kHeight20,

                      Text(
                        (expertInfo.name.toUpperCase()),
                        style: headingTextStyle,
                      ),
                      kHeight10,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfile(userId: currentuserId)));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      ),
                      DividerTeal,
                    ],
                  ),
                  kHeight20,
                  Text(
                    'Tentative Availability (in IST)',
                    style: headingTextStyle,
                  ),
                  kHeight10,
                  const Text(
                    'Mon - Sat     05.00 PM - 09.00 PM',
                    style: kTextStyle,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight10,
                      Text(
                        'About',
                        style: headingTextStyle,
                      ),
                      expertInfo.about != null
                          ? Text(
                              expertInfo.about,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17),
                            )
                          : const Text('Not added'),
                      kHeight10,
                      kHeight20,
                      Text(
                        'What can you ask me:',
                        style: headingTextStyle,
                      ),
                      kHeight20,
                      Text(
                        '♦️ ${expertInfo.question1}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      kHeight10,
                      Text('♦️ ${expertInfo.question2}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17)),
                      kHeight10,
                      Text('♦️ ${expertInfo.question3}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17)),
                      kHeight10,
                      DividerTeal,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
