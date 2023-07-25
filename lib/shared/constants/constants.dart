import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var currentuserId = FirebaseAuth.instance.currentUser!.uid;

const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kTextColor2 = Colors.white;
const kButtonColor = Color.fromARGB(255, 234, 140, 140);
const kBackgroundColor = Color.fromARGB(255, 154, 153, 153);
const kWidth10 = SizedBox(
  width: 10,
);
const kHeight10 = SizedBox(height: 10);

const kHeight20 = SizedBox(height: 20);
const kHeight30 = SizedBox(height: 30);
const double kDefaultPadding = 20.0;
const TextStyle commonTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  color: kTextColor2,
  fontSize: 16,
);
const TextStyle textStyle2 = TextStyle(
  fontWeight: FontWeight.w300,
  color: Colors.black,
  fontSize: 16,
);
final TextStyle headingTextStyle = GoogleFonts.lato(
    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
const gradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      // Colors.green,
      kBackgroundColor,
      Color.fromARGB(255, 53, 92, 95)
    ]);
//final TextStyle headingTextStyle = GoogleFonts.lato(
//  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
//GoogleFonts.lato(
//fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBackgroundColor, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
const DividerTeal = Divider(
  height: 10,
  color: Colors.tealAccent,
);
const kTextStyle =
    TextStyle(fontSize: 17, color: kTextColor2, fontWeight: FontWeight.bold);
