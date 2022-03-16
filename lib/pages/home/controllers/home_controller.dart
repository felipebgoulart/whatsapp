import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mob_whatsapp/routes/routes.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  
  final PageController pageController = PageController(initialPage: 3);

  _HomeControllerBase();

  @observable
  int currentIndex = 3;

  @action
  void changePage(int index) {
    pageController.jumpToPage(index);
    currentIndex = index;
  }

  Future<void> isUserSigned(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.login
      );
    }
  }
}