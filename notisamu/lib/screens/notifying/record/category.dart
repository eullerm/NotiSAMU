import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkboxChangeField.dart';
import 'package:noti_samu/objects/incidents.dart';
import 'package:noti_samu/screens/notifying/record/infoExtra.dart';
import 'package:noti_samu/objects/notification.dart';

class Category extends StatefulWidget {
  Notify notification;
  Category(this.notification);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Incidents incidents = Incidents();

  String message;

  @override
  void initState() {
    super.initState();
    //Caso ja tenha algum incidente guardado
    if (this.widget.notification.category != null) {
      for (var exist in this.widget.notification.category) {
        incidents.selectedCategory(exist);
        for (var exist2 in this.widget.notification.answer) {
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
        title: Text("Registro de dados da ocorrência"),
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
          ],
        ),
      ),
    );
  }

  _checkboxMapCategoryQuestions(Incidents incidents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: incidents.category.keys
          .map<Widget>(
            (string) => Column(
              children: <Widget>[
                _checkboxCategory(incidents, string),
                _validateAnswer(incidents, string),
                SizedBox(height: 20),
              ],
            ),
          )
          .toList(),
    );
  }

  //Explicação de cada categoria
  _explanation(String type) {
    String _text;

    for (var compare in incidents.category.keys) {
      if (compare.compareTo(type) == 0) {
        _text = incidents.mapCategoryExplanation[type];
        break;
      }
    }

    return GestureDetector(
      child: Icon(Icons.info),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          title: Text(
            type,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            ),
          ],
        ),
      ),
    );
  }

  //Cria um checkbox para cada categoria
  _checkboxCategory(Incidents incidents, String key) {
    return Row(
      children: <Widget>[
        _explanation(key),
        SizedBox(width: 5.0),
        Expanded(
          child: GestureDetector(
            child: _text(key),
            onTap: () => setState(
              () {
                incidents.selectedCategory(key,
                    booleana: !incidents.category[key]);
              },
            ),
          ),
        ),
        Checkbox(
          value: incidents.category[key],
          onChanged: (bool value) {
            setState(
              () {
                incidents.selectedCategory(key, booleana: value);
              },
            );
          },
        ),
      ],
    );
  }

  //Se a categoria estiver marcada exibe os incidentes
  _validateAnswer(Incidents incidents, String key) {
    return incidents.category[key] == true
        ? _questionsToList(incidents, key)
        : SingleChildScrollView(
            child: Container(),
          );
  }

  //Exibição dos incidentes
  _questionsToList(Incidents incidents, String string) {
    Map map = incidents.mapCategoryQuestions[string];
    return Container(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Column(
        children: map.keys
            .map<Widget>(
              (key) => CheckboxListTile(
                title: _text(key),
                value: map[key],
                onChanged: (bool change) {
                  setState(() {
                    incidents.selectedIncident(string, key, change);
                  });
                },
              ),
            )
            .toList(),
      ),
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

  //teste//
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

  //----//

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
        if (this.widget.notification.answer.isNotEmpty)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InfoExtra(widget.notification)));
        else
          _missingElement(context);
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
