import 'package:flutter/material.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'infoExtra.dart';

class Routes extends StatefulWidget {
  Notify notification;
  Routes(this.notification);
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  List<String> listRoutes = ListMedicines().route;

  String _radioValueRoute;

  void radioButtonChangeRoute(String value) {
    setState(() {
      _radioValueRoute = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Vias de administração"),
      ),
      body: _body(context),
      floatingActionButton: Builder(builder: (context) => _buttonNext(context)),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(
              height: 8,
            ),
            _text("*Via em que a administração foi usada erroneamente: "),
            SizedBox(
              height: 16,
            ),
            _routes(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _routes() {
    return RadioButtonList(
      listRoutes,
      radioValue: _radioValueRoute,
      radioButtonChanges: (String value) => radioButtonChangeRoute(value),
    );
  }

  _text(perguntas) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _missingElement(BuildContext context) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione uma via de administração.",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.setRoute(_radioValueRoute);

        if (this.widget.notification.route != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InfoExtra(this.widget.notification)));
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
