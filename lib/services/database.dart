import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference smartDoorCollection = FirebaseFirestore.instance.collection('smartdoor');

  Future updateUserData(String name, String id, int warning) async {
    return await smartDoorCollection.doc(uid).set({
      'name': name,
      'id': id,
      'warning': warning,
    });
  }

  //get stream
  /*Stream<QuerySnapshot> get hung {
    return smartDoorCollection.snapshots();
  }*/

}