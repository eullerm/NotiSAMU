import 'package:flutter/material.dart';
import 'package:noti_samu/components/radioButtonList.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/objects/ListMedicines.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/prescriptionErrorPreview.dart';
import 'package:page_transition/page_transition.dart';

class RoutesPreview extends StatefulWidget {
  Notify notification;
  RoutesPreview(this.notification);
  @override
  _RoutesPreviewState createState() => _RoutesPreviewState();
}

class _RoutesPreviewState extends State<RoutesPreview> {
  List<String> listRoutes = ListMedicines().route;

  String _radioValueRoute;

  bool _changeRoute;
  bool _error;

  void radioButtonChangeRoute(String value) {
    setState(() {
      _radioValueRoute = value;
    });
  }

  @override
  void initState() {
    if (!listRoutes.contains(this.widget.notification.route)) {
      _changeRoute = true;
    } else {
      _radioValueRoute = this.widget.notification.route;
      _changeRoute = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("Vias de administração"),
      ),
      body: _body(context),
      floatingActionButton: _changeRoute ? Builder(builder: (context) => _changeButton(context)) : _buttonNext(),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: _changeRoute
              ? _changingRoute()
              : <Widget>[
                  TextPreview(
                    "Via usada erroneamente:",
                    string2: _radioValueRoute,
                    function: () => _change(),
                  )
                ],
        ),
      ),
    );
  }

  _change() {
    setState(() {
      _changeRoute = !_changeRoute;
    });
  }

  _changingRoute() {
    return <Widget>[
      SizedBox(
        height: 8,
      ),
      _text("Via em que a administração foi usada erroneamente*: ", error: _error),
      SizedBox(
        height: 16,
      ),
      _routes(),
      SizedBox(height: 40),
    ];
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
        color: (error != null && error) ? Color(0xFFF7444E) : Colors.black,
      ),
    );
  }

  _missingElement(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Selecione ao menos uma via de administração.",
          style: TextStyle(color: Color(0xFFF7444E)),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(PageTransition(
            duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: PrescriptionErrorPreview(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Color(0xFFF7444E),
    );
  }

  _changeButton(BuildContext context) {
    _radioValueRoute == null ? print("null") : print("not null");
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.setRoute(_radioValueRoute);

        if (_radioValueRoute != null) {
          setState(() {
            _changeRoute = false;
          });
        } else {
          _missingElement(context);
          setState(() {
            _error = true;
          });
        }
      },
      label: Text('Confirmar'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.green,
    );
  }
}
