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
      notificante: "Não informado",
      profissao: "Médico",
      paciente: "Alberto",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "56456",
      local: "Niteroi",
      dataDaOcorrencia: DateTime.now(),
      periodo: "Manhã",
      incidente: [
        "a",
        "a",
      ],
      infoExtra: "aa",
      respostas: {
        "a": "a",
        "b": "b",
      },
    ),
    Notificacao(
      notificante: "Aline",
      profissao: "Médico",
      paciente: "Miguel",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "4653",
      local: "Niteroi",
      dataDaOcorrencia: DateTime.now(),
      periodo: "Noite",
      incidente: [
        "a",
        "a",
      ],
      infoExtra: "sadga",
      respostas: {
        "a": "a",
        "b": "b",
      },
    ),
    Notificacao(
      notificante: "Não informado",
      profissao: "Não informado",
      paciente: "Carla",
      nascimento: DateTime.now(),
      sexo: "F",
      numeroDaOcorrencia: "1955159",
      local: "Niteroi",
      dataDaOcorrencia: DateTime.now(),
      periodo: "Noite",
      incidente: [
        "a",
        "a",
      ],
      infoExtra: "adsgasdg",
      respostas: {
        "a": "a",
        "b": "b",
      },
    ),
    Notificacao(
      notificante: "Cleber",
      profissao: "Enfermeiro",
      paciente: "Jessica",
      nascimento: DateTime.now(),
      sexo: "F",
      numeroDaOcorrencia: "815621",
      local: "Niteroi",
      dataDaOcorrencia: DateTime.now(),
      periodo: "Noite",
      incidente: [
        "a",
        "a",
      ],
      infoExtra: "aa",
      respostas: {
        "a": "a",
        "b": "b",
      },
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
