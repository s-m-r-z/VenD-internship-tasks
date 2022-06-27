import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task14/model/model.dart';
import 'package:task14/repository/repository.dart';
import 'package:task14/utlis/general_api_state.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.repository}) : super(const TodoState()) {
    _todoSubscription = repository.streamTodos().listen(updatedTodo);
  }

  final TodoRepository repository;

  late final StreamSubscription<List<Todo>> _todoSubscription;

  @override
  Future<void> close() {
    _todoSubscription.cancel();
    return super.close();
  }

  void updatedTodo(List<Todo> todos) {
    emit(
      state.copyWith(
        todoState: GeneralApiState(
          model: todos,
          apiCallState: APICallState.loaded,
        ),
      ),
    );
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await repository.addTodo(todo);
    } catch (e) {
      emit(
        state.copyWith(
          todoState: GeneralApiState(
            model: state.todoState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await repository.deleteTodo(todo.docId!);
      emit(
        state.copyWith(
          lastDeletedTodo: todo,
          todoState: GeneralApiState(
            model: state.todoState.model,
            apiCallState: APICallState.deleted,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          todoState: GeneralApiState(
            model: state.todoState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}
