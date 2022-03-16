// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactsController on _ContactsControllerBase, Store {
  final _$contactsAtom = Atom(name: '_ContactsControllerBase.contacts');

  @override
  List<UserModel> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<UserModel> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  final _$foundContactsAtom =
      Atom(name: '_ContactsControllerBase.foundContacts');

  @override
  List<UserModel> get foundContacts {
    _$foundContactsAtom.reportRead();
    return super.foundContacts;
  }

  @override
  set foundContacts(List<UserModel> value) {
    _$foundContactsAtom.reportWrite(value, super.foundContacts, () {
      super.foundContacts = value;
    });
  }

  final _$_ContactsControllerBaseActionController =
      ActionController(name: '_ContactsControllerBase');

  @override
  void filterContact(String filter) {
    final _$actionInfo = _$_ContactsControllerBaseActionController.startAction(
        name: '_ContactsControllerBase.filterContact');
    try {
      return super.filterContact(filter);
    } finally {
      _$_ContactsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
foundContacts: ${foundContacts}
    ''';
  }
}
