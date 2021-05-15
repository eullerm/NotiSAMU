import 'package:flutter/material.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/optionalDataPreview.dart';
import 'package:page_transition/page_transition.dart';

class Advice2 extends StatefulWidget {
  Advice2(this.notification);

  Notify notification;

  @override
  _Advice2State createState() => _Advice2State();
}

class _Advice2State extends State<Advice2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("NotiSAMU"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(context),
    );
  }

  _body(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _advice(),
        ],
      ),
    );
  }

  _advice() {
    return Column(
      children: <Widget>[
        _text(
            "Modificações na notificação poderão ser feitas durante a revisão. " +
                "Clicando no campo desejado será possível alterá-lo.",
            25),
        SizedBox(height: 100),
      ],
    );
  }

  _text(String string, double font) {
    return Text(
      string.replaceAll('-', '\u2011'),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: font,
      ),
    );
  }

  _buttonNext(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(PageTransition(
            duration: Duration(milliseconds: 200),
            type: PageTransitionType.rightToLeft,
            child: OptionalData(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
