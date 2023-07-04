import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/shared/constants/constants.dart';
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
      return const CircularProgressIndicator(); // Example: Show a progress indicator
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    kHeight20,
                    //

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: expertInfo.imageUrl != null
                          ? Image.network(expertInfo.imageUrl)
                          : Image.asset(
                              'assets/images/empty-user.png',
                              fit: BoxFit.cover,

                              //
                            ),
                    ),
                    kHeight20,

                    Text(
                      expertInfo.name.toUpperCase(),
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    Text(
                      expertInfo.category,
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => EditProfile(
                            //         profileData: expertInfo.toJson(),
                            //         imageUrl: expertInfo.imageUrl)));
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
                    kHeight10,
                    const Text(
                      "Hey, I am Gabriel, a passionate Mental Health Professional specializing in Counseling Psychology. Being an adolescent can be tough and it comes with its own unique changes and obstacles. I think they deserve a helping hand which is why I love walking through the life journey with them and helping them maximize their potential. ",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    kHeight20,
                    Text(
                      'What can you ask me:',
                      style: headingTextStyle,
                    ),
                    kHeight10,
                    Text(
                      '♦️ ${expertInfo.question1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    kHeight10,
                    Text('♦️ ${expertInfo.question2}',
                        style: const TextStyle(color: Colors.white)),
                    kHeight10,
                    Text('♦️ ${expertInfo.question3}',
                        style: const TextStyle(color: Colors.white)),
                    kHeight10,
                    DividerTeal,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
