import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_attempt/models/user.dart';
import 'package:map_attempt/screens/authenticate/authenticate.dart';
import 'package:map_attempt/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CurrentUser>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
    
  }
}