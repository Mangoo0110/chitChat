import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  late String email;
  late String? fullName;
   UserModel(
    {
      required this.email,
      String? this.fullName
    }
  );
  factory UserModel.fromSnapShot(Map<String, String> friend)=>UserModel(
    email: friend["email"].toString(),
    fullName: friend["fullName"].toString()
  );
}