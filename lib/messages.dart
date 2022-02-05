import 'package:flutter/material.dart';
import 'package:mob_whatsapp/models/user.dart';

class Messages extends StatefulWidget {
  final UserModel contact;

  const Messages({
    Key? key,
    required this.contact
  }) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact.name ?? ''
        ),
      ),
      body: Container(),
    );
  }
}