import 'package:flutter/material.dart';
import 'package:noti_samu/screens/notifying/record/mandatoryData.dart';
import 'package:noti_samu/components/notification.dart';

class Patient extends StatefulWidget {
  Notify notification;
  Patient(this.notification);
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  String _radioValue;
  final patient = TextEditingController();
  final age = TextEditingController();

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
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Nome do Paciente(opcional)",
      ),
    );
  }

  _age(){
    return TextFormField(
      controller: age,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Idade do paciente.",
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
        _radioButton('M'),
        _radioButton('F'),
        _radioButton('Não informar'),
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
        if (patient.text.isEmpty)
          this.widget.notification.setPatient("Não informado");
        else
          this.widget.notification.setPatient(patient.text);
        
        if (_radioValue == null)
          this.widget.notification.setSex("Não informado");
        else
          this.widget.notification.setSex(_radioValue);
        
        if(age.text.isEmpty)
          this.widget.notification.setAge("Não informado");
        else
          this.widget.notification.setAge(age.text);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Occurrence(widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
