import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dados especificos."),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        _category(),
        SizedBox(height: 20),
        _incidents(),
        SizedBox(height: 20),
      ],
    );
  }

  _category() {
    return _changeCategory
        ? TextPreview(
            data[0],
            list: this.widget.notification.category,
            itsList: true,
            function: () => _change(data[0]),
          )
        : TextPreview(
            data[0],
            list: this.widget.notification.category,
            itsList: true,
            function: () => _change(data[0]),
          );
  }

  _incidents() {
    return _changeIncidents
        ? TextPreview(
            data[1],
            list: this.widget.notification.answer,
            itsList: true,
            function: () => _change(data[1]),
          )
        : TextPreview(
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
}
