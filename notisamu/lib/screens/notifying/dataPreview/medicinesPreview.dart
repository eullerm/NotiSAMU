import 'package:flutter/material.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/specificDataPreview.dart';

class MedicinesPreview extends StatefulWidget {
  Notify notification;
  MedicinesPreview(this.notification);
  @override
  _MedicinesPreviewState createState() => _MedicinesPreviewState();
}

class _MedicinesPreviewState extends State<MedicinesPreview> {
  bool _changeMedicines;
  Map<String, bool> listMedicines, filtredMecines;

  @override
  void initState() {
    _changeMedicines = false;
    listMedicines = filtredMecines = Map.fromIterable(ListMedicines().medicines,
        key: (e) => e, value: (e) => false);
    this.widget.notification.medicines.forEach((element) {
      listMedicines[element] = true;
      filtredMecines[element] = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Medicamentos"),
      ),
      body: _body(context),
      floatingActionButton: _changeMedicines
          ? Builder(builder: (context) => _changeButton(context))
          : _buttonNext(),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
      child: Center(
        child: _changeMedicines
            ? _changeListMedicines()
            : TextPreview(
                "Medicamentos selecionados",
                list: this.widget.notification.medicines,
                itsList: true,
                function: () => _change(),
              ),
      ),
    );
  }

  _change() {
    setState(() {
      _changeMedicines = !_changeMedicines;
    });
  }

  _changeListMedicines() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        _text("*Selecione os medicamentos usados no atendimento"),
        SizedBox(
          height: 16,
        ),
        _searchBar(),
        SizedBox(
          height: 8,
        ),
        Divider(),
        Expanded(child: _listViewMedicines()),
        Divider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  _listViewMedicines() {
    return ListView.builder(
      itemCount: filtredMecines.length,
      itemBuilder: (BuildContext context, int index) {
        String key = filtredMecines.keys.elementAt(index);
        return CheckboxListTile(
            title: _text(key),
            value: filtredMecines[key],
            onChanged: (bool change) {
              setState(() {
                filtredMecines[key] = change;
                listMedicines[key] = change;
              });
            });
      },
    );
  }

  _searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: TextField(
        onChanged: (value) => _filterMedicines(value),
        decoration: InputDecoration(
          hintText: "Filtrar medicamentos:",
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  _text(perguntas) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _filterMedicines(String value) {
    setState(() {
      List<String> list = listMedicines.keys.where((element) {
        value = value.toLowerCase();
        element = element.toLowerCase();
        return element.startsWith(value);
      }).toList();
      filtredMecines = {};
      filtredMecines = Map.fromIterable(
        list,
        key: (e) => e,
        value: (e) => listMedicines[e],
      );
    });
  }

  _missingElement(BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione um medicamento.",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SpecificData(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _changeButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.clearMedicines();

        listMedicines.forEach((key, value) {
          if (value) {
            this.widget.notification.setMedicines(key);
          }
        });
        if (this.widget.notification.medicines.isNotEmpty) {
          setState(() {
            _changeMedicines = false;
          });
        } else
          _missingElement(context);
      },
      label: Text('Confirmar'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.green,
    );
  }
}
