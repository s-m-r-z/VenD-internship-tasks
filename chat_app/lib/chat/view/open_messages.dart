// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:chat_app/chat/view/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit.dart';

// ignore: must_be_immutable
class OpenMessage extends StatelessWidget {
  OpenMessage({Key? key}) : super(key: key);

  final messageController = TextEditingController();
  String? messageText;
  String? toText;

  final toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, next) =>
          previous.openMessageState != next.openMessageState,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              const NotificationSetting(),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.openMessageState.model?.length ?? 0,
                    itemBuilder: (context, index) {
                      final messageBubble = MessageBubble(
                        sender: state.openMessageState.model![index].id,
                        text: state.openMessageState.model![index].message,
                        isMe: context
                            .read<ChatCubit>()
                            .isMe(state.openMessageState.model![index].id),
                      );

                      return messageBubble;
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: messageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ChatCubit>().sendOpenMessages(messageText!);
                    },
                    child: const Text(
                      'Send',
                      style: sendButtonTextStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          previous.openChannelNotification != current.openChannelNotification,
      builder: (context, state) {
        return ColoredBox(
          color: Colors.lightBlue.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications"),
                Switch(
                    value: state.openChannelNotification,
                    onChanged: (value) {
                      if (value) {
                        context.read<ChatCubit>().subscribeToTopic();
                      } else {
                        context.read<ChatCubit>().unSubscribeToTopic();
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({this.sender, this.text, this.isMe});

  final String? sender;
  final String? text;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender!,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe! ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text!,
                style: TextStyle(
                  color: isMe! ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
