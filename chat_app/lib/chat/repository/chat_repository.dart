import 'package:chat_app/chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final firestore = FirebaseFirestore.instance;

  final users = FirebaseFirestore.instance.collection('users');

  final auth = FirebaseAuth.instance;

  Stream<List<Conversation>> streamConversations() => users
      .doc(auth.currentUser!.uid)
      .collection("conversations")
      .snapshots()
      .map((event) => event.docs
          .map(
            (e) => Conversation.fromJson(e.data(), auth.currentUser!.uid),
          )
          .toList());

  Future<void> createFirstMessage(String id, List<Message> message) async {
    await users
        .doc(id)
        .collection("conversations")
        .add(Conversation(id: id, messages: message).toJson());
  }

  Future<void> sendMessage(String id, List<Message> message) async {
    await users.doc(id).collection("conversations").doc(id).set(
          Conversation(id: id, messages: message).toJson(),
        );
  }
}
