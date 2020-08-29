import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_attempt/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class DatabaseService_1 {

  /*final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getUser() async {
    FirebaseUser user = await _auth.currentUser();
    return(user.uid);
  }*/

  final String uid;
  final String industry_C_ID;
  final String edu_C_ID;
  DatabaseService_1({ this.uid, this.industry_C_ID, this.edu_C_ID});

  //static final String uid_1 = uid;

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users_details');
  final CollectionReference User_Indus_Collection = FirebaseFirestore.instance.collection('users_industry');
  final CollectionReference User_Edu_Collection = FirebaseFirestore.instance.collection('users_education');
  /*final DocumentReference Indus_ref = Firestore.instance.collection('users_industry').document(uid_1);
  //final DocumentReference Indus_ID = Firestore.instance.User_Indus_Collection
  final DocumentReference Edu_ref = Firestore.instance.collection('users_educarion').document('$uid_1');*/

  Future<void> updateUserIndus(String IndID, String Duration, String Start_Date, String End_Date) async {
    //print("${uid}, ${email}, ${first_name}, ${last_name}, ${gender}");
    await User_Indus_Collection.doc(uid).set({
      //await Indus_ref.updateData({
      'Ind_C_ID': IndID,
      'Duration': Duration,
      'Start_Date': Start_Date,
      'End_date': End_Date,
    });
    //Indus_ID = User_Indus_Collection.document(uid).reference;
  }

  Future<void> updateUserEdu(String EduID, String Completion_year, String Course_ID) async {
    //print("${uid}, ${email}, ${first_name}, ${last_name}, ${gender}");
    // ignore: deprecated_member_use
    await User_Edu_Collection.document(uid).setData({
      'Edu_C_ID': EduID,
      'Completion_year': Completion_year,
      'Course_ID': Course_ID,
    });
  }


  Future<void> updateUserData(String userID, String first_name, String middle_name, String last_name, String email, String CC, String number, String image, String DOB, GeoPoint location, String Auth, List Following, String IndID, String Duration, String Start_Date, String End_Date, String EduID, String Completion_year, String Course_ID) async {
    print("${uid}, ${email}, ${first_name}, ${last_name}");
    updateUserIndus(IndID, Duration, Start_Date, End_Date);

    updateUserEdu(EduID, Completion_year, Course_ID);

    return await userCollection.doc(uid).set({
      'user_C_ID': userID,
      'first_name': first_name,
      'middle_name': middle_name,
      'last_name': last_name,
      'email': email,
      'CC': CC,
      'number': number,
      'image':  image,
      'DOB': DOB,
      //'industry': Indus_ref,
      'GeoTag': location,
      //'Following':  FieldValue.arrayUnion(Following),
      //'education':  Edu_ref,
      //'location': location,
    });
  }


  Future<void> updateLocation(GeoPoint location) async {
    return await userCollection.doc(uid).update({
      'GeoTag': location,
    });
  }


  Future<void> updatePicture(String image) async {
    return await userCollection.doc(uid).update({
      'image': image,
    });
  }


  // user data from snapshots
  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      first_name: snapshot.data()['first_name'],
      middle_name: snapshot.data()['middle_name'],
      last_name: snapshot.data()['last_name'],
      email: snapshot.data()['email'],
      CC: snapshot.data()['CC'],
      number: snapshot.data()['number'],
      image: snapshot.data()['image'],
      DOB: snapshot.data()['DOB'],
      location: snapshot.data()['Geotag'],
      Auth: snapshot.data()['Auth'],
      //Following: snapshot.data['Following'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    // ignore: deprecated_member_use
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // user data from snapshots
  UserIndustryData _userIndustryDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserIndustryData(
        uid: uid,
        IndID: snapshot.data()['Indus_C_ID'],
        Duration: snapshot.data()['Duration'],
        Start_Date: snapshot.data()['Start_Date'],
        End_Date: snapshot.data()['End_Date']
    );
  }


  Stream<UserIndustryData> get userIndustryData {
    return User_Indus_Collection.doc(uid).snapshots()
        .map(_userIndustryDataFromSnapshot);
  }

  UserEducationData _userEducationDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserEducationData(
        uid: uid,
        EduID: snapshot.data()['Edu_C_ID'],
        Completion_year: snapshot.data()['Completion_year'],
        Course_ID: snapshot.data()['Course_ID']
    );
  }


  Stream<UserEducationData> get userEducationData {
    return User_Edu_Collection.doc(uid).snapshots()
        .map(_userEducationDataFromSnapshot);
  }

}