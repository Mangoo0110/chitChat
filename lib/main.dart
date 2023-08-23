import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/authentication/login.dart';
import 'package:chitchat/chat_panel/presentation_layer/chat_dashboard.dart';
import 'package:chitchat/constants/routeNames.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        loginRoute :(context) =>  LoginView(),
      },
      home:const  ViewDecider(),
      
    );
  }
}
class ViewDecider extends StatelessWidget {
  const ViewDecider({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthStorage().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user =AuthStorage().currentUser;
            if (user != null) {
              devtools.log('User is>>$user');
              
                devtools.log('email is verified');
                return const ChatList();
              
            } else {
              return LoginView();
            }

          // return const LoginView();

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }

  }


