import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/objects/user.dart';
import 'package:noti_samu/services/baseAuth.dart';
import 'package:noti_samu/screens/notifying/advice.dart';
import 'package:noti_samu/screens/admin/feed.dart';

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
        userId = await widget.auth.signIn(_user, _password);
        print('Signed in: $userId');

        setState(() {
          _loading = false;
        });

        if (userId.length > 0 && userId != null) {
          User user = await _controlLogin(userId);
          print('admin and base: ${user.admin}, ${user.base}');

          if (!user.admin)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Advice(user.base, this.widget.auth)));
          else if (user.admin)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Feed(user.base, this.widget.auth)));
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _loading = false;
          _errorMessage = "Login ou senha invalido.";
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
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Stack(
      children: <Widget>[
        _showInputs(),
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

  _showInputs() {
    Size size = MediaQuery.of(context).size;
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
              _loginButton(size),
            ],
          ),
        ));
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
        hintText: "Base.",
        icon: Icon(
          Icons.email,
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
        hintText: "Senha.",
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

  _loginButton(size) {
    return ButtonTheme(
      minWidth: size.width,
      child: RaisedButton(
        color: Colors.grey[300],
        child: Text(
          "Acessar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.blue,
        onPressed: () {
          validateAndSubmit();
        },
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
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                height: 1.0,
                fontWeight: FontWeight.w300),
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
