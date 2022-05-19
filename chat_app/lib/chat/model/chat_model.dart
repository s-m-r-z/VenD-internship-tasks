class Conversation {
  final List<Message>? messages;

  final String? id;

  const Conversation({this.messages, this.id});

  Map<String, dynamic> toJson() {
    return {'messages': messages?.map((e) => e.toJson()).toList()};
  }

  factory Conversation.fromJson(Map<String, dynamic> map, String docId) {
    return Conversation(
      messages: map['message'],
      id: docId,
    );
  }
}

class Conversations {
  final List<Conversation>? conversations;

  const Conversations({this.conversations});

  factory Conversations.fromJson(List map) {
    return Conversations(
        conversations: map.map((e) => Conversation.fromJson(e, "")).toList());
  }
}

class Message {
  Message({required this.message, required this.id});
  final String message;
  final String id;

  Map<String, String> toJson() {
    return {'messages': message, 'id': id};
  }

  factory Message.fromJson(Map<String, dynamic> map, String docId) {
    return Message(
      message: map['message'],
      id: docId,
    );
  }
}
