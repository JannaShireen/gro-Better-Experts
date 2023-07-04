import 'package:expert_app/provider/register_user.dart';

import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:expert_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatelessWidget {
  final Function toggleView;

  const RegisterUser({required this.toggleView, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterUserState>(builder: (context, state, _) {
      return state.loading
          ? const Loading()
          : Scaffold(
              appBar: AppBar(
                title: const Text('Sign up on Gro Better'),
                backgroundColor: kPrimaryColor,
              ),
              body: Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: state.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          kHeight30,
                          const Text(
                            'Already a member? ',
                            style: TextStyle(
                              color: kTextColor2,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              toggleView();
                            },
                            child: const Text('Log In'),
                          ),
                          TextFormFieldWidget(
                            hintText: 'Full Name',
                            onChanged: (value) {
                              state.name = value;
                            },
                          ),
                          kHeight20,
                          TextFormFieldWidget(
                            hintText: 'Email',
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              state.email = val;
                            },
                          ),
                          kHeight20,
                          TextFormFieldWidget(
                            hintText: 'Password',
                            validator: (value) => value!.length < 6
                                ? 'Password must be at least 6 characters long'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              state.password = value;
                            },
                          ),
                          kHeight20,
                          TextFormFieldWidget(
                            hintText: 'Confirm Password',
                            validator: (value) => value != state.password
                                ? 'Password do not match'
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              state.confirmPassword = value;
                            },
                          ),
                          kHeight20,

                          //Educational Qualification
                          Container(
                            height: MediaQuery.of(context).size.height * 0.068,
                            padding: const EdgeInsets.only(left: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: kTextColor2)),
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(25),
                              style: const TextStyle(color: kTextColor2),
                              dropdownColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Educational Qualification',
                              ),
                              value: state.selectedQualification.isNotEmpty
                                  ? state.selectedQualification
                                  : null,
                              items: state.qualifications
                                  .map((String qualification) {
                                return DropdownMenuItem<String>(
                                  value: qualification,
                                  child: Text(qualification),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                state.selectedQualification = newValue!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a qualification';
                                }
                                return null;
                              },
                            ),
                          ),
                          kHeight20,
                          //Category Selection
                          Container(
                            height: MediaQuery.of(context).size.height * 0.068,
                            padding: const EdgeInsets.only(left: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: kTextColor2)),
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(25),
                              style: const TextStyle(color: kTextColor2),
                              dropdownColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Category',
                              ),
                              value: state.selectedCategory.isNotEmpty
                                  ? state.selectedCategory
                                  : null,
                              items: state.categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                state.selectedCategory = newValue!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a category';
                                }
                                return null;
                              },
                            ),
                          ),
                          kHeight20,
                          const Text(
                            'What people can ask you? ',
                            style: kTextStyle,
                          ),
                          kHeight10,
                          TextFormFieldWidget(
                            hintText: 'Question 1',
                            onChanged: (value) {
                              state.question1 = value;
                            },
                          ),
                          kHeight10,
                          TextFormFieldWidget(
                            hintText: 'Question 2',
                            onChanged: (value) {
                              state.question2 = value;
                            },
                          ),
                          kHeight10,
                          TextFormFieldWidget(
                            hintText: 'Question 3',
                            onChanged: (value) {
                              state.question3 = value;
                            },
                          ),
                          kHeight10,
                          const Text(
                            'Upload Picture:',
                            style: kTextStyle,
                          ),
                          const SizedBox(height: 8),
                          state.image != null
                              ? Image.file(state.image!,
                                  width: 100, height: 100)
                              : Image.asset('assets/images/download.jpeg',
                                  width: 100, height: 100),
                          ElevatedButton(
                            onPressed: () async {
                              await state.selectImage();
                            },
                            child: const Text('Select Image'),
                          ),

                          //Register Button
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                              ),
                              onPressed: () async {
                                if (state.formKey.currentState!.validate()) {
                                  state.loading = true;
                                  dynamic result = await state.registerUser();

                                  if (result == null) {
                                    state.error = 'Invalid input';
                                    state.loading = false;
                                  }
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ),
                          kHeight20,
                          Text(
                            state.error,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),

                          // Other widget content...
                        ]),
                  ),
                ),
              ),
            );
    });
  }
}

//   void _showAdditionalDetailsDialog(BuildContext context) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(builder: (context, setState) {
//             final userRegistrationProvider =
//                 Provider.of<RegisterUserState>(context);

//             return AlertDialog(
//               title: const Text('Additional Details'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: const <Widget>[
//                     // TextFormField(
//                     //   decoration: const InputDecoration(labelText: 'Name'),
//                     // ),

//                     kHeight20,

//                     // ...
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('Done'),
//                   onPressed: () {
//                     // Process and save the additional details and uploaded image
//                     Navigator.of(context).pop();
//                     Navigator.pushReplacementNamed(context, '/home');
//                   },
//                 ),
//               ],
//             );
//           });
//         });
//   }
// }
