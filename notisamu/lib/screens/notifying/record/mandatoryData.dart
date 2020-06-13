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
  String _radioValue;

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
        _numeroOccurrence(),
        SizedBox(height: 40),
        _localOccurrence(),
        SizedBox(height: 40),
        _dataOccurrence(selectedDate),
        SizedBox(height: 40),
        _periodoOccurrence(),
      ],
    );
  }

  Future<DateTime> _selectDate(BuildContext context, int tempo) async {
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
          print(picked);
          return picked;
        },
      );
  }

  _dataOccurrence(selectedDate) {
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

  _periodoOccurrence() {
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
        _radioButton('Manhã'),
        _radioButton('Tarde'),
        _radioButton('Noite'),
      ],
    );
  }

  _localOccurrence() {
    return TextFormField(
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
    );
  }

  _numeroOccurrence() {
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
        this.widget.notification.setOccurrenceNumber(occurrenceNumber.text);
        this.widget.notification.setLocal(local.text);
        this.widget.notification.setDate(selectedDate);
        if(_radioValue == null)//Retirar depois.
          this.widget.notification.setPeriod("Não informado.");
        else
          this.widget.notification.setPeriod(_radioValue);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Category(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
