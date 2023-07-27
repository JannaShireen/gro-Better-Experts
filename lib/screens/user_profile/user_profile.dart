import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expert_app/screens/user_profile/widgets/thoughts_tab.dart';
import 'package:expert_app/screens/user_profile/widgets/user_records.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:expert_app/shared/loading/loading.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for data to load, show a loading indicator or placeholder
            return const Loading();
          } else if (snapshot.hasError) {
            // If there's an error, show an error message
            return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')));
          } else {
            final userData = snapshot.data;
            String firstLetter = userData!['Name'].substring(0, 1);
            final bdayDateFormatted = userData['DateOfBirth'] as Timestamp;

            // User details fetched successfully, you can use the userData map here
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0.0,
                title: Text(
                  '@${'${userData['Username']}'.split('@')[0]}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Text(
                              firstLetter,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 34),
                            ),
                          ),
                          Text(
                            '${userData['Name']}',
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          kHeight10,
                          Text(
                            'DOB:  ${bdayDateFormatted.toDate().toString().split(" ")[0]}',
                            style: textStyle2,
                          ),
                          kHeight10,
                          userData['BioNotes'].isNotEmpty
                              ? Text(
                                  'Bio ${userData['BioNotes']}',
                                  style: textStyle2,
                                )
                              : const Text(
                                  'Bio not added',
                                  style: textStyle2,
                                ),
                          kHeight10,
                        ],
                      ),
                    ),
                    DividerTeal,
                    const DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: 'Posts',
                              ),
                              Tab(text: 'Records'),
                            ],
                          ),
                          SizedBox(
                            height: 500, // Adjust the height as needed
                            child: TabBarView(
                              children: [
                                UserThoughts(),
                                RecordsTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
  


//         return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           elevation: 0.0,
//           title: Text(
//             'username',
//             //'${userInfo?.email}'.split('@')[0],
    
//             style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.black,
//                       child: Text(
//                         firstLetter,
//                         style: const TextStyle(color: Colors.white, fontSize: 34),
//                       ),
//                     ),
//                     Text(
//                       ' ${userInfo.name}',
//                       //'${document['name']}',
//                       style: const TextStyle(
//                         fontSize: 27,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     kHeight10,
//                     Text(
//                       'DOB:  ${'${userInfo.dob}'.split(" ")[0]}',
//                       //  'DOB: ${'${document['DOB']}.'.split(" ")[0]}',
//                       style: textStyle2,
//                     ),
//                     kHeight10,
//                     Text(
//                       'Bio ${userInfo.bioNotes ?? ''}',
//                       style: textStyle2,
//                     ),
//                     kHeight10,
//                   ],
//                 ),
//               ),
//               DividerTeal,
//               DefaultTabController(
//                 length: 2,
//                 child: Column(
//                   children: [
//                     TabBar(
//                       labelColor: Colors.black,
//                       tabs: [
//                         Tab(
//                           text: 'Posts',
//                         ),
//                         Tab(text: 'Records'),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 500, // Adjust the height as needed
//                       child: TabBarView(
//                         children: [
//                           UserThoughts(),
//                           RecordsTab(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
        
//       },
       
//       );
  
//   }
// }
