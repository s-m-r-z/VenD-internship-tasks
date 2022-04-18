import 'package:flutter/widgets.dart';
import 'package:task11/models/model.dart';
import 'package:task11/services/service.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo>? _todos;
  final LocalStorageService _localStorageService = LocalStorageService();

  List<Todo>? get getTodos => _todos;

  Future<void> loadTodos() async {
    _todos = await _localStorageService.getLocalTodos();
    notifyListeners();
  }

  Future<void> removeTodo(int id) async {
    if (_todos != null) {
      _todos!.removeWhere((todo) => todo.id == id);
      await _localStorageService.storeTodosLocally(_todos!);
      notifyListeners();
    }
  }

  Future<void> addTodo(String todo) async {
    if (_todos != null) {
      if (_todos!.isEmpty) {
        _todos!.add(Todo(id: 0, text: todo));
      } else {
        _todos!.add(Todo(id: _todos!.last.id + 1, text: todo));
      }
      await _localStorageService.storeTodosLocally(_todos!);
      notifyListeners();
    }
  }
}
