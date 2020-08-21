import 'package:flutter/material.dart';
import 'package:noti_samu/objects/notification.dart';
import 'package:noti_samu/screens/notifying/send/success.dart';

class InfoExtraPreview extends StatefulWidget {
  Notify notification;
  InfoExtraPreview(this.notification);

  @override
  _InfoExtraPreviewState createState() => _InfoExtraPreviewState();
}

class _InfoExtraPreviewState extends State<InfoExtraPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Informação Extra."),
      ),
      body: _body(context),
      floatingActionButton: _envianotification(),
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
            _texto(widget.notification.infoExtra),
          ],
        ),
      ),
    );
  }

  _texto(string) {
    return Text(
      string,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  _envianotification() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Success(this.widget.notification)));
      },
      label: Text('Enviar'),
      icon: Icon(Icons.send),
      backgroundColor: Colors.redAccent,
    );
  }
}
