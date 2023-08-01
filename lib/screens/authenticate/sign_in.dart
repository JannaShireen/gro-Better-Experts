import 'package:expert_app/services/auth.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:expert_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';

  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 20, 35, 28),
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Gro Better Experts',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(gradient: gradientColor),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        kHeight30,

                        kHeight30,

                        // welcome back, you've been missed!
                        const Text('Welcome! ', style: commonTextStyle),
                        kHeight30,
                        const Text(
                          'Sign In to provide your valuable service',
                          style: commonTextStyle,
                        ),

                        kHeight20,
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    // username textfield
                                    TextFormFieldWidget(
                                      hintText: 'Email',
                                      validator: (val) => val!.isEmpty
                                          ? 'Enter an email'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),

                                    kHeight20,

                                    // password textfield
                                    TextFormFieldWidget(
                                      hintText: 'Password',
                                      validator: (value) => value!.length < 6
                                          ? 'Password must be at least 6 characters long'
                                          : null,
                                      obscureText: true,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 10),

                                    // forgot password?
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Forgot Password?',
                                            style:
                                                TextStyle(color: kTextColor2),
                                          ),
                                        ],
                                      ),
                                    ),

                                    kHeight30,

                                    // sign in button
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryColor),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              dynamic result = await _auth
                                                  .signEmailAndPassword(
                                                      email, password);
                                              if (result == null) {
                                                setState(() {
                                                  error =
                                                      'Wrong Username or Password';
                                                  loading = false;
                                                });
                                              }
                                            }
                                          },
                                          child: const Text('Sign In')),
                                    ),
                                    kHeight20,

                                    Text(
                                      error,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            AuthService().SignInWithGoogle();
                            // _SignInWithGoogle(context);
                          },
                          // icon: const Icon(Icons.golf_course),
                          icon: Image.asset(
                            'assets/images/google.png',
                            height: 24.0,
                            width: 24.0,
                          ),
                          label: const Text('Sign in with Google Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        kHeight20,

                        const SizedBox(
                          height: 60,
                        ),
                        // Don't have an account?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  "Don't have an account yet? ",
                                  style: TextStyle(color: kTextColor2),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),

                        kHeight10,

                        TextButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: const Text('Register here')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
