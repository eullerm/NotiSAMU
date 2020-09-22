import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkboxChangeField.dart';
import 'package:noti_samu/objects/incidents.dart';
import 'package:noti_samu/screens/notifying/record/infoExtra.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/record/routes.dart';

class Category extends StatefulWidget {
  Notify notification;
  Category(this.notification);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Incidents incidents = Incidents();
  bool isWrongRoute;

  String message;

  @override
  void initState() {
    super.initState();
    isWrongRoute = false;
    //Caso ja tenha algum incidente guardado
    if (this.widget.notification.category != null) {
      for (var exist in this.widget.notification.category) {
        incidents.selectedCategory(exist);
        for (var exist2 in this.widget.notification.incidents) {
          incidents.selectedIncident(exist, exist2, true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 8),
            _text("Categoria de incidente: "),
            SizedBox(
              height: 16,
            ),
            CheckboxChangeField(
              incidents,
              changeCategoryWithKey: (String key) => _selectedCategory(key),
              changeCategoryWithValue: (String key, bool change) =>
                  _selectedCategory(key, value: change),
              changeIncident: (String key1, String key2, bool change) =>
                  _selectedIncidents(key1, key2, change),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _selectedCategory(String key, {bool value}) {
    setState(
      () {
        value == null
            ? incidents.selectedCategory(key,
                booleana: !incidents.category[key])
            : incidents.selectedCategory(key, booleana: value);
      },
    );
  }

  _selectedIncidents(String key1, String key2, bool value) {
    setState(
      () {
        incidents.selectedIncident(key1, key2, value);
      },
    );
  }

  _text(perguntas, {bool error}) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
        color: (error != null && error) ? Colors.red : Colors.black,
      ),
    );
  }

  _missingElement(BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione um incidente.",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this
            .widget
            .notification
            .clearCategorys(); //Garante que a lista de incidentes vai estar limpa
        this.widget.notification.clearIncidents();
        incidents.category.forEach((k, v) {
          if (v && incidents.isIncidentSelected(k)) {
            this.widget.notification.setCategory(k);
            incidents.mapCategoryQuestions.forEach((key, listQuestions) {
              if (key == k) {
                for (var question in listQuestions.keys.toList()) {
                  if (listQuestions[
                      question]) //Se a boleana da resposta for true coloca a resposta na notificação
                    this.widget.notification.setIncident(question);
                }
              }
            });
          }
        });

        if (this.widget.notification.incidents.isNotEmpty) {
          this.widget.notification.incidents.forEach((element) {
            if (element.compareTo("Via errada") == 0) {
              isWrongRoute = true;
            }
          });
          if (isWrongRoute) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Routes(this.widget.notification)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InfoExtra(this.widget.notification)));
          }
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
