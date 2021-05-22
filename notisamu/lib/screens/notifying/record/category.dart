import 'package:flutter/material.dart';
import 'package:noti_samu/components/checkboxChangeField.dart';
import 'package:noti_samu/objects/incidents.dart';
import 'package:noti_samu/screens/notifying/record/infoExtra.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/record/routes.dart';
import 'package:page_transition/page_transition.dart';

class Category extends StatefulWidget {
  Notify notification;
  Category(this.notification);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Incidents incidents = Incidents();
  bool _isWrongRoute;

  bool _error;

  Map<String, List<String>> _selected = {};

  @override
  void initState() {
    super.initState();
    _isWrongRoute = false;
    _error = false;
    //Caso ja tenha algum incidente guardado
    if (this.widget.notification.category != null) {
      for (var exist in this.widget.notification.category) {
        incidents.selectedCategory(exist);
        for (var exist2 in this.widget.notification.incidents) {
          incidents.selectedIncident(exist, exist2, true);

          if (_selected.containsKey(exist)) {
            _selected[exist].add(exist2);
          } else {
            _selected[exist] = [exist2];
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
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
        isAlwaysShown: true,
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 8),
            _text("Categoria de incidente*: ", error: _error),
            SizedBox(
              height: 16,
            ),
            CheckboxChangeField(
              incidents,
              changeIncident: (String key1, String key2, bool change) =>
                  _selectedIncidents(key1, key2, change),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _selectedIncidents(String key1, String key2, bool value) {
    setState(
      () {
        if (value) {
          if (_selected.containsKey(key1)) {
            _selected[key1].add(key2);
          } else {
            _selected[key1] = [key2];
          }
        } else {
          _selected[key1].remove(key2);
          if (_selected[key1].length == 0) {
            _selected.remove(key1);
          }
        }
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
        color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
      ),
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

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this
            .widget
            .notification
            .clearCategorys(); //Garante que a lista de incidentes vai estar limpa
        this.widget.notification.clearIncidents();
        _selected.forEach(
          (k, v) {
            this.widget.notification.setCategory(k);
            v.forEach((question) {
              this.widget.notification.setIncident(question);
            });
          },
        );

        if (this.widget.notification.incidents.isNotEmpty) {
          this.widget.notification.incidents.forEach((element) {
            if (element.compareTo("Via errada") == 0) {
              setState(() {
                _isWrongRoute = true;
              });
            } else {
              setState(() {
                //Caso ele tenha ido para a proxima tela e
                //voltado para modificar algo nessa
                _isWrongRoute = false;
              });
            }
          });
          if (_isWrongRoute) {
            Navigator.of(context).push(PageTransition(
                duration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: Routes(this.widget.notification)));
          } else {
            //Garante que não tera nada relacionado a via errada
            this.widget.notification.clearRoute();
            Navigator.of(context).push(PageTransition(
                duration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: InfoExtra(this.widget.notification)));
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
