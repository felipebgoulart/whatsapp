import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/widgets/skeletons/messages_skeleton.dart';
import 'package:mob_whatsapp/pages/messages/controllers/messages_controller.dart';
import 'package:mob_whatsapp/pages/messages/widgets/message_appbar.dart';
import 'package:mob_whatsapp/pages/messages/widgets/message_box.dart';

class MessagesPage extends StatefulWidget {
  final UserModel contact;

  const MessagesPage({
    Key? key,
    required this.contact
  }) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final MessagesController _messagesController = MessagesController();

  Widget _stream() => StreamBuilder(
    stream: _messagesController.streamController.stream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Column(
            children: const <Widget> [
              MessagesSkeleton(),  
              MessagesSkeleton(),  
              MessagesSkeleton(),  
            ],
          );
        case ConnectionState.active:
        case ConnectionState.done:
          QuerySnapshot? querySnapshot = snapshot.data;

          if (snapshot.hasError) {
            return const Text('Erro ao carregar dados');
          } else {
            return ListView.builder(
              controller: _messagesController.scrollController,
              itemCount: querySnapshot!.docs.length,
              itemBuilder: (BuildContext context, int index) {

                List<DocumentSnapshot> messages = querySnapshot.docs.toList();
                DocumentSnapshot item =  messages[index];

                Color messageColor = const Color(0xffd2ffa5);
                Alignment alignment = Alignment.centerRight;
                double maxWidth = MediaQuery.of(context).size.width * .8;

                if (_messagesController.loggedUserId != item['idUser']) {
                  alignment = Alignment.centerLeft;
                  messageColor = Colors.white;
                }

                return Align(
                  alignment: alignment,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      width: maxWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: messageColor,
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                      child: item['type'] == 'text'
                      ? Text(
                          item['message'],
                          style: const TextStyle(
                            fontSize: 18
                          ),
                        )
                      : Image.network(item['urlImage'])
                    ),
                  ),
                );
              }
            );
          }
       }
    },
  );

  @override
  void initState() {
    _messagesController.setContact(widget.contact);
    _messagesController.getUserData();
    super.initState();
  }

  @override
  void dispose() {
    _messagesController.streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(
        contact: widget.contact,
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/bg.png'),
                    fit: BoxFit.cover
                  )
                ),
                child: _stream(),
              ),
            ),
            MessageBox(
              messagesController: _messagesController
            )
          ],
        )
      ),
    );
  }
}