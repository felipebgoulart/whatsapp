import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mob_whatsapp/core/icons/ios_icons.dart';
import 'package:mob_whatsapp/pages/chats/chats_page.dart';
import 'package:mob_whatsapp/pages/home/controllers/home_controller.dart';
import 'package:mob_whatsapp/routes/routes.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final HomeController _homeController = HomeController();
  

  @override
  void initState() {
    super.initState();
    _homeController.isUserSigned(context);
  }

  void _signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => true
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(.5),
            width: .5
          )
        ),
        title: const Text('Chats'),
        leadingWidth: 100,
        leading: CupertinoButton(
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Color(0xff3478F7)
            ),
          ),
          onPressed: () async {
            FirebaseAuth auth = FirebaseAuth.instance;
            await auth.signOut();

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (_) => false
            );
          }
        ),
        elevation: Platform.isAndroid ? 4 : 0,
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.contacts),
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                IosIcons.edit,
                color: Color(0xff3478F7),
              ),
            ),
          )
        ],
      ),
      body: PageView(
        controller: _homeController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget> [
          Container(),
          Container(),
          Container(),
          const ChatsPage(),
          Container(),
        ],
      ),
      bottomNavigationBar: Observer(
        builder: (context) => Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: .5
              )
            )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _homeController.currentIndex,
            onTap: (int index) => _homeController.changePage(index),
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(IosIcons.status),
                label: 'Status',
              ),
              BottomNavigationBarItem(
                icon: Icon(IosIcons.calls),
                label: 'Calls'
              ),
              BottomNavigationBarItem(
                icon: Icon(IosIcons.camera),
                label: 'Camera'
              ),
              BottomNavigationBarItem(
                icon: Icon(IosIcons.chats),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                icon: Icon(IosIcons.settings),
                label: 'Settings'
              ),
            ]
          ),
        ),
      ),
    );
  }
}