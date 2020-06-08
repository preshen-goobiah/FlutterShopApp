import 'package:flutter/material.dart';
import './pages/login.dart';

// stateful widget for changing content like a product catalog
// stateless widget for static content like a login screen

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()
    )
  );
}

