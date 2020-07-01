import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/record/incident.dart';

class Occurrence extends StatefulWidget {
  Notify notification;
  Occurrence(this.notification);

  @override
  _OccurrenceState createState() => _OccurrenceState();
}

class _OccurrenceState extends State<Occurrence> {
  final occurrenceNumber = TextEditingController();
  final local = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String _radioValuePeriod;
  String _radioValueLocal;

  @override
  void initState() {
    setState(() {
      _radioValuePeriod = null;
      _radioValueLocal = "";
    });
    super.initState();
  }

  void radioButtonChangesPeriod(String value) {
    setState(() {
      _radioValuePeriod = value;
    });
  }

  void radioButtonChangesLocal(String value) {
    setState(() {
      _radioValueLocal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        SizedBox(height: 20),
        _occurrenceNumber(),
        SizedBox(height: 40),
        _occurrenceLocal(),
        SizedBox(height: 40),
        _occurrenceData(selectedDate),
        SizedBox(height: 40),
        _occurrencePeriod(),
      ],
    );
  }

  _selectDate(BuildContext context, int tempo) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime.now().subtract(Duration(days: tempo)),
      lastDate: new DateTime.now().add(Duration(days: 367)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.red,
            accentColor: Colors.red,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ),
          child: child,
        );
      },
    );
    if (picked != null &&
        picked != selectedDate &&
        picked.compareTo(DateTime.now()) <= 0)
      setState(
        () {
          selectedDate = picked;
        },
      );
  }

  _occurrenceData(selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data da ocorrência:",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context, 7),
          child: Text(
            "${selectedDate.day.toString()}/${selectedDate.month.toString()}/${selectedDate.year.toString()}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.date_range),
          onPressed: () => _selectDate(context, 7),
        ),
      ],
    );
  }

  _occurrencePeriod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '*Periodo da ocorrência:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _radioButton('Manhã', _radioValuePeriod, radioButtonChangesPeriod),
        _radioButton('Tarde', _radioValuePeriod, radioButtonChangesPeriod),
        _radioButton('Noite', _radioValuePeriod, radioButtonChangesPeriod),
      ],
    );
  }

  _occurrenceLocal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Periodo da ocorrência:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _radioButton('Residência', _radioValueLocal, radioButtonChangesLocal),
        _radioButton('Via pública', _radioValueLocal, radioButtonChangesLocal),
        _radioButton(
            'Unidade de saúde', _radioValueLocal, radioButtonChangesLocal),
        _radioButton('Outros', _radioValueLocal, radioButtonChangesLocal),
        _radioValueLocal.compareTo("Outros") == 0
            ? TextFormField(
                controller: local,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  hintText: "Local da ocorrência",
                ),
              )
            : Container(),
      ],
    );
  }

  _occurrenceNumber() {
    return TextFormField(
      controller: occurrenceNumber,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: "Número da ocorrência",
      ),
    );
  }

  _radioButton(String string, String radioValue, Function radioButtonChange) {
    return RadioListTile(
      title: Text(string),
      value: string,
      groupValue: radioValue,
      onChanged: radioButtonChange,
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.setOccurrenceNumber(occurrenceNumber.text);
        this.widget.notification.setDate(selectedDate);

        if (_radioValuePeriod != null)
          this.widget.notification.setPeriod(_radioValuePeriod);

        if (_radioValueLocal != null &&
            _radioValueLocal.compareTo("Outros") != 0)
          this.widget.notification.setLocal(_radioValueLocal);
        else if (local.text.isNotEmpty)
          this.widget.notification.setLocal(local.text);

        if (_radioValuePeriod != null &&
            (_radioValueLocal != null || local.text.isNotEmpty))
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Category(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
