import 'dart:convert';

import 'package:chat_app/chat/model/chat_model.dart' as m;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  final firestore = FirebaseFirestore.instance;
  final fcm = FirebaseMessaging.instance;

  final users = FirebaseFirestore.instance.collection('users');
  final openMessages = FirebaseFirestore.instance.collection('openMessages');

  final auth = FirebaseAuth.instance;

  Stream<List<m.Conversation>> streamConversations() => users
      .doc(auth.currentUser!.uid)
      .collection("conversations")
      .snapshots()
      .map((event) => event.docs
          .map(
            (e) => m.Conversation.fromJson(e.data(), e.id),
          )
          .toList());

  Stream<List<m.Message>> streamOpenMessages() {
    return openMessages.snapshots().map((event) =>
        event.docs.map((e) => m.Message.fromJson(e.data())).toList());
  }

  Future<void> createFirstMessage(String receiverId, String message) async {
    final retreiveData =
        await users.where('email', isEqualTo: receiverId).get();

    if (retreiveData.docs.isEmpty) {
      throw Exception("User Not Found!");
    }

    final receiverUID = retreiveData.docs[0].data()["id"];
    final receiverName = retreiveData.docs[0].data()["name"];
    final receiverToken = retreiveData.docs[0].data()["token"];

    final getCurrentUser = await users.doc(auth.currentUser!.uid).get();

    final name = await getCurrentUser.data()!["name"];

    final conversationsData = await users
        .doc(auth.currentUser!.uid)
        .collection("conversations")
        .get();

    final conversations = conversationsData.docs
        .map((e) => m.Conversation.fromJson(e.data(), e.id))
        .toList();

    if (conversations.any((e) => e.id == receiverUID)) {
      throw Exception("Conversation already exist");
    }

    await users
        .doc(auth.currentUser!.uid)
        .collection("conversations")
        .doc(receiverUID)
        .set(m.Conversation(
          messages: [
            m.Message(
              id: auth.currentUser!.uid,
              message: message,
              timestamp: Timestamp.fromDate(DateTime.now()),
              name: name,
            ),
          ],
          name: receiverName,
        ).toJson());

    await users
        .doc(receiverUID)
        .collection("conversations")
        .doc(auth.currentUser!.uid)
        .set(m.Conversation(
          messages: [
            m.Message(
              id: auth.currentUser!.uid,
              message: message,
              timestamp: Timestamp.fromDate(DateTime.now()),
              name: name,
            )
          ],
          name: name,
        ).toJson());

    await sendNotification(receiverId, receiverToken, message);
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final retreiveData = await users.where('id', isEqualTo: receiverID).get();

    if (retreiveData.docs.isEmpty) {
      throw Exception("User Not Found!");
    }

    final receiverUID = retreiveData.docs[0].data()["id"];
    final receiverToken = retreiveData.docs[0].data()["token"];

    final getCurrentUser = await users.doc(auth.currentUser!.uid).get();

    final name = await getCurrentUser.data()!["name"];

    await users
        .doc(auth.currentUser!.uid)
        .collection("conversations")
        .doc(receiverUID)
        .update({
      'messages': FieldValue.arrayUnion([
        m.Message(
          id: auth.currentUser!.uid,
          message: message,
          timestamp: Timestamp.fromDate(DateTime.now()),
          name: name,
        ).toJson()
      ])
    });

    await users
        .doc(receiverUID)
        .collection("conversations")
        .doc(auth.currentUser!.uid)
        .update({
      'messages': FieldValue.arrayUnion([
        m.Message(
          id: auth.currentUser!.uid,
          message: message,
          timestamp: Timestamp.fromDate(DateTime.now()),
          name: name,
        ).toJson()
      ])
    });

    await sendNotification(receiverUID, receiverToken, message);
  }

  Future<void> sendNotification(
      String email, String fcm, String message) async {
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Authorization':
            'key=AAAAx9_sF5U:APA91bGYWILyvB_OXLeB-YljlW3J_xrZSZ5pXRq7ddBetU0rA-BGMgABh0yJO8F_jfbMdvTDJQrNuq868eNyXg2C85Vx6rAONLzmNwQDX5dd7zeFrIwQd0IdPxTj-b6BBAyRMc1kziNO'
      },
      body: jsonEncode(
        {
          "to": fcm,
          "notification": {
            "body": message,
            "title": "New Message!",
          },
        },
      ),
    );
  }

  Future<void> sendOpenMessage(String message) async {
    String senderId = auth.currentUser!.uid;

    final getCurrentUser = await users.doc(auth.currentUser!.uid).get();

    final name = await getCurrentUser.data()!["name"];

    openMessages.doc().set(m.Message(
          message: message,
          id: senderId,
          timestamp: Timestamp.fromDate(DateTime.now()),
          name: name,
        ).toJson());
    sendMessageToTopic();
  }

  Future<void> subscribeToTopic() async {
    fcm.subscribeToTopic('OpenChannel');
  }

  Future<void> unSubscribeToTopic() async {
    fcm.unsubscribeFromTopic('OpenChannel');
  }

  Future<void> sendMessageToTopic() async {
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Authorization':
            'key=AAAAx9_sF5U:APA91bGYWILyvB_OXLeB-YljlW3J_xrZSZ5pXRq7ddBetU0rA-BGMgABh0yJO8F_jfbMdvTDJQrNuq868eNyXg2C85Vx6rAONLzmNwQDX5dd7zeFrIwQd0IdPxTj-b6BBAyRMc1kziNO'
      },
      body: jsonEncode({
        "to": "/topics/OpenChannel",
        "collapse_key": "type_a",
        "notification": {
          "body": "Body : New Notification",
          "title": "Title : You have a new message from Open Channel",
        },
      }),
    );
  }

  Future<void> setValue(bool value) async {
    var preference = await SharedPreferences.getInstance();

    preference.setBool('subscription', value);
  }

  Future<bool> getValue() async {
    var preference = await SharedPreferences.getInstance();

    return preference.getBool('subscription') ?? true;
  }
}
