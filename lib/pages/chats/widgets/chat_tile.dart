import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/core/models/chat.dart';

class ChatTile extends StatefulWidget {
  final Chat chat;

  const ChatTile({
    Key? key,
    required this.chat
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      height: 88,
      child: Row(
        children: <Widget> [
          Container(
            margin: const EdgeInsets.only(right: 14),
            child: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: widget.chat.photoPath.isNotEmpty ? NetworkImage(widget.chat.photoPath) : null,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              Text(
                                widget.chat.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                              Text(DateFormat('dd/MM/yyyy').format(widget.chat.dateTime).toString()),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              const Padding(
                                padding: EdgeInsets.only(right: 12, top: 5),
                                child: Icon(
                                  IosIcons.read,
                                  size: 12,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.chat.message,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    height: 1.5,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black54
                                  ),
                                )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.black26,
                    ),
                  )
                ],
              )
            )
          )
        ],
      ),
    );
  }
}