import 'package:flutter/material.dart';
import 'package:noti_samu/components/notificacao.dart';
import 'package:noti_samu/components/cardIssue.dart';
import 'package:noti_samu/screens/Admin/detalhesDaNotificacao.dart';
import 'package:noti_samu/login.dart';

class Notificacoes extends StatefulWidget {
  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  
  List<Notificacao> list = [
    Notificacao(
      notifying: "Não informado",
      profission: "Médico",
      patient: "Alberto",
      birth: DateTime.now(),
      sex: "M",
      occurrenceNumber: "56456",
      local: "Niteroi",
      occurrenceDate: DateTime.now(),
      period: "Manhã",
      incident: [
        "a",
        "a",
      ],
      answer: {
        "a": "a",
        "b": "b",
      },
      infoExtra: "aa",
      
    ),
    Notificacao(
      notifying: "Aline",
      profission: "Médico",
      patient: "Miguel",
      birth: DateTime.now(),
      sex: "M",
      occurrenceNumber: "4653",
      local: "Niteroi",
      occurrenceDate: DateTime.now(),
      period: "Noite",
      incident: [
        "a",
        "a",
      ],
      answer: {
        "a": "a",
        "b": "b",
      },
      infoExtra: "sadga",
    ),
    Notificacao(
      notifying: "Não informado",
      profission: "Não informado",
      patient: "Carla",
      birth: DateTime.now(),
      sex: "F",
      occurrenceNumber: "1955159",
      local: "Niteroi",
      occurrenceDate: DateTime.now(),
      period: "Noite",
      incident: [
        "a",
        "a",
      ],
      answer: {
        "a": "a",
        "b": "b",
      },
      infoExtra: "adsgasdg",
    ),
    Notificacao(
      notifying: "Cleber",
      profission: "Enfermeiro",
      patient: "Jessica",
      birth: DateTime.now(),
      sex: "F",
      occurrenceNumber: "815621",
      local: "Niteroi",
      occurrenceDate: DateTime.now(),
      period: "Noite",
      incident: [
        "a",
        "a",
      ],
      answer: {
        "a": "a",
        "b": "b",
      },
      infoExtra: "aa",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Noti SAMU"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: _body(context, list),
    );
  }

  _body(context, list) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
      child: ListView(
        children: list.map<Widget>((Notificacao notificacao) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetalhesNotificacao(notificacao)));
            },
            child: CardIssue(notificacao),
          );
        }).toList(),
      ),
    );
  }
}
