import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_attempt/screens/map/load_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_attempt/services/arch.dart';
import 'package:map_attempt/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_attempt/services/database.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  Position location;

  Home({this.location});

  @override
  _HomeState createState() => _HomeState(location);
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _auth_1 = FirebaseAuth.instance;

  String _locationMessage = "";
  Position location;
  GeoPoint _location;

  _HomeState(Position loc){
    this.location = loc;
  }

  String picture_url = '';
  String _uploadedFileURL;
  String image_name = '';
  ImagePicker imagePicker = ImagePicker();
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
    User user = await _auth_1.currentUser;
    await DatabaseService_1(uid: user.uid, industry_C_ID: '' , edu_C_ID: '').updatePicture(_uploadedFileURL);
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

    File image;
    //imagePicker = ImagePicker;
    //image = await imagePicker.getImage(source: ImageSource.gallery) as io.File;
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedImage.path);
    User user = await _auth_1.currentUser;
    String uid = user.uid;
    setState(() {
      _image = image;
      reference = FirebaseStorage.instance.ref().child('Pictures/${Path.basename(uid)}.jpg');
      //image_name = "$first_name-$last_name";
    });
    //reference = FirebaseStorage.instance.ref().child('Pictures/${Path.basename(uid)}.jpg');
    //return(reference);
    print(reference);
    await uploadFile();

  }
  /*void Location(position){
    setState(() => location = position);
  }*/


  void _getCurrentLocation() async {
    //PermissionStatus permission = await LocationPermissions().requestPermissions();

    if (await Permission.locationWhenInUse
        .request()
        .isGranted) {
      final position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("-----------");
      print("-----------");
      print(position);
      print("-----------");
      print("-----------");

      setState(() {
        _locationMessage = "${position.latitude}, ${position.longitude}";
        location = position;
      });
      _location = GeoPoint(position.latitude, position.longitude);
      User user = await _auth_1.currentUser;
      await DatabaseService_1(uid: user.uid).updateLocation(_location);
      //Location(position);
    }
  }


  var _map = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  _map == 0?
      Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text('Map Attempt'),
          backgroundColor: Colors.black,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () async {
                //await _getCurrentLocation();
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                  icon: Icon(
                    Icons.image
                  ),
                  label: Text('Set a profile picture'),
                  onPressed: () {
                    setState(() {
                      _map = 0;
                    });
                    chooseFile();
                  }
                ),
                  RaisedButton.icon(
                      icon: Icon(
                          Icons.map
                      ),
                      label: Text('Show Map'),
                      onPressed: () async {
                        await _getCurrentLocation();
                        setState(() {
                          _map = 1;
                        });
                      }
                  )
                ],
              ),
            )

        ),
      )
          :_map == 1?
      Scaffold(
          body: LoadMap(location: location,)
      )
          :Container(),
    );
  }
}