import 'package:flutter/material.dart';
import 'package:mob_whatsapp/pages/chats.dart';
import 'package:mob_whatsapp/pages/contacts.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _controllerTab;

  @override
  void initState() {
    super.initState();
    _controllerTab = TabController(
      length: 2,
      vsync: this
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: const Text('Whatsapp'),
        bottom: TabBar(
          controller: _controllerTab,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          tabs: const <Widget>[
            Tab(text: 'Conversas'),
            Tab(text: 'Contatos')
          ],
        ),
      ),
      body: TabBarView(
        controller: _controllerTab,
        children: const <Widget>[
          Chats(),
          Contacts()
        ]
      )
    );
  }
}