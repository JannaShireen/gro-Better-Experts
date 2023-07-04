// import 'package:expert_app/model/expert_info.dart';
// import 'package:expert_app/provider/edit_profile_provider.dart';
// import 'package:expert_app/services/database/database.dart';
// import 'package:expert_app/shared/constants/constants.dart';
// import 'package:expert_app/shared/loading/loading.dart';
// import 'package:expert_app/widgets/text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class EditProfile extends StatelessWidget {
//   final String imageUrl;
//   final Map<String, dynamic> profileData;
//   final TextEditingController nameController;
//   final TextEditingController emailController;
//   final String selectedQualification;
//   final String selectedCategory;
//   final TextEditingController aboutNotesController;
//   final TextEditingController question1Controller;
//   final TextEditingController question2Controller;
//   final TextEditingController question3Controller;

//   EditProfile({
//     Key? key,
//     required this.profileData,
//     required this.imageUrl,
//   })  : nameController = TextEditingController(text: profileData['name'] ?? ''),
//         emailController =
//             TextEditingController(text: profileData['email'] ?? ''),
//         selectedQualification = profileData['qualification'] ?? '',
//         selectedCategory = profileData['category'] ?? '',
//         aboutNotesController =
//             TextEditingController(text: profileData['about'] ?? ''),
//         question1Controller =
//             TextEditingController(text: profileData['question1'] ?? ''),
//         question2Controller =
//             TextEditingController(text: profileData['question2'] ?? ''),
//         question3Controller =
//             TextEditingController(text: profileData['question3'] ?? ''),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<EditProfileProvider>(builder: (context, state, _) {
//       return state.loading
//           ? const Loading()
//           : Scaffold(
//               appBar: AppBar(
//                 title: const Text('Edit Profile'),
//                 automaticallyImplyLeading: true,
//                 backgroundColor: kDefaultIconDarkColor,
//               ),
//               body: Container(
//                 margin: const EdgeInsets.all(20),
//                 child: Form(
//                   key: state.formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           kHeight30,

//                           TextFormFieldWidget(
//                             controller: nameController,
//                             hintText: 'Full Name',
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please Enter Name';
//                               }
//                               return null;
//                             },
//                           ),
//                           kHeight20,
//                           TextFormFieldWidget(
//                             controller: emailController,
//                             hintText: 'Email',
//                             validator: (val) =>
//                                 val!.isEmpty ? 'Enter an email' : null,
//                           ),
//                           //About
//                           kHeight20,
//                           TextFormFieldWidget(
//                             hintText: 'About',
//                             controller: aboutNotesController,
//                             maxLines: 6,
//                           ),

//                           kHeight20,
//                           const Text(
//                             'What people can ask you? ',
//                             style: kTextStyle,
//                           ),
//                           kHeight10,
//                           TextFormFieldWidget(
//                             hintText: 'Question 1',
//                             controller: question1Controller,
//                           ),
//                           kHeight10,
//                           TextFormFieldWidget(
//                             controller: question2Controller,
//                             hintText: 'Question 2',
//                           ),
//                           kHeight10,
//                           TextFormFieldWidget(
//                             hintText: 'Question 3',
//                             controller: question3Controller,
//                           ),
//                           kHeight10,
//                           const Text(
//                             'Upload Picture:',
//                             style: kTextStyle,
//                           ),
//                           const SizedBox(height: 8),
//                           state.photo == null
//                               ? Center(
//                                   child: SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.18,
//                                     width: MediaQuery.of(context).size.width *
//                                         0.18,
//                                     child: Image.network(
//                                       imageUrl,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 )
//                               : Center(
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.17,
//                                     width: MediaQuery.of(context).size.width *
//                                         0.17,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(
//                                           MediaQuery.of(context).size.height *
//                                               0.085),
//                                     ),
//                                     child: Image.file(
//                                       state.photo!,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                           kHeight10,
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.black,
//                             ),
//                             onPressed: () {
//                               state.getPhoto(context);
//                             },
//                             icon: const Icon(Icons.image_outlined),
//                             label: const Text('Add An Image'),
//                           ),
//                           // state.image != null
//                           //     ? Image.file(state.image!,
//                           //         width: 100, height: 100)
//                           //     : Image.asset('assets/images/download.jpeg',
//                           //         width: 100, height: 100),
//                           // ElevatedButton(
//                           //   onPressed: () async {
//                           //     await state.selectImage();
//                           //   },
//                           //   child: const Text('Select Image'),
//                           // ),

//                           //Register Button
//                           SizedBox(
//                             width: 150,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: kPrimaryColor,
//                               ),
//                               onPressed: () async {
//                                 if (state.formKey.currentState!.validate()) {
//                                   state.loading = true;
//                                   final editProfileProvider =
//                                       Provider.of<EditProfileProvider>(context,
//                                           listen: false);
//                                   // Upload image if a new image is selected
//                                   String imageUrl = '';
//                                   if (state.photo != null) {
//                                     imageUrl = await DatabaseService(
//                                             uid: currentuserId)
//                                         .updateImageToStorage(currentuserId,
//                                             editProfileProvider.photo!);
//                                     editProfileProvider.photo;
//                                   }

//                                   ExpertInfo updatedExpert = ExpertInfo(
//                                     id: currentuserId,
//                                     name: nameController.text,
//                                     qualification: selectedQualification,
//                                     category: selectedCategory,
//                                     imageUrl: imageUrl,
//                                     email: emailController.text,
//                                     question1: question1Controller.text,
//                                     question2: question2Controller.text,
//                                     question3: question3Controller.text,
//                                     about: aboutNotesController.text,
//                                   );
//                                   await DatabaseService(uid: currentuserId)
//                                       .updateUserData(updatedExpert);

//                                   Navigator.pop(context);
//                                 }

//                                 //   if (result == null) {
//                                 //     state.error = 'Invalid input';
//                                 //     state.loading = false;
//                                 //   }
//                                 // }
//                               },
//                               child: const Text('Register'),
//                             ),
//                           ),
//                           kHeight20,
//                           Text(
//                             state.error,
//                             style: const TextStyle(
//                               color: Colors.red,
//                               fontSize: 14,
//                             ),
//                           ),

//                           // Other widget content...
//                         ]),
//                   ),
//                 ),
//               ),
//             );
//     });
//   }
// }
