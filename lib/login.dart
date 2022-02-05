import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/home.dart';
import 'package:mob_whatsapp/models/user.dart';
import 'package:mob_whatsapp/routes/routes.dart';
import 'package:mob_whatsapp/sing_up.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_){
      Future.delayed(const Duration(seconds: 1),(){
        _isUserSigned();  
      });
    });
    super.initState();
  }

  Future _isUserSigned() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.home
      );
    }
  }

  void _validateFields() {
    if (_controllerEmail.text.contains('@')) {
      if (_controllerPass.text.isNotEmpty) {
        UserModel user = UserModel(
          email: _controllerEmail.text,
          password: _controllerPass.text
        );
        
        setState(() {
          _errorMessage = '';
        });
        
        _signIn(user);
      } else {
        setState(() {
          _errorMessage = 'Preencha a senha';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Preencha com um email válido';
      });
    }
  }

  void _signIn(UserModel user) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password ?? ''
    ).then((UserCredential firebaseUser) => {
      Navigator.pushReplacementNamed(
        context,
        Routes.home
      )
    }).catchError((onError) {
      setState(() {
        _errorMessage = 'Erro ao autenticar o usuário, verifique o e-mail e senha';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff075E54)
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'images/logo.png',
                    width: 200,
                    height: 150
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: 'E-mail',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerPass,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: _validateFields,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.green),
                      padding: MaterialStateProperty.resolveWith<EdgeInsets>((states) => const EdgeInsets.fromLTRB(32, 16, 32, 16)),
                      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(
                        context,
                        Routes.signup
                      )
                    },
                    child: const Text(
                      'Não tem conta? cadastre-se!',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}