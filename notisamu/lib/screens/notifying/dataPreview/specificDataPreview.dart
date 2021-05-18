import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkboxChangeField.dart';
import 'package:noti_samu/objects/incidents.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/screens/notifying/dataPreview/InfoExtraPreview.dart';
import 'package:noti_samu/screens/notifying/dataPreview/routesPreview.dart';
import 'package:page_transition/page_transition.dart';

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
  bool _isWrongRoute;

  @override
  void initState() {
    //Caso ja tenha algum incidente guardado
    if (this.widget.notification.category != null) {
      for (var exist in this.widget.notification.category) {
        incidents.selectedCategory(exist);
        for (var exist2 in this.widget.notification.incidents) {
          incidents.selectedIncident(exist, exist2, true);
        }
      }
    }

    _changeCategory = false;
    _changeIncidents = false;
    _isWrongRoute = false;
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
        backgroundColor: Color(0xFFF7444E),
        title: Text("Dados específicos"),
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
      isList: true,
      function: () => _change(data[0]),
    );
  }

  _incidents() {
    return TextPreview(
      data[1],
      list: this.widget.notification.incidents,
      isList: true,
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
        color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.incidents.forEach((element) {
          if (element.compareTo("Via errada") == 0) {
            setState(() {
              _isWrongRoute = true;
            });
          }
        });
        if (_isWrongRoute) {
          Navigator.of(context).push(PageTransition(
              duration: Duration(milliseconds: 200),
              type: PageTransitionType.rightToLeft,
              child: RoutesPreview(this.widget.notification)));
        } else {
          Navigator.of(context).push(PageTransition(
              duration: Duration(milliseconds: 200),
              type: PageTransitionType.rightToLeft,
              child: InfoExtraPreview(this.widget.notification)));
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Color(0xFFF7444E),
    );
  }

  _changeButton(BuildContext context) {
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
        setState(() {
          _isWrongRoute = false; //Caso ele tenha ido para a proxima tela e
          //voltado para modificar algo nessa
        });
        if (this.widget.notification.incidents.isNotEmpty) {
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
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione ao menos um incidente.",
          style: TextStyle(color: Color(0xFFF7444E)),
        ),
      ),
    );
  }
}
