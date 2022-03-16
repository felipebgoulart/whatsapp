import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/routes/routes.dart';

class EmptyChatList extends StatelessWidget {
  const EmptyChatList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          child: Column(
            children: <Widget> [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24
                  ),
                  children: [
                    TextSpan(
                      text: 'To begin a new chat, simple tap on the '
                    ),
                    WidgetSpan(
                      child: Icon(
                        IosIcons.edit
                      )
                    ),
                    TextSpan(
                      text: ' icon in the top right conrner'
                    )
                  ]
                )
              ),
              const SizedBox(
                height: 64,
              ),
              const Text(
                'You can start chatting with contacts who already have Whatsapp installed on their phones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(.5)
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.5)
              )
            )
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: const Text(
              'Tell a friend about Whatsapp',
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, Routes.contacts),
          ),
        )
      ],
    );
  }
}