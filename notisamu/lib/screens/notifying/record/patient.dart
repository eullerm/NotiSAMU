import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/objects/sex.dart';
import 'package:noti_samu/screens/notifying/record/mandatoryData.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:page_transition/page_transition.dart';

class Patient extends StatefulWidget {
  Notify notification;
  Patient(this.notification);
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  String _radioValue;
  final List<String> listSex = Sex().sex;
  final patient = TextEditingController();
  final age = TextEditingController();
  bool _error;

  @override
  void initState() {
    setState(() {
      _radioValue = null;
      _error = false;
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados opcionais"),
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
            _patientName(),
            SizedBox(height: 40),
            _age(),
            SizedBox(height: 40),
            _radioButtonSex(),
          ],
        ),
      ),
    );
  }

  _patientName() {
    return TextFormField(
      controller: patient,
      keyboardType: TextInputType.text,
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Iniciais do paciente (opcional)",
      ),
    );
  }

  _age() {
    return TextFormField(
      controller: age,
      keyboardType: TextInputType.number,
      maxLength: 3,
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Idade do paciente (opcional)",
        counterText: "",
        hoverColor: (_error != null && _error) ? Colors.red : Colors.black,
      ),
    );
  }

  _radioButtonSex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sexo do Paciente:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        RadioButtonList(
          listSex,
          radioValue: _radioValue,
          radioButtonChanges: (String value) => radioButtonChanges(value),
        )
      ],
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (patient.text.isEmpty)
          this.widget.notification.setPatient("Não informado");
        else
          this.widget.notification.setPatient(patient.text);

        if (_radioValue == null)
          this.widget.notification.setSex("Não informado");
        else
          this.widget.notification.setSex(_radioValue);

        if (age.text.isEmpty)
          this.widget.notification.setAge("Não informado");
        else
          this.widget.notification.setAge(age.text);
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: Occurrence(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
