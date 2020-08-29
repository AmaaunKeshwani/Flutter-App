import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_attempt/services/arch.dart';
import 'package:map_attempt/services/database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_attempt/models/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //List<GeoPoint> location = <GeoPoint>[];
  GeoPoint _location;

  void _getCurrentLocation() async {
    //PermissionStatus permission = await LocationPermissions().requestPermissions();

    if (await Permission.locationWhenInUse
        .request()
        .isGranted) {
      final position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      //print(position);

      _location = GeoPoint(position.latitude, position.longitude);
      User user = await _auth.currentUser;
      print(user.uid);
      await DatabaseService_1(uid: user.uid).updateLocation(_location);
      //Location(position);
    }
  }

  // create user obj based on firebase user
  /*User _userFromFirebaseUser(UserCredential userCredential) {
    return user != null ? User(uid: result.user.uid) : null;
  }

  // auth change user stream
  Stream<User_1> get user {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        return(User_1(uid: user.uid));
      } else {
        return(null);
      }
    });
  }*/

  /*String _userFromFirebaseUser(User user) {
    print('********************');
    print('********************');
    print(user.uid);
    print('********************');
    print('********************');
    //return user != null ? User_1(uid: user.uid) : null;
    if (user != null) {
      return User_1(uid: user.uid).userDetails();
    } else {
      return null;
    }
  }

  // auth change user stream
  Stream<User_1> get user {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      return(_userFromFirebaseUser(user));
    });
  }*/

  CurrentUser _userFromFirebaseUser(User user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CurrentUser> get user {
    return _auth.authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser);
  }


  // sign in anon
  /*Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      //FirebaseUser user = result.user;
      //return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //FirebaseUser user = result.user;
      _getCurrentLocation();
      //await DatabaseService(uid: user.uid).updateLocation(location);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String first_name, String last_name, String gender, String picture_url) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //FirebaseUser user = result.user;
      print(result.user.uid);
      //FirebaseUser user_1 = await _auth.currentUser();
      //print(user_1.uid);
      print("${email}, ${password}, ${first_name}, ${last_name}, ${gender}, ${picture_url}");
      await DatabaseService(uid: result.user.uid).updateUserData(first_name, last_name, email, gender, picture_url);
      _getCurrentLocation();
      //return _userFromFirebaseUser(result.user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  //register with email and password
  Future register_temp(String industry_C_ID, String edu_C_ID, String userID, String first_name, String middle_name, String last_name, String email, String password, String CC, String number, String image, String DOB, GeoPoint location, String Auth, List Following, String IndID, String Duration, String Start_Date, String End_Date, String EduID, String Completion_year, String Course_ID) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //FirebaseUser user = result.user;
      print(result.user.uid);
      //FirebaseUser user_1 = await _auth.currentUser();
      //print(user_1.uid);
      //print("${email}, ${password}, ${first_name}, ${last_name}, ${gender}, ${picture_url}");
      //await DatabaseService(uid: user.uid).updateUserData(first_name, last_name, email, gender, picture_url);
      await DatabaseService_1(uid: result.user.uid, industry_C_ID: industry_C_ID, edu_C_ID: edu_C_ID).updateUserData(userID, first_name, middle_name, last_name, email, CC, number, image, DOB, location, Auth, Following, IndID, Duration, Start_Date, End_Date, EduID, Completion_year, Course_ID);
      _getCurrentLocation();
      //return _userFromFirebaseUser(result.user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}