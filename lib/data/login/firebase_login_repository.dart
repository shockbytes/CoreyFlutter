import 'package:Corey/data/login/login_repository.dart';
import 'package:Corey/model/corey_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseLoginRepository implements LoginRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;

  FirebaseLoginRepository(
      this._googleSignIn,
      this._auth);

  Future<CoreyUser> signIn() async {
    if (_auth.currentUser() == null) {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      return  await _auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ).then(((user) => CoreyUser(user.displayName, user.photoUrl)));
    } else {
      return _auth
          .currentUser()
          .then((user) => CoreyUser(user.displayName, user.photoUrl));
    }
  }
}
