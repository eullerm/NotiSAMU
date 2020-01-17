import 'package:flutter/material.dart';
import 'package:noti_samu/screens/VisualizacaoDeDados/dadoInfoExtra.dart';
import 'package:noti_samu/screens/notificacao.dart';

class DadosEspecificos extends StatefulWidget {
  Notificacao notificacao;
  DadosEspecificos(this.notificacao);
  @override
  _DadosEspecificosState createState() => _DadosEspecificosState();
}

class _DadosEspecificosState extends State<DadosEspecificos> {
  Map<String, String> _categorias = {
    'Pergunta X': 'Resposta X',
    'Pergunta Y': 'Resposta Y',
    'Pergunta Z': 'Resposta Z',
    'Pergunta S': 'Resposta S',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dados especificos."),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _categoriaIncidente(),
      ],
    );
  }

  _categoriaIncidente() {
    return GestureDetector(
      onTap: () => print(_categorias.keys.toList()),
      child: Column(
        children: _categorias.keys
            .map(
              (String key) => Column(
                children: <Widget>[
                  Text(
                    key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    _categorias[key],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VisualizaInfoExtra(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
