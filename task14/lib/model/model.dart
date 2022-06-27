class Todo {
  final String message;
  final String timestamp;
  final String? docId;

  const Todo({required this.message, required this.timestamp, this.docId});

  factory Todo.fromJson(Map<String, dynamic> map, String docId) {
    return Todo(
      message: map['message'],
      timestamp: map['timestamp'],
      docId: docId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'timestamp': timestamp};
  }
}
