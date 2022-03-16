// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$countryAtom = Atom(name: '_LoginControllerBase.country');

  @override
  CountryModel? get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(CountryModel? value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
    });
  }

  final _$isValidPhoneAtom = Atom(name: '_LoginControllerBase.isValidPhone');

  @override
  bool get isValidPhone {
    _$isValidPhoneAtom.reportRead();
    return super.isValidPhone;
  }

  @override
  set isValidPhone(bool value) {
    _$isValidPhoneAtom.reportWrite(value, super.isValidPhone, () {
      super.isValidPhone = value;
    });
  }

  final _$isValidNameAtom = Atom(name: '_LoginControllerBase.isValidName');

  @override
  bool get isValidName {
    _$isValidNameAtom.reportRead();
    return super.isValidName;
  }

  @override
  set isValidName(bool value) {
    _$isValidNameAtom.reportWrite(value, super.isValidName, () {
      super.isValidName = value;
    });
  }

  final _$showNameAtom = Atom(name: '_LoginControllerBase.showName');

  @override
  bool get showName {
    _$showNameAtom.reportRead();
    return super.showName;
  }

  @override
  set showName(bool value) {
    _$showNameAtom.reportWrite(value, super.showName, () {
      super.showName = value;
    });
  }

  final _$messageAtom = Atom(name: '_LoginControllerBase.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$counterAtom = Atom(name: '_LoginControllerBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$maxLengthAtom = Atom(name: '_LoginControllerBase.maxLength');

  @override
  int get maxLength {
    _$maxLengthAtom.reportRead();
    return super.maxLength;
  }

  @override
  set maxLength(int value) {
    _$maxLengthAtom.reportWrite(value, super.maxLength, () {
      super.maxLength = value;
    });
  }

  final _$profilePictureAtom =
      Atom(name: '_LoginControllerBase.profilePicture');

  @override
  XFile? get profilePicture {
    _$profilePictureAtom.reportRead();
    return super.profilePicture;
  }

  @override
  set profilePicture(XFile? value) {
    _$profilePictureAtom.reportWrite(value, super.profilePicture, () {
      super.profilePicture = value;
    });
  }

  final _$textPhoneControllerAtom =
      Atom(name: '_LoginControllerBase.textPhoneController');

  @override
  TextEditingController get textPhoneController {
    _$textPhoneControllerAtom.reportRead();
    return super.textPhoneController;
  }

  @override
  set textPhoneController(TextEditingController value) {
    _$textPhoneControllerAtom.reportWrite(value, super.textPhoneController, () {
      super.textPhoneController = value;
    });
  }

  final _$textNameControllerAtom =
      Atom(name: '_LoginControllerBase.textNameController');

  @override
  TextEditingController get textNameController {
    _$textNameControllerAtom.reportRead();
    return super.textNameController;
  }

  @override
  set textNameController(TextEditingController value) {
    _$textNameControllerAtom.reportWrite(value, super.textNameController, () {
      super.textNameController = value;
    });
  }

  final _$getCountiesAsyncAction =
      AsyncAction('_LoginControllerBase.getCounties');

  @override
  Future<List<CountryModel>> getCounties() {
    return _$getCountiesAsyncAction.run(() => super.getCounties());
  }

  final _$signInAsyncAction = AsyncAction('_LoginControllerBase.signIn');

  @override
  Future<void> signIn(BuildContext context) {
    return _$signInAsyncAction.run(() => super.signIn(context));
  }

  final _$saveProfilePictureAsyncAction =
      AsyncAction('_LoginControllerBase.saveProfilePicture');

  @override
  Future<void> saveProfilePicture() {
    return _$saveProfilePictureAsyncAction
        .run(() => super.saveProfilePicture());
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void updateCountry(CountryModel countryModel) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.updateCountry');
    try {
      return super.updateCountry(countryModel);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhone() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validatePhone');
    try {
      return super.validatePhone();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validateName');
    try {
      return super.validateName();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _resetDefault() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase._resetDefault');
    try {
      return super._resetDefault();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
country: ${country},
isValidPhone: ${isValidPhone},
isValidName: ${isValidName},
showName: ${showName},
message: ${message},
counter: ${counter},
maxLength: ${maxLength},
profilePicture: ${profilePicture},
textPhoneController: ${textPhoneController},
textNameController: ${textNameController}
    ''';
  }
}
