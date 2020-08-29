import 'package:map_attempt/screens/authenticate/register.dart';
import 'package:map_attempt/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:map_attempt/screens/home/register_t.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView:  toggleView);
    } else {
      return Register_1(toggleView:  toggleView);
    }
  }
}