import 'package:flutter/material.dart';
import 'package:noti_samu/screens/aviso.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            _usuario(),
            Divider(),
            _senha(),
            Divider(),
            _botaoDeLogin(size),
          ],
        ),
      ),
    );
  }

  _usuario() {
    return TextFormField(
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

  _senha() {
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

  _botaoDeLogin(size) {
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Aviso()));
        },
      ),
    );
  }
}
