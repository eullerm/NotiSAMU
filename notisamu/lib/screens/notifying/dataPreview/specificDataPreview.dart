import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/InfoExtraPreview.dart';

class SpecificData extends StatefulWidget {
  Notify notification;
  SpecificData(this.notification);
  @override
  _SpecificDataState createState() => _SpecificDataState();
}

class _SpecificDataState extends State<SpecificData> {

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
        SizedBox(height: 20),
        _incidentCategory(),
      ],
    );
  }

  _incidentCategory() {
    return GestureDetector(
      onTap: () => {},
      child: Column(
        children: this.widget.notification.answer != null
            ? this
                .widget
                .notification
                .answer
                .keys
                .map(
                  (String key) => Column(
                    children: <Widget>[
                      Text(
                        key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        widget.notification.answer[key],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
                .toList()
            : <Widget>[],
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
}
