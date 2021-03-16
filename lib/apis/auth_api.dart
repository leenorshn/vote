import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  final FirebaseAuth _firebaseAuth;

  AuthApi() : _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(matricule) async {
    try {
      var t = await _firebaseAuth.signInWithEmailAndPassword(
          email: "$matricule@gmail.com", password: "123423");
      return t.user.uid;
    } catch (err) {
      throw Exception(err);
    }
  }

  Stream<User> isLogin() {
    return _firebaseAuth.authStateChanges();
  }

  Future logout() async {
    await _firebaseAuth.signOut();
  }
}
