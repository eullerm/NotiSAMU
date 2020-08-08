import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardNotify extends StatelessWidget {
  final DocumentSnapshot notificacao;

  CardNotify(this.notificacao);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _columnInfo(),
          Container(
            width: 6,
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: notificacao.data['incident'].isNotEmpty ? Colors.green : null),
          ),
        ],
      ),
    );
  }

  _columnInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: _rowText("Relator:", notificacao.data['notifying']),
          ),
          Row(
            children: _rowText(
                "Nº da Ocorrência:", notificacao.data['occurrenceNumber']),
          ),
          Row(
            children: _rowText(
                "Data:",
                DateFormat("dd/MM/yyyy")
                    .format(notificacao.data['occurrenceDate'].toDate())),
          ),
          Row(
            children: _rowText("Local:", notificacao.data['local']),
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
