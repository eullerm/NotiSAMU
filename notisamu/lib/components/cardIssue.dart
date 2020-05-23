import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/notificacao.dart';
import 'package:intl/intl.dart';

class CardIssue extends StatelessWidget {
  final Notificacao notificacao;

  CardIssue(this.notificacao);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Row(
            children: _rowText("Relator:", notificacao.notificante),
          ),
          Row(
            children:
                _rowText("Nº da Ocorrência:", notificacao.numeroDaOcorrencia),
          ),
          Row(
            children: _rowText("Data:",
                DateFormat("dd/MM/yyyy").format(notificacao.dataDaOcorrencia)),
          ),
          Row(
            children: _rowText("Local:", notificacao.local),
          ),
        ],
      ),
    );
  }

  _rowText(title, info) {
    return <Widget>[
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        info,
        style: TextStyle(fontSize: 20),
      )
    ];
  }
}
