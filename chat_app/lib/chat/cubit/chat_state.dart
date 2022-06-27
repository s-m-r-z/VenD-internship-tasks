part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chatState = const GeneralApiState(),
    this.lastDeletedChat,
  });

  final GeneralApiState<List<Conversation>> chatState;
  final Conversation? lastDeletedChat;

  ChatState copyWith({
    GeneralApiState<List<Conversation>>? chatState,
    Conversation? lastDeletedTodo,
  }) {
    return ChatState(
      chatState: chatState ?? this.chatState,
      lastDeletedChat: lastDeletedTodo ?? lastDeletedChat,
    );
  }

  @override
  List<Object?> get props => [chatState, lastDeletedChat];
}
