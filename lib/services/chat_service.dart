import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //send a message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timeStamp: timestamp,
    );
    //create chat room id from current user id and receive id
    List<String> ids = [currentUserId, receiverId];
    //sort the ids so caht room id is always the same
    ids.sort();
    //combine the ids into a single string to use as a chatroomID
    String chatRoomId = ids.join("_");
    //add new message to teh database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //recive a message
  Stream<QuerySnapshot> getMessages(String userId, String otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatroomId = ids.join("_");
    return _fireStore
        .collection('chat_rooms')
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
