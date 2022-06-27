part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.chatState = const GeneralApiState(),
    this.createMessageState = const GeneralApiState(),
    this.openMessageState = const GeneralApiState(),
    this.selectedIndex = 0,
    this.openChannelNotification = true,
  });
  final GeneralApiState<List<Conversation>> chatState;
  final GeneralApiState<void> createMessageState;
  final GeneralApiState<List<Message>> openMessageState;
  final int selectedIndex;
  final bool openChannelNotification;

  ChatState copyWith({
    GeneralApiState<List<Conversation>>? chatState,
    GeneralApiState<void>? createMessageState,
    int? selectedIndex,
    bool? openChannelNotification,
    GeneralApiState<List<Message>>? openMessageState,
  }) {
    return ChatState(
      chatState: chatState ?? this.chatState,
      createMessageState: createMessageState ?? this.createMessageState,
      openMessageState: openMessageState ?? this.openMessageState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      openChannelNotification:
          openChannelNotification ?? this.openChannelNotification,
    );
  }

  @override
  List<Object?> get props => [
        chatState,
        createMessageState,
        openMessageState,
        selectedIndex,
        openChannelNotification,
      ];
}
