import 'package:flutter/material.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:page_transition/page_transition.dart';
import 'infoExtra.dart';

class PrescriptionError extends StatefulWidget {
  Notify notification;
  PrescriptionError(this.notification);
  @override
  _PrescriptionErrorState createState() => _PrescriptionErrorState();
}

class _PrescriptionErrorState extends State<PrescriptionError> {
  String _radioValueIsMedicineUsed;
  String _radioValueReaction;
  TextEditingController information = TextEditingController();

  bool _error;

  Map<String, bool> listMedicines, filteredMedicines;

  @override
  void initState() {
    _error = false;
    listMedicines = filteredMedicines = Map.fromIterable(this.widget.notification.medicines, key: (e) => e, value: (e) => false);
    if (this.widget.notification.wrongMedicinesUsed.isNotEmpty) {
      this.widget.notification.wrongMedicinesUsed.forEach((element) {
        listMedicines[element] = true;
        filteredMedicines[element] = true;
      });
    }

    if (this.widget.notification.infoAboutReaction != null) information = TextEditingController(text: this.widget.notification.infoAboutReaction);
    if (this.widget.notification.isWrongMedicineUsed != null) _radioValueIsMedicineUsed = this.widget.notification.isWrongMedicineUsed;
    if (this.widget.notification.isMedicineReaction != null) _radioValueReaction = this.widget.notification.isMedicineReaction;
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
        title: Text("Erro de Prescrição"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            _isMedicineUsed(),
            _medicineUsed(),
            _medicineReaction(),
            _infoReaction(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _isMedicineUsed() {
    return Column(
      children: [
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

  _medicineUsed() {
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

  _medicineReaction() {
    if (_radioValueIsMedicineUsed != null)
      return _radioValueIsMedicineUsed.compareTo("Sim") == 0
          ? Column(
              children: [
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

  _infoReaction() {
    if (_radioValueReaction != null)
      return _radioValueReaction.compareTo("Sim") == 0
          ? Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: _text("Descreva a reação causada*: ", error: _error),
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

  _buttonNext(BuildContext context) {
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
        if (this.widget.notification.isWrongMedicineUsed != null && this.widget.notification.wrongMedicinesUsed.isNotEmpty) {
          if (this.widget.notification.isWrongMedicineUsed.compareTo("Sim") == 0) {
            if (this.widget.notification.isMedicineReaction == null) {
              _missingElement(context);
              setState(() {
                _error = true;
              });
            } else if (this.widget.notification.isMedicineReaction.compareTo("Sim") == 0 && this.widget.notification.infoAboutReaction.isEmpty) {
              _missingElement(context);
              setState(() {
                _error = true;
              });
            } else {
              this.widget.notification.setIsMedicineReaction(_radioValueReaction);

              Navigator.of(context).push(PageTransition(
                  duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: InfoExtra(this.widget.notification)));
            }
          } else {
            this.widget.notification.setIsMedicineReaction(_radioValueReaction);

            Navigator.of(context).push(PageTransition(
                duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: InfoExtra(this.widget.notification)));
          }
        } else {
          _missingElement(context);
          setState(() {
            _error = true;
          });
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Color(0xFFF7444E),
    );
  }
}
