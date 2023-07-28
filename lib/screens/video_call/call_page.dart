// import 'package:expert_app/shared/app_id_sign.dart';
// import 'package:expert_app/shared/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class CallPage extends StatelessWidget {
//   const CallPage({Key? key, required this.callID}) : super(key: key);
//   final String callID;

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID:
//           appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign:
//           appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: currentuserId,
//       userName: 'doctor',
//       callID: callID,
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//         ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
//     );
//   }
// }
