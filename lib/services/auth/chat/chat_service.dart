import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/class/model/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send messages
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: timestamp);
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages

//Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {

  Future<String> createChatRoomId(
      String currentUserUid, String otherUserUid) async {
    List<String> ids = [currentUserUid, otherUserUid];
    ids.sort();
    String chatRoomId = ids.join("_");
    return chatRoomId;
  }

  // List<String> ids = [userId, otherUserId];
  // ids.sort();
  // String chatRoomId = ids.join("_");

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
        
  }

}
