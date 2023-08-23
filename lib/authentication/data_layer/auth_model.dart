import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  late String email;
  late String password;
   AuthModel(
    {
      required this.email,
      required this.password
    }
  );
  factory AuthModel.fromFirebase(User user)=>AuthModel(
    email: user.email!,
    password: user.uid
  );
}