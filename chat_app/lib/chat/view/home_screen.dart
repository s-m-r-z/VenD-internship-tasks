import 'package:chat_app/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'send_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatHomePage(),
    );
  }
}

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, next) => previous.chatState != next.chatState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions_sharp),
                label: 'Subscribe',
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SendMessage(),
                ),
              ),
            },
            tooltip: 'Start New Chat',
            child: const Icon(Icons.add),
          ),
          body: state.chatState.model == null || state.chatState.model!.isEmpty
              ? const Center(
                  child: Text("No Chat Available"),
                )
              : ListView.builder(
                  itemCount: state.chatState.model!.length,
                  itemBuilder: (context, index) {
                    final item = state.chatState.model![index].messages;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(item![index].id[0]),
                      ),
                      title: Text(item[index].message),
                      hoverColor: Colors.teal,
                      focusColor: Colors.teal,
                    );
                  }),
        );
      },
    );
    // This trailing comma makes auto-formatting nicer for build methods
  }
}
