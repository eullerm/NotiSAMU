import 'package:flutter/material.dart';
import 'package:noti_samu/components/textChangeFormField.dart';
import 'package:noti_samu/components/textPreview.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/send/success.dart';
import 'package:page_transition/page_transition.dart';

class InfoExtraPreview extends StatefulWidget {
  Notify notification;
  InfoExtraPreview(this.notification);

  @override
  _InfoExtraPreviewState createState() => _InfoExtraPreviewState();
}

class _InfoExtraPreviewState extends State<InfoExtraPreview> {
  TextEditingController information = TextEditingController();

  bool _changeInfoExtra;
  bool _error;

  @override
  void initState() {
    _changeInfoExtra = false;

    if (this.widget.notification.infoExtra != null) information = TextEditingController(text: this.widget.notification.infoExtra);
    _error = false;
    print(information.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7444E),
        title: Text("Informações extras"),
      ),
      body: _body(context),
      floatingActionButton: _changeInfoExtra ? Builder(builder: (context) => _buttonChange(context)) : _sendNotification(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: _changeInfoExtra
                ? <Widget>[
                    SizedBox(height: 20),
                    TextChangeFormField(
                      ("Informações extra:"),
                      information,
                      maxLength: 300,
                      maxLines: null,
                      minLines: null,
                      widget: Container(),
                      error: _error,
                    )
                  ]
                : <Widget>[
                    SizedBox(height: 20),
                    TextPreview(
                      "Descreva como foi o incidente. Você acredita que algum fator contribuiu para o ocorrido?",
                      string2: information.text,
                      function: () => _change(),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  _change() {
    setState(() {
      _changeInfoExtra = !_changeInfoExtra;
    });
  }

  _sendNotification() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
            PageTransition(duration: Duration(milliseconds: 200), type: PageTransitionType.rightToLeft, child: Success(this.widget.notification)));
      },
      label: Text('Enviar'),
      icon: Icon(Icons.send),
      backgroundColor: Color(0xFFF7444E),
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

  _buttonChange(context) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          if (information.text.isEmpty) {
            _missingElement(context);
            setState(() {
              _error = true;
            });
          } else {
            this.widget.notification.setInfoExtra(information.text);
            information = TextEditingController(text: this.widget.notification.infoExtra);
            _change();
          }
        });
      },
      label: Text('Confirmar'),
      icon: Icon(Icons.check),
      backgroundColor: Colors.green,
    );
  }
}
