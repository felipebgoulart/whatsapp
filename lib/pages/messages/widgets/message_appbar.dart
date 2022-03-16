import 'package:flutter/material.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/core/models/user.dart';

class MessageAppBar extends StatefulWidget with PreferredSizeWidget {
  final UserModel contact;
  
  const MessageAppBar({
    Key? key,
    required this.contact
  }) : super(key: key);

  @override
  State<MessageAppBar> createState() => _MessageAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, AppBar().preferredSize.height);
}

class _MessageAppBarState extends State<MessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: (widget.contact.imageUrl!.isNotEmpty && widget.contact.imageUrl != null) ? NetworkImage(widget.contact.imageUrl.toString()) : null,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.contact.name ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  'Tap here for contact info',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      actions: const <Widget> [
        Padding(
          padding: EdgeInsets.only(right: 32),
          child: Icon(
            IosIcons.videocall,
            size: 16,
            color: Color(0xff3478F7),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            IosIcons.calls,
            color: Color(0xff3478F7),
          ),
        ),
      ],
    );
  }
}