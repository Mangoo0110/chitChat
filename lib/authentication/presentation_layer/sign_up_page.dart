import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/authentication/login.dart';
import 'package:chitchat/chat_panel/presentation_layer/chat_dashboard.dart';
import 'package:chitchat/user/data_layer/user_Storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpView extends StatelessWidget {
   SignUpView({super.key});

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text("Sign Up"),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _userEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
             
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  try {
                    await AuthStorage().createUser(email: _userEmailController.text,password: _passwordController.text);
                    await AuthStorage().login(email: _userEmailController.text, password: _passwordController.text);
                    await UserStorage().addUser(email: _userEmailController.text,name: _fullNameController.text);
                    final user = AuthStorage().currentUser;
                    if(user!=null){
                       Fluttertoast.showToast(msg: "Congrats, You are logged in.");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatList()));
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                  
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 48,
                  child: const Center(child:  Text('Sign Up',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),)),
                )
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginView()));
                  // Perform signup or password recovery here
                },
                child: const Text('Already have an account! LogIn here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
