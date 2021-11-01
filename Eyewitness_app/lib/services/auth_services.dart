
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth _auth =FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _auth
	.authStateChanges().map(
        (User user) => user?.uid,
      );

  

  String getCurrentUID() {
    return _auth.currentUser.uid;
  }

  Future getCurrentUser() async {
    return _auth.currentUser;
  }
}
