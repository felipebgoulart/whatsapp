import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_whatsapp/core/models/user.dart';
import 'package:mob_whatsapp/core/services/firebase_service.dart';
import 'package:mob_whatsapp/pages/login/models/country_model.dart';
import 'package:mob_whatsapp/pages/login/services/login_service.dart';
import 'package:mob_whatsapp/routes/routes.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {

  final LoginService _loginService = LoginService();
  final FirebaseService _firebaseService = FirebaseService();

  _LoginControllerBase();
  
  @observable
  CountryModel? country;

  @observable
  bool isValidPhone = false;
  
  @observable
  bool isValidName = false;

  @observable
  bool showName = false;
  
  @observable
  String message = 'Please confirm your contry code and enter your phone number';

  @observable
  int counter = 25;

  @observable
  int maxLength = 25;

  @observable
  XFile? profilePicture;

  @observable
  TextEditingController textPhoneController = TextEditingController();
  
  @observable
  TextEditingController textNameController = TextEditingController();

  @action
  void updateCountry(CountryModel countryModel) {
    country = countryModel;
    textPhoneController.clear();
    isValidPhone = false;
  }

  @action
  void validatePhone() {
    isValidPhone = textPhoneController.text.length != country!.mask!.length ? false : true;
  }

  @action
  void validateName() {
    isValidName = textNameController.text.length > 3 ? true : false;
    counter = maxLength;
    counter = counter - textNameController.text.length;
  }

  @action
  void _resetDefault() {
    isValidName = false;
    isValidPhone = false;
    showName = false;
    profilePicture = null;
    textNameController.clear();
    textPhoneController.clear();
    counter = maxLength;
  }

  @action
  Future<List<CountryModel>> getCounties() async {
    try {
      Map<String, dynamic> value = await _loginService.findAllCountries();
      List<dynamic> decoded = value['countries'];
      List<CountryModel> countries = []; 
      
      for (dynamic country in decoded) {
        countries.add(CountryModel.fromJson(country));
      }

      country = countries.first;

      return countries;
    } catch (error) {
      throw Exception();
    }
  }

  @action
  Future<void> signIn(BuildContext context) async {
    String phoneNumber = textPhoneController.text.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '');
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: '$phoneNumber@gmail.com',
        password: textPhoneController.text
      ).then((UserCredential firebaseUser) => {
        _resetDefault(),
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          ModalRoute.withName(Routes.home)
        )
      });
    } catch (error) {
      if (isValidPhone) {
        showName = true;
      }
    }
  }

  @action
  Future<void> saveProfilePicture() async  {
    ImagePicker pickerController = ImagePicker();
    profilePicture = await pickerController.pickImage(source: ImageSource.gallery);
  }

  Future<void> signUp(BuildContext context) async {
    String phoneNumber = textPhoneController.text.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', '');
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
      email: '$phoneNumber@gmail.com',
      password: textPhoneController.text
    ).then((UserCredential firebaseUser) async {
      UserModel user = UserModel(
        name: textNameController.text,
        email: '${textPhoneController.text}@gmail.com',
        password: textPhoneController.text,
      );
      _firebaseService.saveUser(user, firebaseUser.user!.uid);
      
      if (profilePicture != null) {
        await _firebaseService.updateProfilePicture(firebaseUser.user!.uid, profilePicture);
      }

      _resetDefault();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        ModalRoute.withName(Routes.home)
      );
    }).catchError((onError) {
      throw Exception();
    });
  }

  Future isUserSigned(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      _resetDefault();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        ModalRoute.withName(Routes.home)
      );
    }
  }
}