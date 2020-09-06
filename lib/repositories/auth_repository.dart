import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multi_plt/repositories/user_model.dart';
//import 'package:multi_plt/screens/home_page.dart';
//import 'package:multi_plt/screens/login_page.dart';

class AuthRepository {
  /*
  handleAuth() {
    StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            //return LoginScreen(title: 'Login');
            return LoginPage();
          }
        });
  }

  */
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser;

    //  final UserCredential authResult =
    //      await _firebaseAuth.signInWithCredential(credential);
    //  final User user = authResult.user;

    //  assert(!user.isAnonymous);
    //  assert(await user.getIdToken() != null);

    //  final User currentUser = _firebaseAuth.currentUser;
    //  assert(user.uid == currentUser.uid);
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    print("User Sign Out");
    return Future.wait([
      _firebaseAuth.signOut(),
      googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserModel> getUser() async {
    return UserModel(
        email: _firebaseAuth.currentUser.email,
        name: _firebaseAuth.currentUser.displayName);
  }
}

class NetworkException implements Exception {}
