import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertInfo {
  final String id;
  String name;
  String email;
  final String qualification;
  final String category;
  int fee;
  String question1;
  String question2;
  String question3;
  String imageUrl;
  String about;
  int sessionCount;
  DateTime fromTime;
  DateTime toTime;

  ExpertInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.qualification,
    required this.category,
    this.fee = 0,
    required this.fromTime,
    required this.toTime,
    this.question1 = '',
    this.question2 = '',
    this.question3 = '',
    this.imageUrl = '',
    this.about = '',
    this.sessionCount = 0,
  });
  Map<String, dynamic> toJson() {
    return {
      "ExpertID": id,
      "Name": name,
      "Email": email,
      "Qualification": qualification,
      "Category": category,
      "Question-1": question1,
      "Question-2": question2,
      "Question-3": question3,
      "SessionCount": sessionCount,
      "imageUrl": imageUrl,
      "fee": fee,
      "about": about,
      "fromTime": fromTime,
      "toTime": toTime,
      // "fromTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(fromTime),
      // "toTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(toTime),
    };
  }

  static ExpertInfo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ExpertInfo(
      id: snapshot['ExpertID'],
      name: snapshot['Name'],
      email: snapshot['Email'],
      qualification: snapshot['Qualification'] ?? 'Degree',
      category: snapshot['Category'] ?? 'Clinical Psychologist',
      sessionCount: snapshot['SessionCount'] ?? 0,
      question1: snapshot['Question-1'] ?? '',
      question2: snapshot['Question-2'] ?? '',
      question3: snapshot['Question-3'] ?? '',
      imageUrl: snapshot['imageUrl'] ?? '',
      fee: snapshot['fee'] ?? 0,
      about: snapshot['about'],
      fromTime: (snapshot['fromTime'] as Timestamp).toDate(),
      toTime: (snapshot['toTime'] as Timestamp).toDate(),
    );
  }
}
