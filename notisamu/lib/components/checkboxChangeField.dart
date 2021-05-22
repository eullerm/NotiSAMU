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
      children: incidents.category.keys
          .map<Widget>((String key) => ExpansionTile(
                title: _text(key),
                children: <Widget>[
                  _questionsToList(incidents, key),
                  SizedBox(height: 20),
                ],
              ))
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

  //Exibição dos incidentes
  _questionsToList(Incidents incidents, String string) {
    Map map = incidents.category[string];
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
        color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
      ),
    );
  }
}
