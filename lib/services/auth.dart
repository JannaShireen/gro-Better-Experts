import 'package:expert_app/model/expert_info.dart';
import 'package:expert_app/model/user_model.dart';
import 'package:expert_app/services/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromCredential(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get userlog {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromCredential(user));
  }

  //Google Sign In
  SignInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future SignInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromCredential(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email & password
  Future signEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future Logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with phone number

  //register with email&password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromCredential(user);
    } catch (e) {
      print('Registration error: $e');
      //print(e.toString());
      return null;
    }
  }

  Future updateExpertProfile(ExpertInfo expertInfo) async {
    try {
      await DatabaseService(uid: expertInfo.id).addUserData(expertInfo);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
