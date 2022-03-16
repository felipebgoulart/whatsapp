import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/widgets/skeletons/list_tile_skeleton.dart';
import 'package:mob_whatsapp/pages/contacts/controllers/contacts_controller.dart';
import 'package:mob_whatsapp/routes/routes.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({ Key? key }) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final ContactsController _contactsController = ContactsController();

  PreferredSizeWidget _contactsAppBar() {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.withOpacity(.5),
          width: .5
        )
      ),
      leading: Container(),
      title: const Text('New Chat'),
      actions: [
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context)
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Container(
          height: 55,
          padding: const EdgeInsets.only(bottom: 12, right: 16, left: 16),
          child: TextField(
            onChanged: (String value) => _contactsController.filterContact(value),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              fillColor: const Color(0xffe8e8ea),
              filled: true,
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              )
            ),
          ),
        ),
      )
    );
  }

  Widget _contactsList(List<UserModel>? contactList) {
    return Observer(
      builder: (_) => Expanded(
        child: ListView.builder(
          itemCount: _contactsController.foundContacts.length,
          itemBuilder: (context, index) {
            UserModel user = _contactsController.foundContacts[index];

            return GestureDetector(
              onTap: () => {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.messages,
                  arguments: user
                )
              },
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: (user.imageUrl!.isNotEmpty && user.imageUrl != null) ? NetworkImage(user.imageUrl.toString()) : null
                ),
                title: Text(
                  user.name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                subtitle: const Text(
                  'Hey there! I am using Whatsapp.',
                  style: TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis
                  )
                ),
              ),
            );
          },
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _contactsAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: _contactsController.getContacts(),
              builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) => const ListTileSkeleton(),
                      ),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return _contactsList(snapshot.data);
                    } else {
                      return Container();
                    }
                  }
              },
            )
          ],
        ),
      ),
    );
  }
}