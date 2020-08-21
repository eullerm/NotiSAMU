import 'package:flutter/material.dart';
import 'package:noti_samu/components/datePicker.dart';
import 'package:noti_samu/objects/locals.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/objects/period.dart';
import 'package:noti_samu/screens/notifying/record/category.dart';

class Occurrence extends StatefulWidget {
  Notify notification;
  Occurrence(this.notification);

  @override
  _OccurrenceState createState() => _OccurrenceState();
}

class _OccurrenceState extends State<Occurrence> {
  final int maxRangeDatePicker = 7;

  final occurrenceNumber = TextEditingController();
  final local = TextEditingController();
  final List<String> listlocals = Locals().locals;
  final List<String> listPeriods = Periods().periods;

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

  _datePicker(int range) async {
    final DateTime picked = await selectDate(context, range, selectedDate);
    setState(
      () {
        selectedDate = picked;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
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
        _occurrenceData(),
        SizedBox(height: 40),
        _occurrencePeriod(),
      ],
    );
  }

  _occurrenceData() {
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
          onTap: () => _datePicker(maxRangeDatePicker),
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
          onPressed: () => _datePicker(maxRangeDatePicker),
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
        RadioButtonList(
          listPeriods,
          radioValue: _radioValuePeriod,
          radioButtonChanges: (String value) => radioButtonChangesPeriod(value),
        ),
      ],
    );
  }

  _occurrenceLocal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '*Local da ocorrência:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        RadioButtonList(
          listlocals,
          radioValue: _radioValueLocal,
          radioButtonChanges: (String value) => radioButtonChangesLocal(value),
        ),
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
        hintText: "Número da ocorrência(opcional)",
      ),
    );
  }

  _buttonNext(BuildContext context) {
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
            (_radioValueLocal.length > 0 || local.text.isNotEmpty))
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Category(this.widget.notification)));
        else
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
