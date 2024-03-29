import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/record/notifying.dart';
import 'package:noti_samu/services/baseAuth.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Success extends StatefulWidget {
  Notify notification;
  BaseAuth auth;
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
        backgroundColor: Color(0xFFF7444E),
        title: Text("Enviando a notificação."),
        automaticallyImplyLeading: false,
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
              _text("Sua notificação foi enviada com sucesso!!"),
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
      textAlign: TextAlign.center,
    );
  }

  _addData() async {
    FieldValue timestamp = FieldValue.serverTimestamp();
    await database
        .collection("notification")
        .document()
        .setData({
          'notifying': this.widget.notification.notifying,
          'occupation': this.widget.notification.occupation,
          'patient': this.widget.notification.patient,
          'age': this.widget.notification.age,
          'sex': this.widget.notification.sex,
          'occurrenceNumber': this.widget.notification.occurrenceNumber,
          'local': this.widget.notification.local,
          'occurrenceDate': this.widget.notification.occurrenceDate,
          'period': this.widget.notification.period,
          'classification': '',
          'incident': this.widget.notification.incidents,
          'category': this.widget.notification.category,
          'infoExtra': this.widget.notification.infoExtra,
          'createdAt': timestamp,
          'base': this.widget.notification.base,
          'medicines': this.widget.notification.medicines,
          'route': this.widget.notification.route,
          'isWrongMedicineUsed': this.widget.notification.isWrongMedicineUsed,
          'isMedicineReaction': this.widget.notification.isMedicineReaction,
          'infoAboutReaction': this.widget.notification.infoAboutReaction,
          'wrongMedicinesUsed': this.widget.notification.wrongMedicinesUsed,
        })
        .timeout(Duration(seconds: 10))
        .whenComplete(
          () => setState(() {
            send = true;
            Timer(
              Duration(seconds: 2),
              () => Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    duration: Duration(milliseconds: 200), type: PageTransitionType.leftToRight, child: Notifying(this.widget.notification.base)),
                ModalRoute.withName('/'),
              ),
            );
          }),
        )
        .catchError((error) => print("$error"));
  }
}
