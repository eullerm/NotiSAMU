import 'package:flutter/material.dart';
import 'package:noti_samu/screens/VisualizacaoDeDados/dadosOpcionais.dart';

class InfoExtra extends StatefulWidget {
  @override
  _InfoExtraState createState() => _InfoExtraState();
}

class _InfoExtraState extends State<InfoExtra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Informações extras sobre o incidente"),
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
              ("""Caixa para informações adicionais."""),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DadosOpcionais()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
