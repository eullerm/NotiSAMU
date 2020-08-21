import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkboxChangeField.dart';
import 'package:noti_samu/objects/incidents.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/screens/notifying/dataPreview/InfoExtraPreview.dart';

class SpecificData extends StatefulWidget {
  Notify notification;
  SpecificData(this.notification);
  @override
  _SpecificDataState createState() => _SpecificDataState();
}

class _SpecificDataState extends State<SpecificData> {
  List<String> data = [
    "Categorias:",
    "Incidentes:",
  ];

  Incidents incidents = Incidents();

  bool _changeCategory;
  bool _changeIncidents;

  @override
  void initState() {
    //Caso ja tenha algum incidente guardado
    if (this.widget.notification.category != null) {
      for (var exist in this.widget.notification.category) {
        incidents.selectedCategory(exist);
        for (var exist2 in this.widget.notification.answer) {
          incidents.selectedIncident(exist, exist2, true);
        }
      }
    }

    _changeCategory = false;
    _changeIncidents = false;
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dados especificos."),
      ),
      body: _body(context),
      floatingActionButton: (_changeCategory || _changeIncidents)
          ? Builder(builder: (context) => _changeButton(context))
          : _buttonNext(),
    );
  }

  _body(context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: (_changeCategory || _changeIncidents)
          ? <Widget>[
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
            ]
          : <Widget>[
              _category(),
              SizedBox(height: 20),
              _incidents(),
              SizedBox(height: 20),
            ],
    );
  }

  _category() {
    return TextPreview(
      data[0],
      list: this.widget.notification.category,
      itsList: true,
      function: () => _change(data[0]),
    );
  }

  _incidents() {
    return TextPreview(
      data[1],
      list: this.widget.notification.answer,
      itsList: true,
      function: () => _change(data[1]),
    );
  }

  _change(String string) {
    if (string.compareTo(data[0]) == 0)
      setState(() {
        _changeCategory = !_changeCategory;
      });
    else if (string.compareTo(data[1]) == 0)
      setState(() {
        _changeIncidents = !_changeIncidents;
      });
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

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InfoExtraPreview(widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _changeButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this
            .widget
            .notification
            .incidentClear(); //Garante que a lista de incidentes vai estar limpa
        this.widget.notification.answerClear();
        incidents.category.forEach((k, v) {
          if (v == true) {
            this.widget.notification.setIncident(k);
            incidents.mapCategoryQuestions.forEach((key, listQuestions) {
              if (key == k) {
                for (var question in listQuestions.keys.toList()) {
                  if (listQuestions[
                      question]) //Se a boleana da resposta for true coloca a resposta na notificação
                    this.widget.notification.setAnswer(question);
                }
              }
            });
          }
        });
        if (this.widget.notification.answer.isNotEmpty) {
          setState(() {
            _changeCategory = false;
            _changeIncidents = false;
          });
        } else
          _missingElement(context);
      },
      label: Text('Confirmar'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.green,
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
}
