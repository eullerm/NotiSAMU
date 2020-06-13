import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsNotice extends StatefulWidget {
  final DocumentSnapshot notice;

  DetailsNotice(this.notice);

  @override
  _DetailsNoticeState createState() => _DetailsNoticeState();
}

class _DetailsNoticeState extends State<DetailsNotice> {
  Map<String, bool> _incidents = {
    "Incidente com dano": false,
    "Incidente sem dano": false,
    "Circunstancia notificavel": false,
    "Quase erro": false,
  };

  int buttonState = 2;
  Color colorButton = Colors.blue;
  IconData buttonIcon = Icons.assignment; //alterar
  bool showCheckBox = false;

  final database = Firestore.instance;

  final snackBar = SnackBar(
    content: Text('Inserido com sucesso!'),
  );

  @override
  void initState() {
    super.initState();
    _incidents.forEach((key, value) {
      if (key.compareTo(widget.notice.data['incident']) == 0) {
        value = true;
        buttonState = 1;
        colorButton = Colors.orange;
        buttonIcon = Icons.update; //alterar
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
      ),
      body: _body(context),
      floatingActionButton: _buttonFAB(buttonIcon, colorButton, buttonState),
    );
  }

  _body(context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: _information(),
        ),
        Positioned(
          bottom: 40,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: showCheckBox
                ? _checkboxIncidents(context)
                : Container(
                    key: ValueKey<bool>(showCheckBox),
                  ),
          ),
        )
      ],
    );
  }

  _information() {
    return <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _textColumn("Relator:", widget.notice.data['notifying']),
            _textColumn("Profissão:", widget.notice.data['profission']),
            _textColumn("Paciente:", widget.notice.data['patient']),
            _textColumn(
                "Nascimento:",
                DateFormat("dd/MM/yyyy")
                    .format(widget.notice.data['birth'].toDate())),
            _textColumn("Sexo:", widget.notice.data['sex']),
            _textColumn(
                "Nº da ocorrência:", widget.notice.data['occurrenceNumber']),
            _textColumn("Local:", widget.notice.data['local']),
            _textColumn(
                "Data da ocorrência:",
                DateFormat("dd/MM/yyyy")
                    .format(widget.notice.data['occurrenceDate'].toDate())),
            _textColumn("Periodo:", widget.notice.data['period']),
            _textColumn("Incidentes:", widget.notice.data['incident']),
            //Foi necessario fazer o .reversed pois o firebase manda o map de trás para frente.
            _textMap(
                "Respostas:",
                Map.fromEntries(
                    widget.notice.data['answer'].entries.toList().reversed)),
            _textColumn("Info extra:", widget.notice.data['infoExtra']),
            SizedBox(height: 50),
          ],
        ),
      )
    ];
  }

  _text(String perguntas) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _textColumn(String string, String string2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          string2,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _textMap(String string, Map map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Column(
          children: map.entries
              .map<Widget>(
                (entry) => _textRow(entry.key, entry.value),
              )
              .toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _textRow(String string, String string2) {
    return Row(
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(width: 5),
        Text(
          string2,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  _buttonFAB(IconData icon, Color color, int integer) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: FloatingActionButton(
        key: ValueKey<IconData>(icon),
        onPressed: () {
          switch (integer) {
            case 1: //Insere
              setState(() {
                buttonState = 3;
                showCheckBox = true;
                buttonIcon = Icons.check;
                colorButton = Colors.green;
              });

              break;
            case 2: //Muda

              setState(() {
                buttonState = 3;
                showCheckBox = true;
                buttonIcon = Icons.check;
                colorButton = Colors.green;
              });
              break;

            case 3: //Confirma
              setState(() {
                _incidents.forEach((key, value) {
                  if (value) _addIncident(key);
                });

                if (widget.notice.data['incident'].isEmpty) {
                  buttonState = 1;
                  buttonIcon = Icons.assignment;
                  colorButton = Colors.blue;
                } else {
                  buttonState = 2;
                  buttonIcon = Icons.update;
                  colorButton = Colors.orange;
                }
                showCheckBox = false;
              });
              break;

            default:
              break;
          }
        },
        child: Icon(icon),
        backgroundColor: color,
        shape: CircleBorder(),
      ),
    );
  }

  _checkboxIncidents(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckBox),
      width: MediaQuery.of(this.context).size.width - 48,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.grey[200]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _incidents.keys
            .map<Widget>(
              (String key) => CheckboxListTile(
                title: _text(key),
                value: _incidents[key],
                onChanged: (bool value) {
                  setState(() {
                    _incidents.forEach((k, v) {
                      _incidents[k] = false;
                    });
                    _incidents[key] = value;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _addIncident(String incident) async {
    await database
        .collection("notification")
        .document(widget.notice.documentID)
        .setData(
          {
            'incident': incident,
          },
          merge: true,
        )
        .timeout(Duration(seconds: 10))
        .whenComplete(() => setState(() {
              Navigator.of(context).pop(
                MaterialPageRoute(
                    builder: (context) => DetailsNotice(widget.notice)),
              );
            }))
        .catchError((error) => print("${error}"));
  }
}
