import 'package:flutter/material.dart';
import 'package:noti_samu/components/notification.dart';
import 'package:noti_samu/screens/notifying/dataPreview/mandatoryDataPreview.dart';

class OptionalData extends StatefulWidget {
  Notify notification;
  OptionalData(this.notification);

  @override
  _OptionalDataState createState() => _OptionalDataState();
}

class _OptionalDataState extends State<OptionalData> {
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
              SizedBox(height: 20),
              _profissao(),
              SizedBox(height: 20),
              _nomeDoPaciente(),
              SizedBox(height: 20),
              _dataDeNascimento(),
              SizedBox(height: 20),
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MandatoryData(widget.notification)));
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
            this.widget.notification.notifying ?? "Não informado.",
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
            this.widget.notification.profission ?? "Não informado",
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
            this.widget.notification.patient ?? "Não informado.",
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
            "${this.widget.notification.birth.day.toString()}/${this.widget.notification.birth.month.toString()}/${this.widget.notification.birth.year.toString()}",
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
            this.widget.notification.sex ?? "Não informado",
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
