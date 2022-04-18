import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task11/providers/provider.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Add a new Todo"),
      ),
      body: TextField(
        autofocus: true,
        onSubmitted: (item) async {
          await todoProvider.addTodo(item);
          Navigator.pop(context);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: "Enter Task",
        ),
      ),
    );
  }
}
