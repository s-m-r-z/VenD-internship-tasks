import 'package:chat_app/app/app.dart';
import 'package:chat_app/chat/cubit/chat_cubit.dart';
import 'package:chat_app/chat/view/chat_detail.dart';
import 'package:chat_app/chat/view/create_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'open_messages.dart';

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
  Widget _body(int selectedIndex) {
    if (selectedIndex == 0) {
      return const HomePage();
    } else if (selectedIndex == 1) {
      return OpenMessage();
    } else if (selectedIndex == 2) {
      return Center(
        child: ElevatedButton(
            child: const Text("Logout"),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested())),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, next) =>
          previous.chatState != next.chatState ||
          previous.chatState.model != null,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Chats'),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Open Channel',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<ChatCubit>().changeIndex(index);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state.selectedIndex != 0
              ? null
              : FloatingActionButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateMessage(),
                      ),
                    ),
                  },
                  tooltip: 'Start New Chat',
                  child: const Icon(Icons.add),
                ),
          body: _body(state.selectedIndex),
        );
      },
    );
    // This trailing comma makes auto-formatting nicer for build methods
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, next) =>
          previous.chatState != next.chatState ||
          previous.chatState.model != null,
      builder: (context, state) {
        return Container(
          child: state.chatState.model == null || state.chatState.model!.isEmpty
              ? const Center(
                  child: Text("No Chat Available"),
                )
              : ListView.builder(
                  itemCount: state.chatState.model!.length,
                  itemBuilder: (context, index) {
                    final item = state.chatState.model![index].name;
                    if (item == null || item.isEmpty) {
                      return const SizedBox();
                    }
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          item[index].substring(0, 1),
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatDetail(conversationIndex: index)),
                      ),
                      title: Text(item),
                      hoverColor: Colors.teal,
                      focusColor: Colors.teal,
                    );
                  },
                ),
        );
      },
    );
  }
}
