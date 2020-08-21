import 'package:flutter/material.dart';
import 'package:noti_samu/objects/incidents.dart';

class CheckboxChangeField extends StatelessWidget {
  CheckboxChangeField(
    this.incidents, {
    this.changeCategoryWithKey,
    this.changeCategoryWithValue,
    this.changeIncident,
  });

  final Incidents incidents;
  final Function changeCategoryWithKey;
  final Function changeCategoryWithValue;
  final Function changeIncident;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: incidents.category.keys
          .map<Widget>(
            (string) => Column(
              children: <Widget>[
                _checkboxCategory(incidents, string, context),
                _validateAnswer(incidents, string),
                SizedBox(height: 20),
              ],
            ),
          )
          .toList(),
    );
  }

  //Explicação de cada categoria
  _explanation(String type, BuildContext context) {
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
  _checkboxCategory(Incidents incidents, String key, BuildContext context) {
    return Row(
      children: <Widget>[
        _explanation(key, context),
        SizedBox(width: 5.0),
        Expanded(
          child: GestureDetector(
              child: _text(key), onTap: () => changeCategoryWithKey(key)),
        ),
        Checkbox(
            value: incidents.category[key],
            onChanged: (bool value) => changeCategoryWithValue(key, value)),
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
                onChanged: (bool change) => changeIncident(string, key, change),
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
}
