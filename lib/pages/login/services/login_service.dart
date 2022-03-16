import 'dart:convert';

import 'package:flutter/services.dart';

class LoginService {

  LoginService();

  Future<Map<String, dynamic>> findAllCountries() async {
    try {
      final String response = await rootBundle.loadString('lib/core/json/countries.json');
      Map<String, dynamic> countries = await json.decode(response);
      
      return countries;
    } catch (error) {
      throw Exception();
    }
  }
}