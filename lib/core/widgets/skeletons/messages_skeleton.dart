import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MessagesSkeleton extends StatefulWidget {
  const MessagesSkeleton({ Key? key }) : super(key: key);

  @override
  State<MessagesSkeleton> createState() => _MessagesSkeletonState();
}

class _MessagesSkeletonState extends State<MessagesSkeleton> {

  Widget _message() => Container(
    height: 42,
    width: MediaQuery.of(context).size.width / 1.5,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16)
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffe9e8f3),
      highlightColor: const Color(0xffd6d4df),
      child: Column(
        children: <Widget> [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Column(
                children: [
                  _message(),
                  const SizedBox(
                    height: 8
                  ),
                  _message(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  _message(),
                  const SizedBox(
                    height: 8
                  ),
                  _message(),
                ],
              ),
            ],
          )
        ],
      )
    );
  }
}