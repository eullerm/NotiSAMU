import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_samu/objects/bases.dart';

class DetailsNotice extends StatefulWidget {
  final DocumentSnapshot notice;
  final bool admin;

  DetailsNotice(this.notice, this.admin);

  @override
  _DetailsNoticeState createState() => _DetailsNoticeState();
}

class _DetailsNoticeState extends State<DetailsNotice> {
  Map<String, bool> _classifications = {
    "Incidente com dano": false,
    "Incidente sem dano": false,
    "Circunstância notificável": false,
    "Quase erro": false,
  };
  String _class = "";

  int buttonState = 2;
  Color colorButton = Color(0xFF002C3E);
  IconData buttonIcon = Icons.assignment;
  bool showCheckBox = false;

  final database = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _classifications.forEach((key, value) {
      if (key.compareTo(widget.notice.data['classification']) == 0) {
        _classifications[key] = true;
        _class = key;
        buttonState = 1;
        colorButton = Color(0xFF78BCC4); //talvez trocar para 0xFF777D71);
        buttonIcon = Icons.assignment; //alterar
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("NotiSAMU"),
      ),
      body: _body(context),
      floatingActionButton: this.widget.admin
          ? _buttonFAB(buttonIcon, colorButton, buttonState)
          : Container(),
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
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: showCheckBox
                ? _checkboxClassifications(context)
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _textColumn("Relator:", widget.notice.data['notifying']),
            this.widget.admin
                ? _textColumn("Base:",
                    Bases().getSpecificBase(widget.notice.data['base']))
                : Container(),
            _textColumn("Profissão:", widget.notice.data['occupation']),
            _textColumn("Paciente:", widget.notice.data['patient']),
            _textColumn("Idade:", widget.notice.data['age']),
            _textColumn("Sexo:", widget.notice.data['sex']),
            _textColumn(
                "Nº da ocorrência:", widget.notice.data['occurrenceNumber']),
            _textColumn("Local:", widget.notice.data['local']),
            _textColumn(
                "Data da ocorrência:",
                DateFormat("dd/MM/yyyy")
                    .format(widget.notice.data['occurrenceDate'].toDate())),
            _textColumn("Periodo:", widget.notice.data['period']),
            _textList("Medicamentos:", widget.notice.data['medicines']),
            _textList("Categorias:", widget.notice.data['category']),
            _textList("Incidentes:", widget.notice.data['incident']),
            widget.notice.data['route'] != null
                ? _textColumn("Via:", widget.notice.data['route'])
                : Container(),
            _textColumn("Classificação:", widget.notice.data['classification']),
            _textColumn("Info extra:", widget.notice.data['infoExtra']),
            this.widget.admin ? SizedBox(height: 50) : Container(),
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
        SizedBox(
          height: 5,
        ),
        Text(
          string2,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _textList(String string, List list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .map<Widget>(
                (entry) => Text(
                  entry,
                  style: TextStyle(fontSize: 20),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _buttonFAB(IconData icon, Color color, int integer) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: FloatingActionButton.extended(
        label: showCheckBox ? Text('Confirmar') : Text("Classificar"),
        key: ValueKey<IconData>(icon),
        tooltip: "Adicionar uma classificação",
        onPressed: () {
          switch (integer) {
            case 1: //Insere
              setState(() {
                buttonState = 3;
                showCheckBox = true;
                buttonIcon = Icons.check;
                colorButton = Color(0xFF648D56);
              });

              break;
            case 2: //Muda

              setState(() {
                buttonState = 3;
                showCheckBox = true;
                buttonIcon = Icons.check;
                colorButton = Color(0xFF648D56);
              });
              break;

            case 3: //Confirma
              setState(() {
                _classifications.forEach((key, value) {
                  if (value) _addClassification(key);
                });

                if (widget.notice.data['classification'].isEmpty) {
                  buttonState = 1;
                  buttonIcon = Icons.assignment;
                  colorButton = Color(0xFF002C3E);
                } else {
                  buttonState = 2;
                  buttonIcon = Icons.assignment;
                  colorButton = Color(0xFF78BCC4); //talvez trocar  0xFF777D71;
                }
                showCheckBox = false;
              });
              break;

            default:
              break;
          }
        },
        icon: Icon(icon),
        backgroundColor: color,
      ),
    );
  }

  _checkboxClassifications(BuildContext context) {
    return Container(
      key: ValueKey<bool>(showCheckBox),
      width: MediaQuery.of(this.context).size.width - 48,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(right: 8, left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Color(0xFFFFF8DC)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CloseButton(
              onPressed: () {
                setState(() {
                  setState(() {
                    if (widget.notice.data['classification'].isEmpty) {
                      buttonState = 1;
                      buttonIcon = Icons.assignment;
                      colorButton = Color(0xFF002C3E);
                    } else {
                      buttonState = 2;
                      buttonIcon = Icons.assignment;
                      colorButton =
                          Color(0xFF78BCC4); //talvez trocar  0xFF777D71;
                    }
                    showCheckBox = false;
                  });
                });
              },
            )
          ],
        ),
        Column(
          children: _classifications.keys
              .map<Widget>(
                (String key) => RadioListTile(
                  title: _text(key),
                  activeColor: Color(0xFF648D56),
                  value: key,
                  groupValue: _class,
                  onChanged: (value) {
                    setState(() {
                      _class = value;
                      _classifications.forEach((k, v) {
                        _classifications[k] = false;
                      });
                      _classifications[value] = true;
                    });
                  },
                ),
              )
              .toList(),
        ),
      ]),
    );
  }

  _addClassification(String classification) async {
    await database
        .collection("notification")
        .document(widget.notice.documentID)
        .setData(
          {
            'classification': classification,
          },
          merge: true,
        )
        .timeout(Duration(seconds: 10))
        .whenComplete(() => setState(() {
              Navigator.of(context).pop(
                MaterialPageRoute(
                    builder: (context) =>
                        DetailsNotice(widget.notice, widget.admin)),
              );
            }))
        .catchError((error) => print("$error"));
  }
}
