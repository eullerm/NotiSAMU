import 'package:flutter/material.dart';
import 'package:noti_samu/advice/advice2.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:page_transition/page_transition.dart';

class InfoExtra extends StatefulWidget {
  Notify notification;
  InfoExtra(this.notification);

  @override
  _InfoExtraState createState() => _InfoExtraState();
}

class _InfoExtraState extends State<InfoExtra> {
  TextEditingController information = TextEditingController();

  bool _error;

  @override
  void initState() {
    super.initState();
    _error = false;
    if (this.widget.notification.infoExtra != null) information = TextEditingController(text: this.widget.notification.infoExtra);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("Informações extras"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Descreva como foi o incidente. Você acredita que algum fator contribuiu para o ocorrido?*",
                style: TextStyle(
                  fontSize: 18,
                  color: (_error != null && _error) ? Color(0xFFF7444E) : Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _info(),
          ],
        ),
      ),
    );
  }

  _info() {
    return TextFormField(
      controller: information,
      maxLength: 300,
      maxLines: null,
      minLines: null,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  _missingElement(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Descreva o incidente antes de continuar.",
          style: TextStyle(color: Color(0xFFF7444E)),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (information.text.isEmpty) {
          _missingElement(context);
          setState(() {
            _error = true;
          });
        } else {
          this.widget.notification.setInfoExtra(information.text);
          Navigator.of(context).push(
              PageTransition(duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: Advice2(this.widget.notification)));
        }
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Color(0xFFF7444E),
    );
  }
}
