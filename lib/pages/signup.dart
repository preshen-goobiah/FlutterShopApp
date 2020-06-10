import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home.dart';



class Signup extends StatefulWidget {



  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String gender;
  String groupValue = 'male';

  bool loading = false;

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
                              hintText: "Name",
                              icon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _nameTextController,

                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,10,10),
                      child: Container(
                        color: Colors.white.withOpacity(0.4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text("male", style: TextStyle(color: Colors.white,),
                                    textAlign: TextAlign.end
                                ),
                                trailing: Radio(
                                  value: "male",

                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e),
                                ),

                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text("female", style: TextStyle(color: Colors.white,),
                                    textAlign: TextAlign.end
                                ),
                                trailing: Radio(
                                  value: "female",

                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e),
                                ),

                              ),
                            ),


                          ],
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
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0,

                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              icon: Icon(Icons.lock_outline),


                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: _confirmPasswordController,


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
                              child: Text("Sign Up", textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),)
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("Login", textAlign: TextAlign.center,style: TextStyle(color: Colors.white))
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

  valueChanged(e) {
    setState(() {
      if(e == "male")
        {
          groupValue = e;
        }
      else if(e == "female"){
        groupValue = e;
      }
    });
  }
}
