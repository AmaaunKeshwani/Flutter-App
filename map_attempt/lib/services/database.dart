//import 'package:map_attempt/models/brew.dart';
import 'package:map_attempt/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String first_name, String last_name, String email, String gender, String picture_url) async {
    print("${uid}, ${email}, ${first_name}, ${last_name}, ${gender}");
    return await userCollection.doc(uid).set({
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'gender': gender,
      'picture_url':  picture_url,
      //'location': location,
    });
  }


  Future<void> updateLocation(GeoPoint location) async {
    return await userCollection.doc(uid).update({
      'location': location,
    });
  }



  // user data from snapshots
  UserData_1 _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData_1(
        uid: uid,
        first_name: snapshot.data()['first_name'],
        last_name: snapshot.data()['last_name'],
        email: snapshot.data()['email'],
        gender: snapshot.data()['gender'],
        picture_url: snapshot.data()['picture_url'],
        location: snapshot.data()['location']
    );
  }

  // get user doc stream
  Stream<UserData_1> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}