import 'package:flutter/material.dart';
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
  String _errorUser;
  String _password;
  String _errorPassword;
  String _errorMessage;
  bool _loading;

  // Check if form is valid before perform login
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login
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
          if(_user.compareTo("niteroi@base.com") == 0)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Advice()));
          else if(_user.compareTo("admin@base.com") == 0)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Feed()));
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _loading = false;
          _errorMessage = e.toString();
          _formKey.currentState.reset();
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
    return Container(
      height: 0.0,
      width: 0.0,
    );
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
      validator: (value) => _errorUser == null ? null : _errorUser,
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
      validator: (value) => _errorPassword == null ? null : _errorPassword,
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
          /*if (_user.compareTo("notificante@base.com") == 0)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Advice()));
          else if (_user.compareTo("admin@base.com") == 0)
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Feed()));*/
        },
      ),
    );
  }

  _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

}
