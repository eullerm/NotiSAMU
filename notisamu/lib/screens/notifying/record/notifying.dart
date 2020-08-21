import 'package:flutter/material.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/objects/occupation.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/screens/notifying/record/patient.dart';

class Notifying extends StatefulWidget {
  Notifying(this.base);

  final String base;

  @override
  _NotifyingState createState() => _NotifyingState();
}

class _NotifyingState extends State<Notifying> {
  List<String> listOccupations = Occupations().occupations;
  Notify notification;
  String _radioValueOccupation;
  final notifying = TextEditingController();

  @override
  void initState() {
    notification = Notify(widget.base);
    setState(() {
      _radioValueOccupation = null;
    });
    super.initState();
  }

  void radioButtonChangeOccupation(String value) {
    setState(() {
      _radioValueOccupation = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados opcionais"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            _notifyingName(),
            SizedBox(height: 40),
            _radioButtonOccupation(),
          ],
        ),
      ),
    );
  }

  _notifyingName() {
    return TextFormField(
      controller: notifying,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Nome do Notificante(opcional)",
      ),
    );
  }

  _radioButtonOccupation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '*Profissão:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        RadioButtonList(
          listOccupations,
          radioValue: _radioValueOccupation,
          radioButtonChanges: (String value) =>
              radioButtonChangeOccupation(value),
        ),
      ],
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (notifying.text.isEmpty)
          this.notification.setNotifying("Não informado");
        else
          this.notification.setNotifying(notifying.text);
        if (_radioValueOccupation != null) {
          this.notification.setOccupation(_radioValueOccupation);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Patient(notification)));
        } else
          _missingElement(context);
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _missingElement(BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Está faltando um elemento obrigatório",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
