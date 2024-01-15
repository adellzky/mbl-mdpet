import 'package:flutter/material.dart';
import 'ConsultationPage.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: const IconThemeData(color: Color.fromARGB(255, 164, 48, 118)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Send a message",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _handleSubmitted(_textController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        iconTheme: IconThemeData(color: Color(0XFFBE83B2)),
        title: Image.asset('assets/logo.png'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;

  ChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Text('User', style: Theme.of(context).textTheme.subtitle1),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 156, 209),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(text)),
            ),
          ],
        ),
      ),
    );
  }
}
