import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageList extends StatefulWidget {
  final String title;
  const MessageList({ Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();

}

class _MessageListState extends State<MessageList> {
  var messages = const [];

  Future loadMessageList() async{
    String content = await rootBundle.loadString('data/message.json');
    List collection = json.decode(content);
    // print(content);
    setState(() {
      messages = collection;
    });
  }

  void initState() {
    loadMessageList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index ) {
          var message = messages[index];
          return ListTile(
            title: Text(message['subject']),
            subtitle: Text(message['body']),

            leading: CircleAvatar(backgroundColor: Colors.cyan,
                child: Text('$index')),
          );
        },
      ),
    );
  }
}