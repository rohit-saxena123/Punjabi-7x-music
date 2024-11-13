import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punjabi/AuthServices.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:punjabi/Notification_Service.dart';

class registerfile extends StatefulWidget {


  @override
  State<registerfile> createState() => _registerfileState();
}

class _registerfileState extends State<registerfile> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSignUp = true;
  final DatabaseReference _reference = FirebaseDatabase.instance.ref();




  void _toggleSignup(){
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notifications().getFCMToken();

  }


  @override
  Widget build(BuildContext context) {
    Notifications().getFCMToken();
    return Scaffold(
      body: Center(child: Form(
        key: _formstate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                contentPadding:EdgeInsets.only(left: 10),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _password,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),

            ElevatedButton(
                onPressed: () async{

                  final email = _email.text.trim();
                  final password = _password.text.trim();

               if(_isSignUp){
                 final user = await _authService.signupwithemail(email, password);
                 if(user != null){
                  final userId = user.uid;

                  await _reference.child("Users").child(userId).set({
                    "email":email,
                    "password":password,
                    "createAt":DateTime.now().toString(),
                  });

                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text('Sign-Up-Successfull,welcome ${user.email}')));
                 }else {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text('Sign-up-faild')));
                 }
                 setState(() {
                   _isSignUp = false;
                 });
               }else {

                 final user = await _authService.signinwithemail(email, password);
                 if(user != null){
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text('Sign-in-Successfull, welcome ${user.email}')));
                 }else {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text('Sign-in-faild')));
                 }

               }

                },
              child: Text(_isSignUp? "Sign Up":"Sign In"),
               )


          ],
        ),
      ),),
    );
  }
}
