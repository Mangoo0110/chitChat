import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/authentication/presentation_layer/sign_up_page.dart';
import 'package:chitchat/chat_panel/presentation_layer/chat_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_outline, size: 100, color: Colors.blue),
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
                    await AuthStorage().login(email: _userEmailController.text, password: _passwordController.text);
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
                  child: const Center(child:  Text('Login',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),)),
                )
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpView()));
                },
                child: const Center(child: Text('Dont have an account? SignUp here.')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(LoginApp());
// }

// class LoginApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Icon(Icons.lock_outline, size: 100, color: Colors.blue),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Perform login logic here
//                 },
//                 child: Text('Login'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Perform signup or password recovery here
//                 },
//                 child: Text('Forgot Password?'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
