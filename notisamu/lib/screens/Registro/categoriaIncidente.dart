import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Registro/infoExtra.dart';
import 'package:noti_samu/screens/notificacao.dart';

class Categoria extends StatefulWidget {
  Notificacao notificacao;
  Categoria(this.notificacao);
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  Map<String, bool> _categorias = {
    'Erro de Prescrição': false,
    'Erro de Dispensação': false,
    'Erro de Preparo': false,
    'Erro de Administração': false,
  };

  final List<String> perguntasPrescricao = [
    'Pergunta Prescrição 1',
    'Pergunta Prescrição 2',
    'Pergunta Prescrição 3',
  ];

  final List<String> perguntasDispensacao = [
    'Pergunta Dispensação 1',
    'Pergunta Dispensação 2',
    'Pergunta Dispensação 3',
  ];

  final List<String> perguntasPreparo = [
    'Pergunta Preparo 1',
    'Pergunta Preparo 2',
    'Pergunta Preparo 3',
  ];

  final List<String> perguntasAdministracao = [
    'Pergunta Administração 1',
    'Pergunta Administração 2',
    'Pergunta Administração 3',
  ];

  final Map<String, Map<String, bool>> errosPrescricao = {
    'Pergunta Prescrição 1': {
      'A0': false,
      'A1': false,
    },
    'Pergunta Prescrição 2': {
      'B0': false,
      'B2': false,
    },
    'Pergunta Prescrição 3': {
      'C0': false,
      'C1': false,
      'C2': false,
    },
  };

  final Map<String, Map<String, bool>> errosDispensacao = {
    'Pergunta Dispensação 1': {
      'A0': false,
      'A1': false,
      'A2': false,
    },
    'Pergunta Dispensação 2': {
      'B1': false,
      'B2': false,
    },
    'Pergunta Dispensação 3': {
      'C0': false,
      'C2': false,
    },
  };

  final Map<String, Map<String, bool>> errosPrepraro = {
    'Pergunta Preparo 1': {
      'A0': false,
      'A2': false,
    },
    'Pergunta Preparo 2': {
      'B0': false,
      'B2': false,
    },
    'Pergunta Preparo 3': {
      'C0': false,
      'C1': false,
    },
  };

  final Map<String, Map<String, bool>> errosAdministracao = {
    'Pergunta Administração 1': {'A0': false, 'A1': false, 'A2': false},
    'Pergunta Administração 2': {'B0': false, 'B1': false, 'B2': false},
    'Pergunta Administração 3': {'C0': false, 'C1': false, 'C2': false},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Registro de dados da ocorrência"),
      ),
      body: _body(context),
      floatingActionButton: _buttonNext(),
    );
  }

  _body(context) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            _categoriaIncidente(),
          ],
        ),
      ),
    );
  }

  _categoriaIncidente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Categoria de incidente:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        _checkBoxButton(
            "Erro de Prescrição", perguntasPrescricao, errosPrescricao),
        _checkBoxButton(
            "Erro de Dispensação", perguntasDispensacao, errosDispensacao),
        _checkBoxButton("Erro de Preparo", perguntasPreparo, errosPrepraro),
        _checkBoxButton("Erro de Administração", perguntasAdministracao,
            errosAdministracao),
      ],
    );
  }

  _checkBoxButton(key, perguntas, erros) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text(key),
          value: _categorias[key],
          onChanged: (bool value) {
            setState(
              () {
                _categorias[key] = value;
              },
            );
          },
        ),
        _validaPerguntas(key, perguntas, erros),
      ],
    );
  }

  _validaPerguntas(key, perguntas, erros) {
    return _categorias[key] == true
        ? _perguntas(perguntas, erros)
        : SingleChildScrollView(
            child: Container(),
          );
  }

  _perguntas(perguntas, erros) {
    return Column(
      children: perguntas
          .map<Widget>(
            (String string) => Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                _texto(string),
                SizedBox(
                  height: 5,
                ),
                _checkBoxButtonQuestion(erros, string),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  _texto(perguntas) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

  _checkBoxButtonQuestion(erros, i) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20,),
      child: Column(
        children: erros[i]
            .keys
            .map<Widget>(
              (String key) => CheckboxListTile(
                title: _texto(key),
                value: erros[i][key],
                onChanged: (bool value) {
                  setState(() {
                    erros[i].forEach((k, v) => erros[i][k] = false);
                    erros[i][key] = value;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        _categorias.forEach((k, v) {
          if (v == true) {
            this.widget.notificacao.incidente.add(k);
          }
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoExtra(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
