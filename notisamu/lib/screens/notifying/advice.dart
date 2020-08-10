import 'package:flutter/material.dart';
import 'package:noti_samu/screens/notifying/record/notifying.dart';
import 'package:noti_samu/login.dart';
import 'package:noti_samu/services/baseAuth.dart';

class Advice extends StatefulWidget {
  Advice(this.base, this.auth);

  final BaseAuth auth;
  final String base;

  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            this.widget.auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login(auth: this.widget.auth,)));
          },
        ),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _advice(size),
          _button(size),
        ],
      ),
    );
  }

  _advice(size) {
    return Column(
      children: <Widget>[
        _text(
            "A notificação não apresenta caráter punitivo. Ela visa a segurança do paciente e uma melhor qualidade no atendimento ao usuário da unidade de saúde.",
            25.0),
        _text("Você não será identificado.", 26.0)
      ],
    );
  }

  _text(String string, double font) {
    return Text(
      (string),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: font,
      ),
    );
  }

  _button(size) {
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Notifying(this.widget.base)));
        },
      ),
    );
  }
}
