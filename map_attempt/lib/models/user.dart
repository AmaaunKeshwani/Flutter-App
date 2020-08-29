import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {

  final String uid;
  CurrentUser({ this.uid});
  String userDetails() => uid;
}


class UserData_1 {

  final String uid;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String picture_url;
  final GeoPoint location;
  //final int strength;

  UserData_1({ this.uid, this.first_name, this.last_name, this.email, this.gender, this.picture_url, this.location, middle_name });

}


class UserData {

  final String uid;
  final String first_name;
  final String middle_name;
  final String last_name;
  final String email;
  final String CC;
  final String number;
  final String image;
  final String DOB;
  final GeoPoint location;
  final String Auth;
  //final String picture_url;
  //final int strength;

  UserData({ this.uid, this.first_name, this.middle_name, this.last_name, this.email, this.CC, this.number, this.image, this.DOB, this. location, this.Auth});

}

class UserIndustryData {

  final String uid;
  final String IndID;
  final String Duration;
  final String Start_Date;
  final String End_Date;

  UserIndustryData({ this.uid, this.IndID, this.Duration, this.Start_Date, this.End_Date});

}

class UserEducationData {

  final String uid;
  final String EduID;
  final String Completion_year;
  final String Course_ID;

  UserEducationData({ this.uid, this.EduID, this.Completion_year, this.Course_ID});

}