import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/chat/general_api_state.dart';
import 'package:chat_app/chat/model/chat_model.dart';
import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.repository}) : super(const ChatState()) {
    _chatSubscription = repository.streamConversations().listen(updatedChat);
    _openMessageSubscription =
        repository.streamOpenMessages().listen(updatedOpenMessages);
    isSubscribe();
  }

  final ChatRepository repository;

  late final StreamSubscription<List<Message>> _openMessageSubscription;

  late final StreamSubscription<List<Conversation>> _chatSubscription;

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    _openMessageSubscription.cancel();
    return super.close();
  }

  void updatedOpenMessages(List<Message> message) {
    emit(state.copyWith(
        openMessageState: GeneralApiState(
            model: message, apiCallState: APICallState.loaded)));
  }

  void updatedChat(List<Conversation> conversations) {
    emit(
      state.copyWith(
        chatState: GeneralApiState(
          model: conversations,
          apiCallState: APICallState.loaded,
        ),
      ),
    );
  }

  Future<void> sendMessage(String receiverId, String messages) async {
    emit(
      state.copyWith(
        chatState: const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.sendMessage(receiverId, messages);
      emit(
        state.copyWith(
          chatState: GeneralApiState(
            model: state.chatState.model,
            apiCallState: APICallState.loaded,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          chatState: GeneralApiState(
            model: state.chatState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> createMessage(String receiverId, String message) async {
    emit(
      state.copyWith(
        createMessageState:
            const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.createFirstMessage(receiverId, message);
      emit(
        state.copyWith(
          createMessageState:
              const GeneralApiState(apiCallState: APICallState.loaded),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          createMessageState: GeneralApiState(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> sendOpenMessages(String message) async {
    emit(
      state.copyWith(
        openMessageState:
            const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.sendOpenMessage(message);
    } catch (e) {
      emit(
        state.copyWith(
          openMessageState: GeneralApiState(
            model: state.openMessageState.model,
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }

  void changeIndex(int index) {
    emit(
      state.copyWith(selectedIndex: index),
    );
  }

  void subscribeToTopic() async {
    repository.subscribeToTopic();

    await repository.setValue(true);
    emit(
      state.copyWith(
        openChannelNotification: true,
      ),
    );
  }

  void isSubscribe() async {
    bool value = await repository.getValue();
    if (value) {
      repository.subscribeToTopic();
      emit(
        state.copyWith(
          openChannelNotification: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          openChannelNotification: false,
        ),
      );
    }
  }

  void unSubscribeToTopic() async {
    repository.unSubscribeToTopic();

    await repository.setValue(false);
    emit(
      state.copyWith(
        openChannelNotification: false,
      ),
    );
  }

  bool isMe(String id) => id == repository.auth.currentUser!.uid;

  bool isBot(int conversationIndex) =>
      state.chatState.model?[conversationIndex].id! == "bot";
}
