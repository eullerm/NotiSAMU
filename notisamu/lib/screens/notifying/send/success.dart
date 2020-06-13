import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/record/notifying.dart';

class Success extends StatefulWidget {
  Notify notification;
  Success(this.notification);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
              _text("Sua notificação foi enviada com Successo!!"),
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
              _text("Enviando."),
            ],
          ),
        ],
      ),
    );
  }

  _text(String string) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  _addData() async {
    FieldValue timestamp = FieldValue.serverTimestamp();
    await database
        .collection("notification")
        .document()
        .setData({
          'notifying': this.widget.notification.notifying,
          'profission': this.widget.notification.profission,
          'patient': this.widget.notification.patient,
          'birth': this.widget.notification.birth,
          'sex': this.widget.notification.sex,
          'occurrenceNumber': this.widget.notification.occurrenceNumber,
          'local': this.widget.notification.local,
          'occurrenceDate': this.widget.notification.occurrenceDate,
          'period': this.widget.notification.period,
          'incident': '',
          'answer': this.widget.notification.answer,
          'infoExtra': this.widget.notification.infoExtra,
          'createdAt': timestamp,
        })
        .timeout(Duration(seconds: 10))
        .whenComplete(
          () => setState(() {
            send = true;
            Timer(
              Duration(seconds: 2),
              () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Notifying()),
                ModalRoute.withName('/'),
              ),
            );
          }),
        )
        .catchError((error) => print("${error}"));
  }
}
