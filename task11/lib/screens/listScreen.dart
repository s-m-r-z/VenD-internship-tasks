import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task11/providers/provider.dart';

import 'addList.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        if (todoProvider.getTodos == null) {
          todoProvider.loadTodos();
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: const Text("Todo List"),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTodo())),
              tooltip: "Add Todo",
              child: const Icon(Icons.add),
            ),
            body: todoProvider.getTodos!.isEmpty
                ? const Center(child: Text("No Todos available"))
                : ListView.builder(
                    itemCount: todoProvider.getTodos!.length,
                    itemBuilder: (context, index) {
                      final item = todoProvider.getTodos![index].text;
                      return Dismissible(
                          key: Key(item),
                          onDismissed: (direction) {
                            todoProvider.removeTodo(index);

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$item dismissed')));
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(
                            title: Text(todoProvider.getTodos![index].text),
                          ));
                    },
                  ),
          );
        }
      },
    );
  }
}
