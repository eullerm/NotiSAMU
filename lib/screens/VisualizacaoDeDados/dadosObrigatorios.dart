import 'package:flutter/material.dart';
import 'package:noti_samu/screens/VisualizacaoDeDados/dadosEspecificos.dart';

class DadosObrigatorios extends StatefulWidget {
  @override
  _DadosObrigatoriosState createState() => _DadosObrigatoriosState();
}

class _DadosObrigatoriosState extends State<DadosObrigatorios> {
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
              _numeroDaOcorrencia(),
              SizedBox(
                height: 20,
              ),
              _localDaOcorrencia(),
              SizedBox(
                height: 20,
              ),
              _dataDaOcorrencia(),
              SizedBox(
                height: 20,
              ),
              _periodoDaOcorrencia(),
              SizedBox(
                height: 20,
              ),
              _categorias(),
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
            .push(MaterialPageRoute(builder: (context) => DadosEspecificos()));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }

  _numeroDaOcorrencia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Número da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "65123",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _localDaOcorrencia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Local da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "Texto de exemplo",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _dataDaOcorrencia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Data da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _periodoDaOcorrencia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Periodo da ocorrência:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "Noite",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _categorias() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Categorias:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () => print("!"),
          child: Text(
            "Xxxxxxx \n Yyyyyyy",
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
