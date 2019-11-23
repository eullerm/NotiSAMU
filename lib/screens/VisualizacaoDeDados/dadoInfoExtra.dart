import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Envio/sucesso.dart';

class VisualizaInfoExtra extends StatefulWidget {
  @override
  _VisualizaInfoExtraState createState() => _VisualizaInfoExtraState();
}

class _VisualizaInfoExtraState extends State<VisualizaInfoExtra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Informação Extra."),
      ),
      body: _body(context),
      floatingActionButton: _enviaNotificacao(),
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
            _texto("Aqui pode conter um texto de até 300 caracteres..."),
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

  _enviaNotificacao() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Sucesso()));
      },
      label: Text('Enviar'),
      icon: Icon(Icons.send),
      backgroundColor: Colors.redAccent,
    );
  }
}
