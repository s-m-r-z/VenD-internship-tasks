import 'package:chat_app/chat/cubit/chat_cubit.dart';
import 'package:chat_app/chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateMessage extends StatefulWidget {
  const CreateMessage({Key? key}) : super(key: key);
  @override
  _CreateMessageState createState() => _CreateMessageState();
}

String? messageText;
String? to;

class _CreateMessageState extends State<CreateMessage> {
  List<Message>? messages;
  String? to;
  String? message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "To"),
              onChanged: (a) {
                to = a;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Message"),
              onChanged: (a) {
                message = a;
              },
            ),
            ElevatedButton(
              onPressed: message == null ||
                      to == null ||
                      message!.isEmpty ||
                      to!.isEmpty
                  ? null
                  : () =>
                      context.read<ChatCubit>().createMessage(to!, message!),
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
