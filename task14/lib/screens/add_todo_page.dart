import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task14/cubit/todo_cubit.dart';

import '../model/model.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Add a new Todo"),
      ),
      body: TextField(
        autofocus: true,
        onSubmitted: (item) {
          context
              .read<TodoCubit>()
              .addTodo(
                Todo(
                  message: item,
                  timestamp: DateTime.now().toString(),
                ),
              )
              .then((value) => Navigator.of(context).pop());
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: "Enter Task",
        ),
      ),
    );
  }
}
