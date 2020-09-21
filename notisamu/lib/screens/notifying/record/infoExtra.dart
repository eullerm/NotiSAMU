import 'package:flutter/material.dart';
import 'package:noti_samu/advice/advice2.dart';
import 'package:noti_samu/objects/notification.dart';

class InfoExtra extends StatefulWidget {
  Notify notification;
  InfoExtra(this.notification);

  @override
  _InfoExtraState createState() => _InfoExtraState();
}

class _InfoExtraState extends State<InfoExtra> {
  TextEditingController information = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (this.widget.notification.infoExtra != null)
      information =
          TextEditingController(text: this.widget.notification.infoExtra);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
            Text(
              ("Você considera que algum fator ou agente tenha contribuído" +
                  " para este incidente? Se sim, especifique."),
              style: TextStyle(
                fontSize: 16,
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

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (information.text.isEmpty)
          this.widget.notification.setInfoExtra("Nada informado.");
        else
          this.widget.notification.setInfoExtra(information.text);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Advice2(this.widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
