part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    this.todoState = const GeneralApiState(),
    this.lastDeletedTodo,
  });

  final GeneralApiState<List<Todo>> todoState;
  final Todo? lastDeletedTodo;

  TodoState copyWith({
    GeneralApiState<List<Todo>>? todoState,
    Todo? lastDeletedTodo,
  }) {
    return TodoState(
      todoState: todoState ?? this.todoState,
      lastDeletedTodo: lastDeletedTodo ?? this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [todoState, lastDeletedTodo];
}
