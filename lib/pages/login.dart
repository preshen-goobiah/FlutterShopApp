import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignin = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isloggedIn = false;

  @override
  void initState(){
    // calling initial state of login class
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    // wait for the data to be returned from SharedPref
    preferences = await SharedPreferences.getInstance();
    isloggedIn = await googleSignin.isSignedIn();

    if(isloggedIn)
      {
        // pushReplacement removes ability to go back
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }

    setState(() {
      loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
