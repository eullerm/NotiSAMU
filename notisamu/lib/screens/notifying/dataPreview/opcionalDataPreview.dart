import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/mandatoryDataPreview.dart';

class OptionalData extends StatefulWidget {
  Notify notification;
  OptionalData(this.notification);

  @override
  _OptionalDataState createState() => _OptionalDataState();
}

class _OptionalDataState extends State<OptionalData> {
  List<String> data = [
    "Nome do relator: ",
    "Profissão: ",
    "Paciente: ",
    "Idade: ",
    "Sexo do paciente: "
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Revisão de dados"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              _notifyName(),
              SizedBox(height: 20),
              _profission(),
              SizedBox(height: 20),
              _patientName(),
              SizedBox(height: 20),
              _age(),
              SizedBox(height: 20),
              _sex(),
            ],
          ),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MandatoryData(widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _notifyName() {
    return _text(data[0], this.widget.notification.notifying);
  }

  _profission() {
    return _text(data[1], this.widget.notification.profission);
  }

  _patientName() {
    return _text(data[2], this.widget.notification.patient);
  }

  _age() {
    return _text(data[3], this.widget.notification.age);
  }

  _sex() {
    return _text(data[4], this.widget.notification.sex);
  }

  _text(String string, String string2) {
    return Column(
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => _change(string),
          child: Text(
            string2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _change(String string) {
    //Será usado para alterar algum dado.
    if (string.compareTo(data[0]) == 0)
      print(string);
    else if (string.compareTo(data[0]) == 0)
      print(string);
    else if (string.compareTo(data[0]) == 0)
      print(string);
    else if (string.compareTo(data[0]) == 0)
      print(string);
    else if (string.compareTo(data[0]) == 0) print(string);
  }
}
