import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileSkeleton extends StatefulWidget {
  const ListTileSkeleton({ Key? key }) : super(key: key);

  @override
  State<ListTileSkeleton> createState() => _ListTileSkeletonState();
}

class _ListTileSkeletonState extends State<ListTileSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffe9e8f3),
      highlightColor: const Color(0xffd6d4df),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 70,
        child: Row(
          children: <Widget> [
            Container(
              margin: const EdgeInsets.only(right: 14),
              child: const CircleAvatar(
                maxRadius: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                    Container(
                      height: 18,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}