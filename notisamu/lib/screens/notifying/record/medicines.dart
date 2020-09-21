import 'package:flutter/material.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/record/category.dart';

class Medicines extends StatefulWidget {
  Notify notification;
  Medicines(this.notification);
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  Map<String, bool> listMedicines,
      filtredMecines = Map.fromIterable(ListMedicines().medicines,
          key: (e) => e, value: (e) => false);

  @override
  void initState() {
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
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            _text("Selecione os medicamentos usados no atendimento"),
            SizedBox(
              height: 16,
            ),
            _search(),
            SizedBox(
              height: 8,
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  _medicines(),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _medicines() {
    return Column(
      children: filtredMecines.keys
          .map<Widget>((key) => CheckboxListTile(
              title: _text(key),
              value: filtredMecines[key],
              onChanged: (bool change) {
                setState(() {
                  filtredMecines[key] = change;
                  listMedicines[key] = change;
                });
              }))
          .toList(),
    );
  }

  _search() {
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

  _filterMedicines(String value) {
    setState(() {
      filtredMecines = listMedicines.keys
          .where((element) => element.compareTo(value) == 0)
          .toList();
    });
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

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.clearMedicines();

        listMedicines.forEach((key, value) {
          if (value) {
            this.widget.notification.setMedicines(key);
          }
        });

        if (this.widget.notification.medicines.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Category(this.widget.notification)));
        } else {
          _missingElement(context);
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
