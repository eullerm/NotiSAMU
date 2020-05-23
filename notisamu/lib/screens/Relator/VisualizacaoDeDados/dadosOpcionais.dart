import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/VisualizacaoDeDados/dadosObrigatorios.dart';
import 'package:noti_samu/components/notificacao.dart';

class DadosOpcionais extends StatefulWidget {
  
  Notificacao notificacao;
  DadosOpcionais(this.notificacao);

  @override
  _DadosOpcionaisState createState() => _DadosOpcionaisState();
}

class _DadosOpcionaisState extends State<DadosOpcionais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Revisão de dados"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              _nomeDoNotificante(),
              SizedBox(
                height: 20,
              ),
              _profissao(),
              SizedBox(
                height: 20,
              ),
              _nomeDoPaciente(),
              SizedBox(
                height: 20,
              ),
              _dataDeNascimento(),
              SizedBox(
                height: 20,
              ),
              _sexoDoPaciente(),
            ],
          ),
        ),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DadosObrigatorios(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _nomeDoNotificante() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Nome do relator:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notificacao.notificante ?? "Não informado.", 
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _profissao() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Profissão:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notificacao.profissao ?? "Não informado",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _nomeDoPaciente() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Nome do Paciente:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notificacao.paciente ?? "Não informado.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _dataDeNascimento() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data de nascimento:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "${this.widget.notificacao.nascimento.day.toString()}/${this.widget.notificacao.nascimento.month.toString()}/${this.widget.notificacao.nascimento.year.toString()}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _sexoDoPaciente() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Sexo do Paciente:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            this.widget.notificacao.sexo ?? "Não informado",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
