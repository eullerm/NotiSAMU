import 'package:flutter/material.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/record/category.dart';
import 'package:page_transition/page_transition.dart';

class Medicines extends StatefulWidget {
  Notify notification;
  Medicines(this.notification);
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  Map<String, bool> listMedicines, filtredMecines;
  bool _error;

  @override
  void initState() {
    listMedicines = filtredMecines = Map.fromIterable(ListMedicines().medicines,
        key: (e) => e, value: (e) => false);
    if (this.widget.notification.medicines.isNotEmpty) {
      this.widget.notification.medicines.forEach((element) {
        listMedicines[element] = true;
        filtredMecines[element] = true;
      });
    }
    _error = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
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
            _text("*Selecione os medicamentos usados no atendimento",
                error: _error),
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
        ),
      ),
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

  _filterMedicines(String value) {
    setState(() {
      List<String> list = listMedicines.keys.where((element) {
        value = value.toLowerCase();
        element = element.toLowerCase();
        return element.contains(value);
      }).toList();
      filtredMecines = {};
      filtredMecines = Map.fromIterable(
        list,
        key: (e) => e,
        value: (e) => listMedicines[e],
      );
    });
  }

  _text(String string, {bool error}) {
    return Text(
      string,
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
          "Selecione ao menos um medicamento.",
          style: TextStyle(color: Color(0xFFF7444E)),
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
          Navigator.of(context).push(PageTransition(
              duration: Duration(milliseconds: 200),
              type: PageTransitionType.rightToLeft,
              child: Category(this.widget.notification)));
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
