import 'package:flutter/material.dart';
import 'package:flutterapp/pages/signup.dart';
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

    await firebaseAuth.currentUser().then((user){
      if(user!=null)
        {
          setState(() => isloggedIn = true);
        }
    });

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
          Image.asset('images/back.jpg', fit: BoxFit.cover, width:  double.infinity, height: double.infinity,),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity
          ),

          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
                child: Form(
                  key: _formKey,

                  child: ListView(children: <Widget>[

                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(

                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0,

                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextController,
                              validator: (value){
                                Pattern pattern = r'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}';
                                RegExp regex = new RegExp(pattern);

                                if(!regex.hasMatch(value))
                                  {
                                    return 'Please make sure your email address is valid';
                                  }
                                else
                                  {
                                    return null;
                                  }
                              },
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0,

                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),


                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _passwordTextController,
                            validator: (value){

                              if(value.isEmpty)
                              {
                                return 'The password field cannot be empty';
                              }
                              else if(value.length < 6)
                              {
                                return 'The password has to be at least 6 characters long';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(

                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                        elevation: 0,

                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: MaterialButton(onPressed: (){},
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("Login", textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),)
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                        },
                        child: Text("Sign up", textAlign: TextAlign.center, style: TextStyle(color: Colors.white))
                      )
                    ),

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


    );
  }
}
