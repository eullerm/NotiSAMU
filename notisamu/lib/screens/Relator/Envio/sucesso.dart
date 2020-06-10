import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/components/notificacao.dart';
import 'package:noti_samu/screens/Relator/Registro/registroRelatorOpcional.dart';

class Sucesso extends StatefulWidget {
  Notificacao notificacao;
  Sucesso(this.notificacao);

  @override
  _SucessoState createState() => _SucessoState();
}

class _SucessoState extends State<Sucesso> {
  final database = Firestore.instance;
  bool send = false;

  @override
  void initState() {
    super.initState();

    _addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dados especificos."),
      ),
      body: !send ? _progress(context) : _sended(context),
    );
  }

  _sended(BuildContext context) {
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

  _progress(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  strokeWidth: 2, //largura do cirulo
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _texto("Enviando."),
            ],
          ),
        ],
      ),
    );
  }

  _texto(String string) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  _addData() async {
    await database
        .collection("notification")
        .document()
        .setData({
          'notifying': this.widget.notificacao.notifying,
          'profission': this.widget.notificacao.profission,
          'patient': this.widget.notificacao.patient,
          'birth': this.widget.notificacao.birth,
          'sex': this.widget.notificacao.sex,
          'occurrenceNumber': this.widget.notificacao.occurrenceNumber,
          'local': this.widget.notificacao.local,
          'occurrenceDate': this.widget.notificacao.occurrenceDate,
          'period': this.widget.notificacao.period,
          'incident': '',
          'answer': this.widget.notificacao.answer,
          'infoExtra': this.widget.notificacao.infoExtra,
        })
        .timeout(Duration(seconds: 10))
        .whenComplete(
          () => setState(() {
            send = true;
            Timer(
              Duration(seconds: 2),
              () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Relator()),
                ModalRoute.withName('/'),
              ),
            );
          }),
        )
        .catchError((error) => print("${error}"));
  }
}
