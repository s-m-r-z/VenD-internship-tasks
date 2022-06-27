class Conversation {
  final List<Message>? messages;

  final String? id;

  const Conversation({
    this.messages,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'messages': messages?.map((e) => e.toJson()).toList(),
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> map, String docId) {
    return Conversation(
      messages: (map['messages'] as List?)
          ?.map(
            (e) => Message.fromJson(e),
          )
          .toList(),
      id: docId,
    );
  }
}

class Message {
  Message(
      {required this.message,
      required this.id,
      required this.timestamp,
      this.name});
  final String message;
  final String id;
  final String timestamp;
  final String? name;

  Map<String, String> toJson() {
    return {
      'message': message,
      'id': id,
      timestamp: 'timestamp',
      name!: 'name',
    };
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      id: map['id'],
      timestamp: map['timestamp'],
      name: map['name'],
    );
  }
}
