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
      notificante: "a",
      profissao: "a",
      paciente: "a",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "56456",
      local: "a",
      dataDaOcorrencia: DateTime.now(),
      periodo: "a",
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
      notificante: "asdf",
      profissao: "asdf",
      paciente: "asdg",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "4653",
      local: "asdf",
      dataDaOcorrencia: DateTime.now(),
      periodo: "asdg",
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
      notificante: "asdgasd",
      profissao: "asdgas",
      paciente: "asdg",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "1955159",
      local: "adgas",
      dataDaOcorrencia: DateTime.now(),
      periodo: "asdg",
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
      notificante: "adgas",
      profissao: "asdga",
      paciente: "asdg",
      nascimento: DateTime.now(),
      sexo: "M",
      numeroDaOcorrencia: "815621",
      local: "asdg",
      dataDaOcorrencia: DateTime.now(),
      periodo: "asdgg",
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
