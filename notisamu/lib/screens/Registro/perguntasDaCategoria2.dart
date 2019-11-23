//Apenas para exibição de exemplo de pergunta

import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/infoExtra.dart';

class Perguntas2 extends StatefulWidget {
  @override
  _PerguntasState createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas2> {
  String _radioValue;

  @override
  void initState() {
    setState(() {
      _radioValue = null;
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      debugPrint(_radioValue); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Erro de Administração"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _texto('O paciente apresentou reações adversas?'),
          SizedBox(
            height: 50,
          ),
          _radioButtonChoice(),
        ],
      ),
    );
  }

  _texto(texto) {
    return Text(
      texto,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _radioButtonChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _radioButton('Sim'),
        _radioButton('Não'),
      ],
    );
  }

  _radioButton(String string) {
    return ListTile(
      title: Text(string),
      leading: Radio(
        value: string,
        groupValue: _radioValue,
        onChanged: radioButtonChanges,
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => InfoExtra()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

}
