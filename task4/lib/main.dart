import 'package:flutter/material.dart';

void main() {
  runApp(const FriendlyChatApp());
}

String _name = "Your Name";
final ThemeData theme = ThemeData(
  primaryColor: Colors.grey,
  primarySwatch: Colors.pink,
);

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Chat Application', home: ChatScreen());
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {required this.text, required this.animationController, Key? key})
      : super(key: key);
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: Text(_name[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(text),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    _textController.dispose();
    super.dispose();

  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    var message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Send a Message'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () =>
                  _isComposing ? _handleSubmitted(_textController.text) : null,
              color: Colors.blue,
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat Friendly'),
      ),
      body: Column(
        children: [
          // NEW
          Flexible(
            // NEW
            child: ListView.builder(
              // NEW
              padding: const EdgeInsets.all(8.0), // NEW
              reverse: true, // NEW
              itemBuilder: (_, index) => _messages[index], // NEW
              itemCount: _messages.length, // NEW
            ), // NEW
          ), // NEW
          const Divider(height: 1.0), // NEW
          Container(
            // NEW
            decoration:
                BoxDecoration(color: Theme.of(context).cardColor), // NEW
            child: _buildTextComposer(), // MODIFIED
          ), // NEW
        ], // NEW
      ),
    );
  }
}
