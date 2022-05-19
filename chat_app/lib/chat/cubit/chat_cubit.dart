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
  }

  final ChatRepository repository;

  late final StreamSubscription<List<Conversation>> _chatSubscription;

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
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

  Future<void> sendMessage(String id, List<Message> messages) async {
    emit(
      state.copyWith(
        chatState: const GeneralApiState(apiCallState: APICallState.loading),
      ),
    );

    try {
      await repository.sendMessage(id, messages);
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
}
