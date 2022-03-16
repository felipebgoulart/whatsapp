import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/core/models/chat.dart';
import 'package:mob_whatsapp/core/widgets/skeletons/list_tile_skeleton.dart';
import 'package:mob_whatsapp/pages/chats/controllers/chats_controller.dart';
import 'package:mob_whatsapp/pages/chats/widgets/chat_tile.dart';
import 'package:mob_whatsapp/pages/chats/widgets/empty_chat_list.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({ Key? key }) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final ChatsController _chatsController = ChatsController();

  @override
  void initState() {
    super.initState();
    _chatsController.chatListener();
  }

  @override
  void dispose() {
    super.dispose();
    _chatsController.controller.close();
  }

  Widget _listChats(QuerySnapshot? querySnapshot) {
    _chatsController.snapshotToChat(querySnapshot);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: const Text(
                'Broadcast List',
                style: TextStyle(
                  color: Color(0xff3478F7)
                ),
              ),
              onPressed: () => {}
            ),
            CupertinoButton(
              child: const Text(
                'New Group',
                style: TextStyle(
                  color: Color(0xff3478F7)
                ),
              ),
              onPressed: () => {}
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _chatsController.chatList.length,
            itemBuilder: (BuildContext context, int index) {
              Chat chat = _chatsController.chatList[index];

              return Slidable(
                key: ValueKey(index),
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xffC6C6CC),
                      foregroundColor: Colors.white,
                      icon: Icons.more_horiz_rounded,
                      label: 'More',
                    ),
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Color(0xff3E70A7),
                      foregroundColor: Colors.white,
                      icon: IosIcons.archiveIcon,
                      label: 'Archive',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _chatsController.goToChat(context, chat),
                  child: ChatTile(
                    chat: chat,
                  ),
                )
              );
            }
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatsController.controller.stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) => const ListTileSkeleton(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Text('Erro ao carregar dados');
            } else {
              QuerySnapshot? querySnapshot = snapshot.data;

              if (querySnapshot!.docs.isEmpty) {
                return const EmptyChatList();
              } else {
                return _listChats(querySnapshot);
              }
            }
        }
      }
    );
  }
}