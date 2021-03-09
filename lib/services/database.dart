import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collectionReference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String email, String name, int age) async {

  }
}