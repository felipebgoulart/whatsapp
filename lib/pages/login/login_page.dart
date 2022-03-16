import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mob_whatsapp/pages/login/controllers/login_controller.dart';
import 'package:mob_whatsapp/routes/routes.dart';

import 'models/country_model.dart';
import 'widgets/selection_option.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = GetIt.I.get<LoginController>();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_){
      Future.delayed(const Duration(seconds: 1),(){
        _loginController.isUserSigned(context);  
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PreferredSizeWidget loginAppBar() => AppBar(
    title: const Text('Phone number'),
    actions: <Widget> [
      Observer(
        builder: (context) => Row(
          children: [
            !_loginController.showName
            ? Observer(
                builder: (_) => CupertinoButton(
                  child: const Text('Done'),
                  onPressed: _loginController.isValidPhone ? () => _loginController.signIn(context) : null
                ),
              )
            : Observer(
                builder: (_) => CupertinoButton(
                  child: const Text('Done'),
                  onPressed: _loginController.isValidName ? () => _loginController.signUp(context) : null
                ),
              )
          ],
        )
      )
    ],
  );

  Widget _inputNamePhoto() => Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget> [
            GestureDetector(
              onTap: _loginController.saveProfilePicture,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.grey
                  ),
                  image: _loginController.profilePicture != null
                  ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(_loginController.profilePicture!.path))
                  )
                  : null
                ),
              child: _loginController.profilePicture == null
              ? const Center(
                  child: Text(
                    'add photo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff3478F7)
                    ),
                  )
                )
              : Container()
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('Enter your name and add an optional profile picture')
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.5)
              ),
              top: BorderSide(
                color: Colors.grey.withOpacity(.5)
              )
            )
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _loginController.textNameController,
                  maxLength: _loginController.maxLength,
                  cursorHeight: 24,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged: (_) => _loginController.validateName(),
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
              ),
              Text(
                '${_loginController.counter}',
                style: const TextStyle(
                  color: Colors.grey
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );

  Widget _inputPhone(List<CountryModel>? countryList) => Column(
    children: [
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.country, arguments: countryList),
        child: Observer(
          builder: (_) => SelectionOption(
            country: _loginController.country,
            textColor: const Color(0xff60a4ed),
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xffdbdbdc)
            )
          )
        ),
        child: Row(
          children: <Widget> [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: Color(0xffdbdbdc)
                  )
                )
              ),
              child: Observer(
                builder: (_) => Text(
                  _loginController.country!.code,
                  style: const TextStyle(
                    fontSize: 24
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Observer(
                  builder: (_) => TextFormField(
                    controller: _loginController.textPhoneController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter> [
                      MaskTextInputFormatter(mask: _loginController.country!.mask, filter: { "#": RegExp(r'[0-9]') })
                    ],
                    onChanged: (_) => _loginController.validatePhone(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'phone number',
                      hintStyle: TextStyle(
                        color:const Color(0xff000000).withOpacity(0.2)
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar(),
      body: Observer(
        builder: (BuildContext context) => Column(
          children: <Widget> [
            !_loginController.showName
            ? Observer(
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _loginController.message,
                    style: const TextStyle(
                      fontSize: 18
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container(),
            FutureBuilder(
              future: _loginController.getCounties(),
              builder: (BuildContext context, AsyncSnapshot<List<CountryModel>> snapshot) {
                if (snapshot.hasData) {
                  return Observer(
                    builder: (context) => _loginController.showName
                    ? _inputNamePhoto()
                    : _inputPhone(snapshot.data)
                  );
                } else {
                  return Container();
                }
              }
            ),
          ],
        ),
      )
    );
  }
}