import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithemail(String email, String password) async {
   try{
     final UserCredential credential = await _auth.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );
     return credential.user;
   }catch (exception){
     print('Sign-up-faild $exception');
     return null;
   }
  }


  Future<User?> signinwithemail(String email, String password)async {
    try{
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;

    }catch (exception){
      print('sign-in-faild $exception');
      return null;
    }
  }

  Future<void> _signOut()async {
    await _auth.signOut();
  }

}