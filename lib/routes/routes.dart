import 'package:flutter/material.dart';
import 'package:mob_whatsapp/configuration.dart';
import 'package:mob_whatsapp/home.dart';
import 'package:mob_whatsapp/login.dart';
import 'package:mob_whatsapp/messages.dart';
import 'package:mob_whatsapp/sing_up.dart';
import 'package:mob_whatsapp/models/user.dart';

class Routes {

  static const String home = '/home';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String configuration = '/configuration';
  static const String messages = '/messages';

  static Route<dynamic> getRoutes(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Login()
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const Login()
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignUp()
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const Home()
        );
      case configuration:
        return MaterialPageRoute(
          builder: (_) => const Configuration()
        );
      case messages:
        return MaterialPageRoute(
          builder: (_) => Messages(contact: args)
        );
      default:
        return _notFound();
    }
  }

  static Route<dynamic> _notFound() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '404 Not Found'
            ),
          ),
          body: const Text(
            '404 Not Found'
          ),
        );
      }
    );
  }

}