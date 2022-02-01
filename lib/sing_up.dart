import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob_whatsapp/home.dart';
import 'package:mob_whatsapp/model/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  String _errorMessage = '';

  void _validateFields() {
    if (_controllerName.text.isNotEmpty) {
      if (_controllerEmail.text.contains('@')) {
        if (_controllerPass.text.isNotEmpty && _controllerPass.text.length > 6) {
          UserModel user = UserModel(
            name: _controllerName.text,
            email: _controllerEmail.text,
            password: _controllerPass.text
          );

          setState(() {
            _errorMessage = '';
          });
          
          _signUp(user);
        } else {
          setState(() {
            _errorMessage = 'Preencha a senha! Digite mais de 6 caracteres';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Preencha com um email válido';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Preencha o nome';
      });
    }
  }

  void _signUp(UserModel user) {
    FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password
      ).then((UserCredential firebaseUser) {
        FirebaseFirestore db = FirebaseFirestore.instance;
        db.collection('users')
          .doc(firebaseUser.user!.uid)
        .set(user.toMap());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Home()
          )
        );
      }).catchError((onError) {
        setState(() => {
          _errorMessage = 'Erro ao cadastrar usuário, verifique os campos e tente novamente!'
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
                    'images/usuario.png',
                    width: 200,
                    height: 150
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerName,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: 'Nome',
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
                    controller: _controllerEmail,
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
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20
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