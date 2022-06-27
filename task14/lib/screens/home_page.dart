import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task14/cubit/todo_cubit.dart';

import '../utlis/general_api_state.dart';
import 'add_todo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listenWhen: (previous, next) => previous.todoState != next.todoState,
      listener: (context, state) {
        if (state.todoState.apiCallState == APICallState.deleted &&
            state.lastDeletedTodo != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.lastDeletedTodo!.message} dismissed'),
            ),
          );
        }
      },
      buildWhen: (previous, next) => previous.todoState != next.todoState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: const Text("Todo List"),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoPage(),
                ),
              );
            },
            tooltip: "Add Todo",
            child: const Icon(Icons.add),
          ),
          body: state.todoState.model == null || state.todoState.model!.isEmpty
              ? const Center(child: Text("No Todos available"))
              : ListView.builder(
                  itemCount: state.todoState.model!.length,
                  itemBuilder: (context, index) {
                    final item = state.todoState.model![index].message;
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        context.read<TodoCubit>().deleteTodo(
                              state.todoState.model![index],
                            );
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(item[0]),
                        ),
                        title: Text(item),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
