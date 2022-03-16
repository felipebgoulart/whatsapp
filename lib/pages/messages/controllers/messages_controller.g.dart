// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesController on _MessagesControllerBase, Store {
  final _$controllerMessagesAtom =
      Atom(name: '_MessagesControllerBase.controllerMessages');

  @override
  TextEditingController get controllerMessages {
    _$controllerMessagesAtom.reportRead();
    return super.controllerMessages;
  }

  @override
  set controllerMessages(TextEditingController value) {
    _$controllerMessagesAtom.reportWrite(value, super.controllerMessages, () {
      super.controllerMessages = value;
    });
  }

  final _$loggedUserIdAtom = Atom(name: '_MessagesControllerBase.loggedUserId');

  @override
  String? get loggedUserId {
    _$loggedUserIdAtom.reportRead();
    return super.loggedUserId;
  }

  @override
  set loggedUserId(String? value) {
    _$loggedUserIdAtom.reportWrite(value, super.loggedUserId, () {
      super.loggedUserId = value;
    });
  }

  final _$targetUserIdAtom = Atom(name: '_MessagesControllerBase.targetUserId');

  @override
  String? get targetUserId {
    _$targetUserIdAtom.reportRead();
    return super.targetUserId;
  }

  @override
  set targetUserId(String? value) {
    _$targetUserIdAtom.reportWrite(value, super.targetUserId, () {
      super.targetUserId = value;
    });
  }

  final _$loggedUserNameAtom =
      Atom(name: '_MessagesControllerBase.loggedUserName');

  @override
  String? get loggedUserName {
    _$loggedUserNameAtom.reportRead();
    return super.loggedUserName;
  }

  @override
  set loggedUserName(String? value) {
    _$loggedUserNameAtom.reportWrite(value, super.loggedUserName, () {
      super.loggedUserName = value;
    });
  }

  final _$contactAtom = Atom(name: '_MessagesControllerBase.contact');

  @override
  UserModel? get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(UserModel? value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MessagesControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$messageNodeAtom = Atom(name: '_MessagesControllerBase.messageNode');

  @override
  FocusNode get messageNode {
    _$messageNodeAtom.reportRead();
    return super.messageNode;
  }

  @override
  set messageNode(FocusNode value) {
    _$messageNodeAtom.reportWrite(value, super.messageNode, () {
      super.messageNode = value;
    });
  }

  final _$getUserDataAsyncAction =
      AsyncAction('_MessagesControllerBase.getUserData');

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  final _$_saveMessageAsyncAction =
      AsyncAction('_MessagesControllerBase._saveMessage');

  @override
  Future<void> _saveMessage(
      String idCurrentUser, String idDestinationUser, MessageModel message) {
    return _$_saveMessageAsyncAction.run(
        () => super._saveMessage(idCurrentUser, idDestinationUser, message));
  }

  final _$sendImageAsyncAction =
      AsyncAction('_MessagesControllerBase.sendImage');

  @override
  Future<void> sendImage() {
    return _$sendImageAsyncAction.run(() => super.sendImage());
  }

  final _$_MessagesControllerBaseActionController =
      ActionController(name: '_MessagesControllerBase');

  @override
  void setContact(UserModel userContact) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.setContact');
    try {
      return super.setContact(userContact);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _chatListener() {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase._chatListener');
    try {
      return super._chatListener();
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controllerMessages: ${controllerMessages},
loggedUserId: ${loggedUserId},
targetUserId: ${targetUserId},
loggedUserName: ${loggedUserName},
contact: ${contact},
loading: ${loading},
messageNode: ${messageNode}
    ''';
  }
}
