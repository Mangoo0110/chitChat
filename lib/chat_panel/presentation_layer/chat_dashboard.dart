import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/authentication/login.dart';
import 'package:chitchat/chat_panel/presentation_layer/chat_page.dart';
import 'package:chitchat/chat_panel/presentation_layer/myDetailsView.dart';
import 'package:chitchat/constants/routeNames.dart';
import 'package:chitchat/user/data_layer/user_Storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}
String myName ='';
class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              AuthStorage().logOut();
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginView()));
            }, icon: const Icon(Icons.logout,color: Colors.blue,))
        ],
        backgroundColor: Colors.black,
        title: Center(child: Text("Chit Chat",style: TextStyle(color: Colors.green.shade400,fontWeight: FontWeight.bold,fontSize: 20),)),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder(
          stream: UserStorage().getAllUsers(),
          builder:(context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("Some errors..."),);
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: Text("Loading..."));
            }
            return ListView(
              children: snapshot.data!.docs.
              map<Widget>((doc) => userListItem(doc)).toList()
            );
          },
        ),
      ),
    );
  }
  Widget userListItem(DocumentSnapshot doc){

    Map<String,dynamic> data = doc.data()! as  Map<String,dynamic>;
    print(AuthStorage().currentUser!.email);
    if(AuthStorage().currentUser!.email==data['email']){
      myName = data['email'];
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatPage(friendEmail: data['email'],friendName: data['name'])));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.person),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text((data['name']=='')?data['email']: data['name']),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatPage(friendEmail: data['email'],friendName: data['name'],)));
            },
          ),
        ),
      );
    }
    return Container();
  }
}