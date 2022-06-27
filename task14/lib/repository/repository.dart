import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task14/model/model.dart';

class TodoRepository {
  final firestore = FirebaseFirestore.instance;
  final todos = FirebaseFirestore.instance.collection('todos');

  Stream<List<Todo>> streamTodos() => todos.snapshots().map((event) =>
      event.docs.map((e) => Todo.fromJson(e.data(), e.reference.id)).toList());

  Future<void> deleteTodo(String id) async {
    await todos
        .doc(id)
        .delete()
        .catchError((error) => throw "Failed to delete todo");
  }

  Future<void> addTodo(Todo todo) async {
    await todos
        .add(todo.toJson())
        .catchError((event) => throw "Can't add new todo due to error");
  }
}
