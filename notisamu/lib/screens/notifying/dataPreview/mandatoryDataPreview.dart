import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkButton.dart';
import 'package:noti_samu/components/datePicker.dart';
import 'package:noti_samu/components/radioButtonListChangeField.dart';
import 'package:noti_samu/components/textChangeFormField.dart';
import 'package:noti_samu/objects/locals.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/objects/period.dart';
import 'package:noti_samu/screens/notifying/dataPreview/medicinesPreview.dart';
import 'package:page_transition/page_transition.dart';

class MandatoryData extends StatefulWidget {
  Notify notification;
  MandatoryData(this.notification);

  @override
  _MandatoryDataState createState() => _MandatoryDataState();
}

class _MandatoryDataState extends State<MandatoryData> {
  final int maxRangeDatePicker = 7;

  List<String> data = [
    "Número da ocorrência:",
    "Local da ocorrência:",
    "Data da ocorrência:",
    "Período da ocorrência:",
  ];

  List<String> listLocals = Locals().locals;
  List<String> listPeriods = Periods().periods;

  TextEditingController occurrenceNumber;
  TextEditingController period;

  TextEditingController local;

  String _radioValueLocal;
  String _radioValuePeriods;

  DateTime selectedDate;

  bool _changeNumber;
  bool _changeLocal;
  bool _changeDate;
  bool _changePeriod;

  @override
  void initState() {
    occurrenceNumber =
        TextEditingController(text: this.widget.notification.occurrenceNumber);
    local = TextEditingController(text: this.widget.notification.local);

    _radioValueLocal = this.widget.notification.local;
    if (!listLocals.contains(_radioValueLocal)) {
      local = TextEditingController(text: _radioValueLocal);
      _radioValueLocal = "Outros";
    }
    _radioValuePeriods = this.widget.notification.period;

    selectedDate = this.widget.notification.occurrenceDate;

    _changeNumber = false;
    _changeLocal = false;
    _changeDate = false;
    _changePeriod = false;

    super.initState();
  }

  void radioButtonChangeLocal(String value) {
    setState(() {
      _radioValueLocal = value;
    });
  }

  void radioButtonChangePeriods(String value) {
    setState(() {
      _radioValuePeriods = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("Revisão de dados"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              _occurrenceNumber(),
              SizedBox(height: 20),
              _local(),
              SizedBox(height: 20),
              _date(),
              SizedBox(height: 20),
              _period(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (!_changeLocal && !_changeNumber && !_changePeriod) {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 200),
                  type: PageTransitionType.rightToLeft,
                  child: MedicinesPreview(widget.notification)));
        } else {
          _changingElement(context);
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: (_changeLocal || _changeNumber || _changePeriod)
          ? Color(0xAAF7444E)
          : Color(0xFFF7444E),
    );
  }

  _occurrenceNumber() {
    return _changeNumber
        ? TextChangeFormField(
            data[0],
            occurrenceNumber,
            number: true,
            functionToCancel: () => _saveNewData(
              data[0],
              this.widget.notification.occurrenceNumber,
            ),
            widget: CheckButton(
              function: () => _saveNewData(data[0], occurrenceNumber.text),
            ),
          )
        : TextPreview(
            data[0],
            string2: this.widget.notification.occurrenceNumber,
            function: () => _change(data[0]),
          );
  }

  _local() {
    return _changeLocal
        ? Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    data[1],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              RadioButtonListChangeField(
                listLocals,
                radioValue: _radioValueLocal,
                radioButtonChanges: (String value) =>
                    radioButtonChangeLocal(value),
                widget: CheckButton(
                  function: () => _radioValueLocal.compareTo("Outros") != 0
                      ? _saveNewData(data[1], _radioValueLocal)
                      : _saveNewData(data[1], local.text),
                ),
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
                      ),
                    )
                  : Container(),
            ],
          )
        : TextPreview(
            data[1],
            string2: this.widget.notification.local,
            function: () => _change(data[1]),
          );
  }

  _datePicker(int range) async {
    final DateTime picked = await selectDate(context, range, selectedDate);
    setState(
      () {
        selectedDate = picked;
        _saveNewData(data[2], selectedDate);
      },
    );
  }

  _date() {
    return TextPreview(
      data[2],
      string2: "${selectedDate.day.toString()}/" +
          "${selectedDate.month.toString()}/" +
          "${selectedDate.year.toString()}",
      function: () => _datePicker(maxRangeDatePicker),
    );
  }

  _period() {
    return _changePeriod
        ? Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    data[3],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              RadioButtonListChangeField(
                listPeriods,
                radioValue: _radioValuePeriods,
                radioButtonChanges: (String value) =>
                    radioButtonChangePeriods(value),
                widget: CheckButton(
                  function: () => _saveNewData(data[3], _radioValuePeriods),
                ),
              ),
            ],
          )
        : TextPreview(
            data[3],
            string2: this.widget.notification.period,
            function: () => _change(data[3]),
          );
  }

  _change(String string) {
    if (string.compareTo(data[0]) == 0)
      setState(() {
        _changeNumber = !_changeNumber;
      });
    else if (string.compareTo(data[1]) == 0)
      setState(() {
        _changeLocal = !_changeLocal;
      });
    else if (string.compareTo(data[2]) == 0)
      setState(() {
        _changeDate = !_changeDate;
      });
    else if (string.compareTo(data[3]) == 0)
      setState(() {
        _changePeriod = !_changePeriod;
      });
  }

  _saveNewData(String field, dynamic newData) {
    if (field.compareTo(data[0]) == 0) {
      if (newData.length == 0) newData = "Não informado";
      setState(() {
        this.widget.notification.setOccurrenceNumber(newData);
        occurrenceNumber = TextEditingController(
            text: this.widget.notification.occurrenceNumber);
      });
    } else if (field.compareTo(data[1]) == 0) {
      if (newData.length == 0) newData = "Não informado";
      setState(() {
        this.widget.notification.setLocal(newData);
        if (listLocals.contains(newData)) {
          _radioValueLocal = newData;
        } else {
          local = TextEditingController(text: newData);
          _radioValueLocal = "Outros";
        }
      });
    } else if (field.compareTo(data[2]) == 0)
      setState(() {
        this.widget.notification.setDate(newData);
        selectedDate = this.widget.notification.occurrenceDate;
      });
    else if (field.compareTo(data[3]) == 0)
      setState(() {
        this.widget.notification.setPeriod(newData);
        _radioValuePeriods = this.widget.notification.period;
      });

    _change(field);
  }

  _changingElement(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Salve ou cancele as alterações antes de prosseguir.",
          style: TextStyle(color: Color(0xFFF7444E)),
        ),
      ),
    );
  }
}
