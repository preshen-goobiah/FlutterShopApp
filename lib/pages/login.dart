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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();


  SharedPreferences preferences;
  bool loading = false;
  bool isloggedIn = false;

  @override
  void initState(){
    // calling initial state of login class
    super.initState();
   // isSignedIn();
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

  Future handleSignIn() async{

    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    print(firebaseUser.uid);
    if(firebaseUser != null)
      {
        final QuerySnapshot result = await Firestore.instance.collection(("users")).where("id",
            isEqualTo: firebaseUser.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;

        if(documents.length == 0 )
          {
            // insert user into firebase collection
            Firestore.instance
                .collection("users")
                .document(firebaseUser.uid)
                .setData({
              "id" : firebaseUser.uid,
              "username": firebaseUser.displayName,
              "photoUrl": firebaseUser.photoUrl
            });

            await preferences.setString("id", firebaseUser.uid);
            await preferences.setString("username", firebaseUser.displayName);
            await preferences.setString("photoUrl", firebaseUser.photoUrl);
          }
          else
            {
              await preferences.setString("id", documents[0]['id']);
              await preferences.setString("username", documents[0]['username']);
              await preferences.setString("photoUrl", documents[0]['photoUrl']);
            }

          Fluttertoast.showToast(msg: "Login successful");

          setState(() {
            loading=false;
          });
      }
    else
      {
        Fluttertoast.showToast(msg: "Login failed");

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('images/back.jpg', fit: BoxFit.cover, width:  double.infinity,),
          Container(
            color: Colors.black.withOpacity(0.15),
            width: double.infinity,
            height: double.infinity
          ),

          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[

                ],),
              )
            ),
          ),
          Visibility(
            visible: loading??true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child:  Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              ),
            ),

          )
        ],
      ),

      bottomNavigationBar: Container(
       child:  Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom:8),
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: (){
                handleSignIn();
              },
              child: Text("Sign in/Sign up with Google", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }


}
