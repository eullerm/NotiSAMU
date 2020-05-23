import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/registroRelatorOpcional.dart';

class Sucesso extends StatefulWidget {
  @override
  _SucessoState createState() => _SucessoState();
}

class _SucessoState extends State<Sucesso> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Relator()),
              ModalRoute.withName('/'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dados especificos."),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.greenAccent,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              _texto("Sua notificação foi enviada com sucesso!!"),
            ],
          ),
        ],
      ),
    );
  }

  _texto(string) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
