import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mob_whatsapp/pages/login/controllers/login_controller.dart';
import 'package:mob_whatsapp/pages/login/login_page.dart';
import 'package:mob_whatsapp/routes/routes.dart';

final ThemeData defaultTheme = ThemeData(
    primaryColor: const Color(0xff075E54),
    accentColor: const Color(0xff25D366),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff075E54), //use your hex code here
    ),
  );

final ThemeData iosTheme = ThemeData(
    primaryColor: Colors.grey[200],
    accentColor: const Color(0xff25D366),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xfff6f6f6), 
      elevation: 0,
      foregroundColor: Color(0xff000000),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xfff6f6f6),
      selectedItemColor: Color(0xff3478F7)
    )
  );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt getIt = GetIt.I;

  getIt.registerSingleton<LoginController>(LoginController());

  runApp(
    MaterialApp(
      home: const LoginPage(),
      theme: Platform.isAndroid ? defaultTheme : iosTheme,
      initialRoute: '/',
      onGenerateRoute: Routes.getRoutes,
      debugShowCheckedModeBanner: false,
    )
  );
}
