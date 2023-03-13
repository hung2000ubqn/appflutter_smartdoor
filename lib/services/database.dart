import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference smartDoorCollection = FirebaseFirestore.instance.collection('users1');

  Future addUserDetails(String fullName, String email) async {
    await FirebaseFirestore.instance.collection('users1').add({
      'Full Name': fullName,
      'Email': email,
    });
    print(this.uid);
  }

  Future updateUserData(String fullName, String email) async {
    return await smartDoorCollection.doc(uid).set({
      'Full Name': fullName,
      'Email': email,
    });
  }

  //get stream
  /*Stream<QuerySnapshot> get hung {
    return smartDoorCollection.snapshots();
  }*/

}