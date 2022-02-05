import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/pages/chats.dart';
import 'package:mob_whatsapp/pages/contacts.dart';
import 'package:mob_whatsapp/routes/routes.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _controllerTab;
  final List<String> itemList = ['Configuracões', 'Deslogar'];

  @override
  void initState() {
    super.initState();
    _controllerTab = TabController(
      length: 2,
      vsync: this
    );
  }

  void onItemSelected(String item) {
    switch (item) {
      case 'Configuracões':
        Navigator.pushNamed(
          context,
          Routes.configuration
        );
        break;
      case 'Deslogar':
        _signOut();
        break;
    }
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
        backgroundColor: Theme.of(context).accentColor,
        title: const Text('Whatsapp'),
        bottom: TabBar(
          controller: _controllerTab,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          tabs: const <Widget>[
            Tab(text: 'Conversas'),
            Tab(text: 'Contatos')
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert,color: Colors.white),
            onSelected: onItemSelected,
            itemBuilder: (BuildContext context) {
              return itemList.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            }
          )
        ],
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