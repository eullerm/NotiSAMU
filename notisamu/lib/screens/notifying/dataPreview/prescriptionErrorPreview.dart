import 'package:flutter/material.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/InfoExtraPreview.dart';
import 'package:page_transition/page_transition.dart';

class PrescriptionErrorPreview extends StatefulWidget {
  Notify notification;
  PrescriptionErrorPreview(this.notification);
  @override
  _PrescriptionErrorPreviewState createState() => _PrescriptionErrorPreviewState();
}

class _PrescriptionErrorPreviewState extends State<PrescriptionErrorPreview> {
  String _radioValueIsMedicineUsed;
  String _radioValueReaction;
  TextEditingController information = TextEditingController();

  bool _error;
  bool _changeIsMedicineUsed;
  bool _changeWrongMedicinesUsed;
  bool _changeIsReaction;
  bool _changeInfoAboutReaction;

  Map<String, bool> listMedicines, filteredMedicines;

  List<String> _wrongMedicinesUsed = [];

  @override
  void initState() {
    _error = false;
    _changeIsMedicineUsed = false;
    _changeWrongMedicinesUsed = false;
    _changeIsReaction = false;
    _changeInfoAboutReaction = false;
    if (this.widget.notification.isWrongMedicineUsed != null) _radioValueIsMedicineUsed = this.widget.notification.isWrongMedicineUsed;
    if (this.widget.notification.isMedicineReaction != null) _radioValueReaction = this.widget.notification.isMedicineReaction;
    if (this.widget.notification.infoAboutReaction != null) information = TextEditingController(text: this.widget.notification.infoAboutReaction);
    listMedicines = filteredMedicines = Map.fromIterable(this.widget.notification.medicines, key: (e) => e, value: (e) => false);
    if (this.widget.notification.wrongMedicinesUsed.isNotEmpty) {
      this.widget.notification.wrongMedicinesUsed.forEach((element) {
        if (this.widget.notification.medicines.contains(element)) {
          _wrongMedicinesUsed.add(element);
        }
        listMedicines[element] = true;
        filteredMedicines[element] = true;
      });
    }
    super.initState();
  }

  void radioButtonChangeMedicineUsed(String value) {
    setState(() {
      _radioValueIsMedicineUsed = value;
      if (value.compareTo("Não") == 0) {
        _radioValueReaction = null;
      }
    });
  }

  void radioButtonChangeReaction(String value) {
    setState(() {
      _radioValueReaction = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("Erro de prescrição"),
      ),
      body: _body(context),
      floatingActionButton: (_changeIsMedicineUsed || _changeWrongMedicinesUsed || _changeIsReaction || _changeInfoAboutReaction)
          ? Builder(builder: (context) => _changeButton(context))
          : _buttonNext(),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: (_changeIsMedicineUsed || _changeWrongMedicinesUsed || _changeIsReaction || _changeInfoAboutReaction)
              ? _changingData()
              : <Widget>[
                  _radioValueIsMedicineUsed != null
                      ? TextPreview(
                          "O medicamento chegou a ser administrado?",
                          string2: _radioValueIsMedicineUsed,
                          function: () {
                            setState(() {
                              _changeIsMedicineUsed = !_changeIsMedicineUsed;
                              _changeWrongMedicinesUsed = !_changeWrongMedicinesUsed;
                              _changeIsReaction = !_changeIsReaction;
                              _changeInfoAboutReaction = !_changeInfoAboutReaction;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(height: 20),
                  _wrongMedicinesUsed.isNotEmpty
                      ? TextPreview(
                          "Medicamentos selecionados",
                          list: _wrongMedicinesUsed,
                          isList: true,
                          function: () {
                            setState(() {
                              _changeIsMedicineUsed = !_changeIsMedicineUsed;
                              _changeWrongMedicinesUsed = !_changeWrongMedicinesUsed;
                              _changeIsReaction = !_changeIsReaction;
                              _changeInfoAboutReaction = !_changeInfoAboutReaction;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(height: 20),
                  _radioValueReaction != null
                      ? TextPreview(
                          "Houve alguma reação ao medicamento?",
                          string2: _radioValueReaction,
                          function: () {
                            setState(() {
                              _changeIsMedicineUsed = !_changeIsMedicineUsed;
                              _changeWrongMedicinesUsed = !_changeWrongMedicinesUsed;
                              _changeIsReaction = !_changeIsReaction;
                              _changeInfoAboutReaction = !_changeInfoAboutReaction;
                            });
                          },
                        )
                      : Container(),
                  SizedBox(height: 20),
                  (_radioValueReaction != null && information.text.isNotEmpty)
                      ? TextPreview(
                          "Descrição da reação",
                          string2: information.text,
                          function: () {
                            setState(() {
                              _changeIsMedicineUsed = !_changeIsMedicineUsed;
                              _changeWrongMedicinesUsed = !_changeWrongMedicinesUsed;
                              _changeIsReaction = !_changeIsReaction;
                              _changeInfoAboutReaction = !_changeInfoAboutReaction;
                            });
                          },
                        )
                      : Container(),
                ],
        ),
      ),
    );
  }

  _changingData() {
    return <Widget>[
      _changingMedicineUsed(),
      SizedBox(height: 20),
      _changingListMedicinesUsed(),
      SizedBox(height: 20),
      _changingReaction(),
      SizedBox(height: 20),
      _changingInfoAboutReaction(),
    ];
  }

  _changingMedicineUsed() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: _text("O medicamento chegou a ser administrado?*: ", error: _error),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        RadioButtonList(
          ["Sim", "Não"],
          radioValue: _radioValueIsMedicineUsed,
          radioButtonChanges: (String value) => radioButtonChangeMedicineUsed(value),
        )
      ],
    );
  }

  _changingListMedicinesUsed() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: _text("Selecione o medicamento envolvido no incidente*: ", error: _error),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        _searchBar(),
        Divider(),
        Container(
          height: 100,
          child: _listViewMedicines(),
        ),
        Divider(),
      ],
    );
  }

  _listViewMedicines() {
    return Scrollbar(
      isAlwaysShown: true,
      controller: ScrollController(),
      thickness: 8.0,
      radius: Radius.circular(50.0),
      child: ListView.builder(
        itemCount: filteredMedicines.length,
        itemBuilder: (BuildContext context, int index) {
          String key = filteredMedicines.keys.elementAt(index);
          return CheckboxListTile(
              title: _text(key),
              value: filteredMedicines[key],
              onChanged: (bool change) {
                setState(() {
                  filteredMedicines[key] = change;
                  listMedicines[key] = change;
                });
              });
        },
      ),
    );
  }

  _searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: TextField(
        onChanged: (value) => _filterMedicines(value),
        decoration: InputDecoration(
          hintText: "Filtrar medicamentos: ",
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  _filterMedicines(String value) {
    setState(() {
      List<String> list = listMedicines.keys.where((element) {
        value = value.toLowerCase();
        element = element.toLowerCase();
        return element.contains(value);
      }).toList();
      filteredMedicines = {};
      filteredMedicines = Map.fromIterable(
        list,
        key: (e) => e,
        value: (e) => listMedicines[e],
      );
    });
  }

  _changingReaction() {
    if (_radioValueIsMedicineUsed != null)
      return _radioValueIsMedicineUsed.compareTo("Sim") == 0
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topLeft,
                    child: _text("Houve alguma reação ao medicamento?*: ", error: _error),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                RadioButtonList(
                  ["Sim", "Não"],
                  radioValue: _radioValueReaction,
                  radioButtonChanges: (String value) => radioButtonChangeReaction(value),
                )
              ],
            )
          : Container();
    else {
      return Container();
    }
  }

  _changingInfoAboutReaction() {
    if (_radioValueReaction != null)
      return _radioValueReaction.compareTo("Sim") == 0
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: _text(
                        "Descreva a reação causada (Hipotensão, rebaixamento de nível de consciência, êmese, depressão respiratória, etc)*: ",
                        error: _error),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: information,
                  maxLength: 300,
                  maxLines: null,
                  minLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ],
            )
          : Container();
    else {
      return Container();
    }
  }

  _text(perguntas, {bool error}) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
        color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
      ),
    );
  }

  _missingElement(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione uma opção.",
          style: TextStyle(color: Color(0xFFF7444E)),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(PageTransition(
            duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: InfoExtraPreview(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Color(0xFFF7444E),
    );
  }

  _changeButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.clearWrongMedicinesUsed();

        this.widget.notification.setIsWrongMedicineUsed(_radioValueIsMedicineUsed);
        this.widget.notification.setIsMedicineReaction(_radioValueReaction);
        this.widget.notification.setInfoAboutReaction(information.text);
        listMedicines.forEach((key, value) {
          if (value) {
            this.widget.notification.setWrongMedicinesUsed(key);
          }
        });

        if (_radioValueIsMedicineUsed != null) {
          setState(() {
            _changeIsMedicineUsed = false;

            if (this.widget.notification.wrongMedicinesUsed.isNotEmpty) {
              _changeWrongMedicinesUsed = false;
              _wrongMedicinesUsed = this.widget.notification.wrongMedicinesUsed;
            } else {
              _changeWrongMedicinesUsed = true;
              _missingElement(context);
              _error = true;
            }

            if (_radioValueIsMedicineUsed.compareTo("Sim") == 0 && _radioValueReaction != null) {
              _changeIsReaction = false;
              if (_radioValueReaction.compareTo("Sim") == 0 && information.text.isNotEmpty) {
                _changeInfoAboutReaction = false;
              } else if (_radioValueReaction.compareTo("Não") == 0) {
                _changeInfoAboutReaction = false;
                information.clear();
              } else {
                _missingElement(context);
                _error = true;
              }
            } else if (_radioValueIsMedicineUsed.compareTo("Não") == 0) {
              _changeInfoAboutReaction = false;
              _changeIsReaction = false;
              information.clear();
            } else {
              _missingElement(context);
              _error = true;
            }
          });
        } else {
          _missingElement(context);
          setState(() {
            _error = true;
          });
        }
      },
      label: Text('Confirmar'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.green,
    );
  }
}
