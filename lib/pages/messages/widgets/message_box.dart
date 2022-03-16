import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/pages/messages/controllers/messages_controller.dart';

class MessageBox extends StatefulWidget {
  final MessagesController messagesController;

  const MessageBox({
    Key? key,
    required this.messagesController
  }) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.add,
              color: Color(0xff3478F7),
              size: 36,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: widget.messagesController.controllerMessages,
                focusNode: widget.messagesController.messageNode,
                autofocus: false,
                onChanged: (_) {
                  setState(() {
                    
                  });
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 20
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  hintText: 'Mensagem',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(.5)
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(.5)
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(.5)
                    )
                  ),
                  suffixIcon: GestureDetector(
                    onTap: widget.messagesController.sendImage,
                    child: const Icon(
                      IosIcons.sticker,
                      color: Color(0xff3478F7),
                    ),
                  )
                ),
              ),
            )
          ),
          widget.messagesController.controllerMessages.text.isNotEmpty
          ? CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: const Text('Enviar'),
              onPressed: () => widget.messagesController.sendMessage()
            )
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () => {},
                    child: const Icon(
                      IosIcons.camera,
                      color: Color(0xff3478F7),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: GestureDetector(
                    onTap: () => {},
                    child: const Icon(
                      IosIcons.voiceRecord,
                      color: Color(0xff3478F7),
                    )
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}