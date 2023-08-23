import 'package:chitchat/user/data_layer/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStorage{
  final userBot = FirebaseFirestore.instance.collection("Users");

  Future addUser({
    required String email,
    String? name
  }) async{
    await userBot.doc(email).set({
      'email':email,
      "name":name
    },SetOptions(merge: true));
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return userBot.snapshots();
  }

 
}