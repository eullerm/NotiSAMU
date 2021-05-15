import 'package:flutter/material.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:page_transition/page_transition.dart';
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

  bool _error;

  @override
  void initState() {
    _error = false;
    super.initState();
  }

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
            _text("*Via em que a administração foi usada erroneamente: ",
                error: _error),
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
    return ScaffoldMessenger.of(context).showSnackBar(
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
          Navigator.of(context).push(PageTransition(
              duration: Duration(milliseconds: 200),
              type: PageTransitionType.rightToLeft,
              child: InfoExtra(this.widget.notification)));
        } else {
          _missingElement(context);
          setState(() {
            _error = true;
          });
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
