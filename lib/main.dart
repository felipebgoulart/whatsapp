import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/login.dart';
import 'package:mob_whatsapp/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: const Login(),
      theme: ThemeData(
        primaryColor: const Color(0xff075E54),
        accentColor: const Color(0xff25D366),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff075E54), //use your hex code here
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.getRoutes,
      debugShowCheckedModeBanner: false,
    )
  );
}
