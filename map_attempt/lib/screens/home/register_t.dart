import 'dart:io' as io;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:map_attempt/services/arch.dart';
import 'package:map_attempt/services/auth.dart';
import 'package:map_attempt/shared/constants.dart';
import 'package:map_attempt/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';

class Register_1 extends StatefulWidget {

  final Function toggleView;
  Register_1({ this.toggleView });

  @override
  _Register_1State createState() => _Register_1State();
}

class _Register_1State extends State<Register_1> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  // text field state
  //String uid = String.fromCharCodes(Iterable.generate(10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  //String userID = String.fromCharCodes(Iterable.generate(7, (_) => _chars.codeUnitAt(Random.nextInt(_chars.length))));
  String userID = '1234567';
  //String industry_C_ID = String.fromCharCodes(Iterable.generate(7, (_) => _chars.codeUnitAt(Random.nextInt(_chars.length))));
  String industry_C_ID = '1234567';
  //String edu_C_ID = String.fromCharCodes(Iterable.generate(7, (_) => _chars.codeUnitAt(Random.nextInt(_chars.length))));
  String edu_C_ID = '1234567';
  String first_name = '';
  String middle_name = '';
  String last_name = '';
  String email = '';
  String password = '';
  String CC = '+91';
  String number = '';
  String image = '';
  String DOB = '';
  GeoPoint location;
  String Auth = '56%';
  List Following;
  String IndID = '123454';
  String Duration = '';
  String Start_Date = '';
  String End_Date = '';
  String EduID = '1234455';
  String Completion_year = '';
  String Course_ID = '4321';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 2000.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'First Name'),
                    //validator: (val) => val.isEmpty ? 'Enter your first name' : null,
                    onChanged: (val) {
                      setState(() => first_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Middle Name'),
                    //validator: (val) => val.isEmpty ? 'Enter your middle name' : null,
                    onChanged: (val) {
                      setState(() => middle_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                    //validator: (val) => val.isEmpty ? 'Enter your last name' : null,
                    onChanged: (val) {
                      setState(() => last_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    //validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    //validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Number'),
                    //validator: (val) => val.isEmpty ? 'Enter number' : null,
                    onChanged: (val) {
                      setState(() => number = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'DOB'),
                    //validator: (val) => val.isEmpty ? 'Enter your DOB' : null,
                    onChanged: (val) {
                      setState(() => DOB = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Duration'),
                    //validator: (val) => val.isEmpty ? 'Enter duration' : null,
                    onChanged: (val) {
                      setState(() => Duration = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Start Date'),
                    //validator: (val) => val.isEmpty ? 'Enter start date' : null,
                    onChanged: (val) {
                      setState(() => Start_Date = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'End Date'),
                    //validator: (val) => val.isEmpty ? 'Enter end date' : null,
                    onChanged: (val) {
                      setState(() => End_Date = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Completion Year'),
                    //validator: (val) => val.isEmpty ? 'Enter your completion year' : null,
                    onChanged: (val) {
                      setState(() => Completion_year = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        //await DatabaseService_1(industry_C_ID: industry_C_ID, edu_C_ID: edu_C_ID).updateUserData(userID, first_name, middle_name, last_name, email, CC, number, image, DOB, location, Auth, Following, IndID, Duration, Start_Date, End_Date, EduID, Completion_year, Course_ID);

                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.register_temp(industry_C_ID, edu_C_ID, userID, first_name, middle_name, last_name, email, password, CC, number, image, DOB, location, Auth, Following, IndID, Duration, Start_Date, End_Date, EduID, Completion_year, Course_ID);
                          if(result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),);
  }
}