import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:map_attempt/services/auth.dart';
//import 'package:map_attempt/services/upload_picture.dart';
import 'package:map_attempt/shared/constants.dart';
import 'package:map_attempt/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String first_name = '';
  String last_name = '';
  String gender = '';
  String email = '';
  String password = '';
  String picture_url = '';
  String _uploadedFileURL;
  String image_name = '';
  StorageReference reference = FirebaseStorage.instance.ref().child('temp.jpg');
  dynamic _image;

  Future uploadFile () async{
    //print(_reference);
    //String temp = str(_reference);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    await uploadTask.onComplete;
    reference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
    print(_uploadedFileURL);
    //return(_uploadedFileURL);
    //print('File Uploaded');
    /*setState(() {
      reference.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
      });
      print('***********************');
      print('***********************');
      print(fileURL);
      print('***********************');
      print('***********************');
      return(fileURL);
    });*/
  }

  Future chooseFile() async {

    io.File image;
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      image_name = "$first_name-$last_name";
    });
    reference = FirebaseStorage.instance.ref().child('Pictures/${Path.basename(image_name)}.jpg');
    return(reference);
    //return(uploadFile());

  }

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
                    validator: (val) => val.isEmpty ? 'Enter your first name' : null,
                    onChanged: (val) {
                      setState(() => first_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                    validator: (val) => val.isEmpty ? 'Enter your last name' : null,
                    onChanged: (val) {
                      setState(() => last_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Gender'),
                    validator: (val) => val.isEmpty ? 'Enter your gender' : null,
                    onChanged: (val) {
                      setState(() => gender = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Upload Pictures',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() async {
                          reference = await chooseFile();
                        });

                        //print(picture_url);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() async {
                          picture_url = _uploadedFileURL;
                          await uploadFile();
                        });
                        print('***********************');
                        print('***********************');
                        print(picture_url);
                        print('***********************');
                        print('***********************');
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, first_name, last_name, gender, _uploadedFileURL);
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