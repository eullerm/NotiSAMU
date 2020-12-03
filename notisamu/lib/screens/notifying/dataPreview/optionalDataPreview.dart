import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkButton.dart';
import 'package:noti_samu/components/radioButtonListChangeField.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/components/textChangeFormField.dart';
import 'package:noti_samu/objects/occupation.dart';
import 'package:noti_samu/objects/sex.dart';
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
  List<String> listOccupations = Occupations().occupations;
  List<String> listSex = Sex().sex;

  String _radioValueOccupation;
  String _radioValueSex;

  TextEditingController name;
  TextEditingController patient;
  TextEditingController age;
  TextEditingController sex;

  bool _changeName;
  bool _changeOccupation;
  bool _changePatient;
  bool _changeAge;
  bool _changeSex;

  @override
  void initState() {
    name = TextEditingController(text: this.widget.notification.notifying);
    patient = TextEditingController(text: this.widget.notification.patient);
    age = TextEditingController(text: this.widget.notification.age);

    _radioValueOccupation = this.widget.notification.occupation;
    _radioValueSex = this.widget.notification.sex;

    _changeName = false;
    _changeOccupation = false;
    _changePatient = false;
    _changeAge = false;
    _changeSex = false;

    super.initState();
  }

  void radioButtonChangeOccupation(String value) {
    setState(() {
      _radioValueOccupation = value;
    });
  }

  void radioButtonChangeSex(String value) {
    setState(() {
      _radioValueSex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Revisão de dados"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _notifyName(),
          SizedBox(height: 20),
          _occupation(),
          SizedBox(height: 20),
          _patientName(),
          SizedBox(height: 20),
          _age(),
          SizedBox(height: 20),
          _sex(),
        ],
      ),
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (!_changeName &&
            !_changeAge &&
            !_changeOccupation &&
            !_changePatient &&
            !_changeSex) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MandatoryData(widget.notification)));
        } else {
          _changingElement(context);
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: (_changeName ||
              _changeAge ||
              _changeOccupation ||
              _changePatient ||
              _changeSex)
          ? Colors.red[50]
          : Colors.redAccent,
    );
  }

  _notifyName() {
    return _changeName
        ? TextChangeFormField(
            data[0],
            name,
            functionToCancel: () => _saveNewData(
              data[0],
              this.widget.notification.notifying,
            ),
            widget: CheckButton(
              function: () => _saveNewData(data[0], name.text),
            ),
          )
        : TextPreview(
            data[0],
            string2: this.widget.notification.notifying,
            function: () => _change(data[0]),
          );
  }

  _occupation() {
    return _changeOccupation
        ? Column(children: <Widget>[
            Text(
              data[1],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            RadioButtonListChangeField(
              listOccupations,
              radioValue: _radioValueOccupation,
              radioButtonChanges: (String value) =>
                  radioButtonChangeOccupation(value),
              widget: CheckButton(
                  function: () => _saveNewData(data[1], _radioValueOccupation)),
            )
          ])
        : TextPreview(
            data[1],
            string2: this.widget.notification.occupation,
            function: () => _change(data[1]),
          );
  }

  _patientName() {
    return _changePatient
        ? TextChangeFormField(
            data[2],
            patient,
            functionToCancel: () => _saveNewData(
              data[2],
              this.widget.notification.patient,
            ),
            widget: CheckButton(
              function: () => _saveNewData(data[2], patient.text),
            ),
          )
        : TextPreview(
            data[2],
            string2: this.widget.notification.patient,
            function: () => _change(data[2]),
          );
  }

  _age() {
    return _changeAge
        ? TextChangeFormField(
            data[3],
            age,
            number: true,
            functionToCancel: () => _saveNewData(
              data[3],
              this.widget.notification.age,
            ),
            widget: CheckButton(
              function: () => _saveNewData(data[3], age.text),
            ),
          )
        : TextPreview(
            data[3],
            string2: this.widget.notification.age,
            function: () => _change(data[3]),
          );
  }

  _sex() {
    return _changeSex
        ? Column(
            children: <Widget>[
              Text(
                data[4],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              RadioButtonListChangeField(
                listSex,
                radioValue: _radioValueSex,
                radioButtonChanges: (String value) =>
                    radioButtonChangeSex(value),
                widget: CheckButton(
                  function: () => _saveNewData(data[4], _radioValueSex),
                ),
              )
            ],
          )
        : TextPreview(
            data[4],
            string2: this.widget.notification.sex,
            function: () => _change(data[4]),
          );
  }

  _change(String string) {
    if (string.compareTo(data[0]) == 0)
      setState(() {
        _changeName = !_changeName;
      });
    else if (string.compareTo(data[1]) == 0)
      setState(() {
        _changeOccupation = !_changeOccupation;
      });
    else if (string.compareTo(data[2]) == 0)
      setState(() {
        _changePatient = !_changePatient;
      });
    else if (string.compareTo(data[3]) == 0)
      setState(() {
        _changeAge = !_changeAge;
      });
    else if (string.compareTo(data[4]) == 0)
      setState(() {
        _changeSex = !_changeSex;
      });
  }

  _saveNewData(String field, dynamic newData) {
    if (field.compareTo(data[0]) == 0) {
      if (newData.length == 0) newData = "Não informado";
      setState(() {
        this.widget.notification.setNotifying(newData);
        name = TextEditingController(text: this.widget.notification.notifying);
      });
    } else if (field.compareTo(data[1]) == 0)
      setState(() {
        this.widget.notification.setOccupation(newData);

        _radioValueOccupation = this.widget.notification.occupation;
      });
    else if (field.compareTo(data[2]) == 0) {
      if (newData.length == 0) newData = "Não informado";
      setState(() {
        this.widget.notification.setPatient(newData);
        patient = TextEditingController(text: this.widget.notification.patient);
      });
    } else if (field.compareTo(data[3]) == 0) {
      if (newData.length == 0) newData = "Não informado";
      setState(() {
        this.widget.notification.setAge(newData);
        age = TextEditingController(text: this.widget.notification.age);
      });
    } else if (field.compareTo(data[4]) == 0)
      setState(() {
        this.widget.notification.setSex(newData);
        _radioValueSex = this.widget.notification.sex;
      });

    _change(field);
  }

  _changingElement(BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Salve ou cancele as alterações antes de prosseguir.",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
