import 'package:flutter/material.dart';
import 'package:noti_samu/screens/notifying/advice.dart';
import 'package:noti_samu/screens/admin/feed.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final email = TextEditingController();

   @override
  void dispose() {
    email.dispose();
    super.dispose();
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
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _user(),
            Divider(),
            _password(),
            Divider(),
            _loginButton(size),
          ],
        ),
      ),
    );
  }

  _user() {
    return TextFormField(
      controller: email,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Username ou E-mail.",
      ),
    );
  }

  _password() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Senha.",
      ),
    );
  }

  _loginButton(size) {
    return ButtonTheme(
      minWidth: size.width,
      child: RaisedButton(
        color: Colors.grey[350],
        child: Text(
          "Acessar",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onPressed: () {
          print(email.text);
          if(email.text.compareTo("notificante") == 0)
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => Advice()));
          else if(email.text.compareTo("admin") == 0)
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => Feed()));
        },
      ),
    );
  }
}
