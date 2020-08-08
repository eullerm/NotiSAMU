import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/components/user.dart';
import 'package:noti_samu/login.dart';
import 'package:noti_samu/screens/notifying/record/patient.dart';

class Notifying extends StatefulWidget {

  //final User user;

  //Notifying(this.user);

  @override
  _NotifyingState createState() => _NotifyingState();
}

class _NotifyingState extends State<Notifying> {
  Notify notification = Notify();
  //Notify notification = Notify(base: user.base);
  String _radioValue;
  final notifying = TextEditingController();

  @override
  void initState() {
    setState(() {
      _radioValue = null;
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      debugPrint(_radioValue);
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
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
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
            _radioButtonProfission(),
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

  _radioButtonProfission() {
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
        _radioButton('Enfermeira(o)'),
        _radioButton('Técnico de enfermagem'),
        _radioButton('Médica(o)'),
      ],
    );
  }

  _radioButton(String string) {
    return RadioListTile(
      title: Text(string),
      value: string,
      groupValue: _radioValue,
      onChanged: radioButtonChanges,
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (notifying.text.isEmpty)
          this.notification.setNotifying("Não informado");
        else
          this.notification.setNotifying(notifying.text);
        if (_radioValue != null) {
          this.notification.setProfission(_radioValue);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Patient(notification)));
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
