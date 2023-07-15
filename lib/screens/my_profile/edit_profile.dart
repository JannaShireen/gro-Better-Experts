import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/provider/edit_profile_provider.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:expert_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  final String userId;
  const EditProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(builder: (context, state, _) {
      return state.loading
          ? const Loading()
          : Scaffold(
              appBar: AppBar(
                title: const Text('Edit Profile'),
                automaticallyImplyLeading: true,
                backgroundColor: kDefaultIconDarkColor,
              ),
              body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Experts')
                      .doc(userId)
                      .snapshots(),
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
                      // final expertInfo = snapshot.data;
                      ExpertInfo expertInfo =
                          ExpertInfo.fromSnap(snapshot.data!);

                      return Container(
                          decoration:
                              const BoxDecoration(gradient: gradientColor),
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Form(
                              key: state.formKey,
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    const SizedBox(height: 7),
                                    state.photo == null
                                        ? Container(
                                            padding: const EdgeInsets.all(10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/empty_dr_pic.webp'),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.all(10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    expertInfo.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                      ),
                                      onPressed: () {
                                        state.getPhoto(context);
                                      },
                                      icon: const Icon(Icons.image_outlined),
                                      label: const Text('Update Picture'),
                                    ),
                                    TextFormFieldWidget(
                                      hintText: 'Name',
                                      initialValue: expertInfo.name,
                                      onChanged: (value) {
                                        expertInfo.name = value;
                                      },
                                      labelText: 'Name',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                    kHeight10,
                                    TextFormFieldWidget(
                                      initialValue: expertInfo.email,
                                      onChanged: (value) {
                                        expertInfo.email = value;
                                      },
                                      labelText: 'Email',
                                      hintText: 'Email',
                                      validator: (val) => val!.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                    ),
                                    kHeight10,
                                    TextFormFieldWidget(
                                      initialValue: expertInfo.about,
                                      hintText: 'About',
                                      onChanged: (value) {
                                        expertInfo.about = value;
                                      },
                                      labelText: 'About',
                                      maxLines: 6,
                                    ),
                                    kHeight20,
                                    Container(
                                      width: 100,
                                      padding: const EdgeInsets.only(left: 2),
                                      child: TextFormField(
                                        initialValue: expertInfo.fee.toString(),
                                        style:
                                            const TextStyle(color: kTextColor2),
                                        onChanged: (value) {
                                          expertInfo.fee = double.parse(value);
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Fee',
                                          hintText: 'fee',
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: kDefaultIconDarkColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    kHeight20,
                                    //from Time
                                    Text(
                                      'Choose your time',
                                      style: headingTextStyle,
                                    ),
                                    kHeight20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final pickedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                      state.fromTime),
                                            );
                                            if (pickedTime != null) {
                                              final pickedDateTime = DateTime(
                                                state.fromTime.year,
                                                state.fromTime.month,
                                                state.fromTime.day,
                                                pickedTime.hour,
                                                pickedTime.minute,
                                              );
                                              state.setFromTime(pickedDateTime);
                                            }
                                          },
                                          child: Text(
                                            'From:    ${DateFormat.Hm().format(state.fromTime)}',
                                            style: kTextStyle,
                                          ),
                                        ),

                                        //To time
                                        GestureDetector(
                                          onTap: () async {
                                            final pickedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                      state.toTime),
                                            );
                                            if (pickedTime != null) {
                                              final pickedDateTime = DateTime(
                                                state.toTime.year,
                                                state.toTime.month,
                                                state.toTime.day,
                                                pickedTime.hour,
                                                pickedTime.minute,
                                              );
                                              state.setToTime(pickedDateTime);
                                            }
                                          },
                                          child: Text(
                                            'To :   ${DateFormat.Hm().format(state.toTime)}',
                                            style: kTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),

                                    kHeight30,
                                    const Text(
                                      'What people can ask you? ',
                                      style: kTextStyle,
                                    ),
                                    kHeight10,
                                    TextFormFieldWidget(
                                      initialValue: expertInfo.question1,
                                      hintText: 'Question 1',
                                      onChanged: (value) {
                                        expertInfo.question1 = value;
                                      },
                                    ),
                                    kHeight10,
                                    TextFormFieldWidget(
                                      initialValue: expertInfo.question2,
                                      onChanged: (value) {
                                        expertInfo.question2 = value;
                                      },
                                      hintText: 'Question 2',
                                    ),
                                    kHeight10,
                                    TextFormFieldWidget(
                                      initialValue: expertInfo.question3,
                                      hintText: 'Question 3',
                                      onChanged: (value) {
                                        expertInfo.question3 = value;
                                      },
                                    ),
                                    kHeight10,
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (state.formKey.currentState!
                                            .validate()) {
                                          await state
                                              .updateUserDetails(expertInfo);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Edited Successfully'),
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kButtonColor,
                                      ),
                                      child: const Text('Update'),
                                    ),
                                    kHeight20,
                                    Text(
                                      state.error,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ]))));
                    }
                  }),
            );
    });
  }
}
