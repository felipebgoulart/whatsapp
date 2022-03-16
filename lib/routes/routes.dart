import 'package:flutter/material.dart';
import 'package:mob_whatsapp/configuration.dart';
import 'package:mob_whatsapp/pages/contacts/contacts_page.dart';
import 'package:mob_whatsapp/pages/home/home.dart';
import 'package:mob_whatsapp/pages/login/country_page.dart';
import 'package:mob_whatsapp/pages/login/login_page.dart';
import 'package:mob_whatsapp/pages/messages/messages_page.dart';

class Routes {

  static const String home = '/home';
  static const String country = '/country';
  static const String contacts = '/contacts';

  static const String signup = '/signup';
  static const String login = '/login';
  static const String configuration = '/configuration';
  static const String messages = '/messages';

  static Route<dynamic> getRoutes(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginPage()
        );
      case country:
        return MaterialPageRoute(
          builder: (_) => CountryPage(countries: args)
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage()
        );
      case contacts:
        return MaterialPageRoute(
          builder: (_) => const ContactsPage()
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
          builder: (_) => MessagesPage(contact: args)
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