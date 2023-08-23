import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  late String message;
  late String senderEmail;
  late String recieverEmail;
  late Timestamp timestamp;
  ChatModel({
    required this.senderEmail,
    required this.recieverEmail,
    required this.message,
    required this.timestamp
  });
  factory ChatModel.fromSnapshot(Map<String,dynamic> conversation)=> ChatModel(
    senderEmail: conversation["senderEmail"].toString(),
    recieverEmail: conversation["recieverEmail"].toString(),
    message: conversation["message"].toString(),
    timestamp: conversation["timestamp"] as Timestamp,
    );
  Map<String,dynamic>toMap(){
    return{
    "senderEmail" : senderEmail,
    "recieverEmail" : recieverEmail,
    "message" : message,
    "timestamp": timestamp,
  };
  }
}