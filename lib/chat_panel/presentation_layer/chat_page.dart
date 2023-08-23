import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/chat_panel/data_layer/chat_model.dart';
import 'package:chitchat/chat_panel/data_layer/chat_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String friendEmail;
  final String friendName;
  const ChatPage({super.key,required this.friendEmail,required this.friendName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatStorage _chatGuy = ChatStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future sendMessage()async{
    if(_messageController.text.isNotEmpty){
      await _chatGuy.sendMessage(friendEmail: widget.friendEmail, message: _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:  Center(child: Text(widget.friendName,style: TextStyle(color: Colors.black,fontStyle: FontStyle.normal,fontWeight: FontWeight.normal),)),
      ),
      body: Column(
        children: [
          Divider( thickness: 2,),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(children: [
                Expanded(
                  child: _messageList(),
                ),
                _messageInput(),
              ]),
            ),
          ),
        ],
      ),
    );
  }


  Widget _messageList(){
    return StreamBuilder(
      stream: _chatGuy.getMessages(myEmail: AuthStorage().currentUser!.email, friendEmail: widget.friendEmail),
      builder: (context,snapshot) {
        if(snapshot.hasError){
              return  Center(child: Text("Some errors...${snapshot.error}"),);
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: Text("Loading..."));
            }
            return ListView(
              children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
            );
      }
      );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    final data = document.data() as Map<String,dynamic>;

    var alignment =  (data["senderEmail"]!=AuthStorage().currentUser!.email)? Alignment.centerLeft : Alignment.centerRight;
    Color? messageBoxColor = (data["senderEmail"]!=AuthStorage().currentUser!.email)? Colors.blue[400]:Colors.green[400];
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 70,
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            color: messageBoxColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(data["message"],style: const TextStyle(color: Colors.white,fontSize: 15),),
          ),
        ),
      ),
    );
  }

  Widget _messageInput(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter message...",
                hintStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
          )
          ,),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: SizedBox(
              height: 40,
              width: 55,
              child: GestureDetector(
                onTap: (){
                  sendMessage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("Send",style: TextStyle(color: Colors.white,),)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}