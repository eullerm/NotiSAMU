import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noti_samu/aboutApp.dart';
import 'package:noti_samu/advice/advice.dart';
import 'package:noti_samu/objects/user.dart';
import 'package:noti_samu/services/baseAuth.dart';
import 'package:noti_samu/screens/admin/feed.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  Login({this.auth});

  final BaseAuth auth;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();

  String _user;
  String _password;
  String _errorMessage;
  bool _loading;

  // Checa se o form é valido antes do login
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        _loading = false;
      });

      return false;
    }
  }

  // Realiza o login
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _loading = true;
    });

    if (validateAndSave()) {
      String userId = "";
      try {
        print("$_user $_password");
        userId = await widget.auth.signIn(_user, _password);
        print('Signed in: $userId');

        setState(() {
          _loading = false;
          _errorMessage = "";
        });

        if (userId.length > 0 && userId != null) {
          User user = await _controlLogin(userId);
          print('admin and base: ${user.admin}, ${user.base}');

          if (!user.admin)
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: Advice(user.base, this.widget.auth)));
          else if (user.admin)
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: Feed(user.base, this.widget.auth)));
        }
      } on PlatformException catch (e) {
        print('Login error: $e');
        String errorType;
        if (Platform.isAndroid) {
          switch (e.code) {
            case 'ERROR_USER_NOT_FOUND':
              errorType = "Login ou senha inválido";
              break;
            case 'ERROR_WRONG_PASSWORD':
              errorType = "Senha inválida.";
              break;
            case 'ERROR_NETWORK_REQUEST_FAILED':
              errorType = "Verifique sua conexão com a internet.";
              break;
            default:
              errorType = "Erro desconhecido.";
              print(e.code.toString());
              break;
          }
        } else if (Platform.isIOS) {
          switch (e.code) {
            case 'Error 17011':
              errorType = "Login ou senha inválido";
              break;
            case 'Error 17009':
              errorType = "Senha inválida.";
              break;
            case 'Error 17020':
              errorType = "Verifique sua conexão com a internet.";
              break;
            default:
              errorType = "Erro desconhecido.";
              print(e.code.toString());
              break;
          }
        }

        setState(() {
          _loading = false;
          _errorMessage = errorType;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("NotiSAMU"),
      ),
      body: _body(context),
      floatingActionButton: _aboutApp(),
    );
  }

  _body(context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _showInputs(size),
        _showLoading(),
      ],
    );
  }

  _showLoading() {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container();
  }

  _showInputs(Size size) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: size.width,
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showErrorMessage(),
            _inputUser(),
            Divider(),
            _inputPassword(),
            Divider(),
            SizedBox(
              width: size.width,
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  _aboutApp() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, PageTransition(duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: AboutApp()));
      },
      label: Text(
        "Sobre o App",
        style: TextStyle(color: Color(0xFF002C3E)),
      ),
      icon: Icon(
        Icons.info_outline,
        color: Color(0xFF002C3E),
      ),
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Color(0xFF002C3E), width: 4)),
    );
  }

  _inputUser() {
    return TextFormField(
      onSaved: (value) => _user = value.trim().toLowerCase() + '@base.com',
      validator: (value) => _validateUser(value),
      maxLines: 1,
      autofocus: false,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Base",
        icon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
      ),
    );
  }

  _inputPassword() {
    return TextFormField(
      obscureText: true,
      onSaved: (value) => _password = value.trim(),
      validator: (value) => _errorPassword(value),
      maxLines: 1,
      autofocus: false,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Senha",
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
    );
  }

  _validateUser(String value) {
    if (value.isEmpty)
      return "Informe o login.";
    else
      return null;
  }

  _errorPassword(String value) {
    if (value.isEmpty)
      return "Informe a senha.";
    else
      return null;
  }

  _loginButton() {
    return ButtonTheme(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF002C3E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {
          validateAndSubmit();
        },
        child: Text(
          "Acessar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            _errorMessage,
            style: TextStyle(fontSize: 16.0, color: Color(0xFFF7444E), height: 1.0, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
        ],
      );
    } else {
      return Container();
    }
  }

  Future<User> _controlLogin(String userID) async {
    DocumentSnapshot doc;

    doc = await Firestore.instance.collection("user").document(userID).get();

    User user = User(userID, doc.data['base'], doc.data['admin']);

    return user;
  }
}
