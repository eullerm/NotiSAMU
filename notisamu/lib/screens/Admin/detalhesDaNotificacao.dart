import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/notificacao.dart';
import 'package:intl/intl.dart';

class DetalhesNotificacao extends StatelessWidget {
  final Notificacao notificacao;

  DetalhesNotificacao(this.notificacao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return ListView(
      children: _information(),
    );
  }

  _information() {
    return <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _text("Relator:", notificacao.notificante),
            _text("Profissão:", notificacao.profissao),
            _text("Paciente:", notificacao.paciente),
            _text("Nascimento:",
                DateFormat("dd/MM/yyyy").format(notificacao.nascimento)),
            _text("Sexo:", notificacao.sexo),
            _text("Nº da ocorrência:", notificacao.numeroDaOcorrencia),
            _text("Local:", notificacao.local),
            _text("Data da ocorrência:",
                DateFormat("dd/MM/yyyy").format(notificacao.dataDaOcorrencia)),
            _text("Periodo:", notificacao.periodo),
            _textList("Incidentes:", notificacao.incidente),
            _textMap("Respostas:", notificacao.respostas),
            _text("Info extra:", notificacao.infoExtra),
          ],
        ),
      )
    ];
  }

  _text(string, string2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          string2,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _textList(string, list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Column(
          children: list
              .map<Widget>(
                (incidente) => Text(
                  incidente,
                  style: TextStyle(fontSize: 20),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _textMap(string, Map<String, String> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),
        Column(
          children: map.entries
              .map<Widget>(
                (entry) => _textRow(entry.key, entry.value),
              )
              .toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _textRow(string, string2) {
    return Row(
      children: <Widget>[
        Text(
          string,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(width: 5),
        Text(
          string,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
