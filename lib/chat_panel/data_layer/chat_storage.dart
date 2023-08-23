import 'package:chitchat/authentication/data_layer/auth_storage.dart';
import 'package:chitchat/chat_panel/data_layer/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatStorage{
  final chatBot = FirebaseFirestore.instance.collection("Rooms");

  // Stream<ChatModel> getConversation(
  //   {
  //     required String roomName,
  //   }
  // ){
  //   final conversation = chatBot.doc(roomName).snapshots().map((event) => event.data()!.map((key, value) => ));   
  //   return conversation;
  // }

  Future sendMessage(
    {
      required String friendEmail,
      required String message,      
    }
  ) async{
    final String myEmail = AuthStorage().currentUser!.email;
    final Timestamp timestamp = Timestamp.now();
    ChatModel newMessage = ChatModel(
      senderEmail: myEmail,
      recieverEmail: friendEmail,
      message: message,
      timestamp: timestamp
    );
    List<String> mails = [myEmail,friendEmail];
    mails.sort();
    String chatRoomName = mails.join('_');
    await chatBot.doc(chatRoomName).collection("messages").add(newMessage.toMap());
  }

  Stream<QuerySnapshot>getMessages(
    {
      required String myEmail,
      required String friendEmail,
    } 

  ){
    List<String> mails = [myEmail,friendEmail];
    mails.sort();
    String chatRoomName = mails.join('_');
    return chatBot.doc(chatRoomName).collection("messages").orderBy("timestamp",descending: false).snapshots();
  }

}