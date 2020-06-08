import 'package:flutter/material.dart';
import 'package:noti_samu/screens/Relator/Registro/infoExtra.dart';
import 'package:noti_samu/components/notificacao.dart';

class Categoria extends StatefulWidget {
  Notificacao notificacao;
  Categoria(this.notificacao);
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  final Map<String, bool> _categorias = {
    'Erro de Prescrição': false,
    'Erro de Dispensação': false,
    'Erro de Preparo': false,
    'Erro de Administração': false,
  };

  final Map<String, Map<String, Map<String, bool>>>
      _categoriasMapPerguntasRespostas = {
    'Erro de Prescrição': {
      'Pergunta Prescrição 1': {'A0': false, 'A1': false},
      'Pergunta Prescrição 2': {'B0': false, 'B2': false},
      'Pergunta Prescrição 3': {'C0': false, 'C1': false, 'C2': false},
    },
    'Erro de Dispensação': {
      'Pergunta Dispensação 1': {'A0': false, 'A1': false, 'A2': false},
      'Pergunta Dispensação 2': {'B1': false, 'B2': false},
      'Pergunta Dispensação 3': {'C0': false, 'C2': false},
    },
    'Erro de Preparo': {
      'Pergunta Preparo 1': {'A0': false, 'A2': false},
      'Pergunta Preparo 2': {'B0': false, 'B2': false},
      'Pergunta Preparo 3': {'C0': false, 'C1': false},
    },
    'Erro de Administração': {
      'Pergunta Administração 1': {'A0': false, 'A1': false, 'A2': false},
      'Pergunta Administração 2': {'B0': false, 'B1': false, 'B2': false},
      'Pergunta Administração 3': {'C0': false, 'C1': false, 'C2': false},
    },
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
        _checkBoxButton("Erro de Prescrição",
            _categoriasMapPerguntasRespostas["Erro de Prescrição"]),
        _checkBoxButton("Erro de Dispensação",
            _categoriasMapPerguntasRespostas["Erro de Dispensação"]),
        _checkBoxButton("Erro de Preparo",
            _categoriasMapPerguntasRespostas["Erro de Preparo"]),
        _checkBoxButton("Erro de Administração",
            _categoriasMapPerguntasRespostas["Erro de Administração"]),
      ],
    );
  }

  _checkBoxButton(key, perguntas) {
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
        _validaPerguntas(key, perguntas),
      ],
    );
  }

  _validaPerguntas(key, perguntas) {
    return _categorias[key] == true
        ? _perguntas(perguntas)
        : SingleChildScrollView(
            child: Container(),
          );
  }

  _perguntas(map) {
    return Column(
      children: map.keys
          .toList()
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
                _checkBoxButtonQuestion(map, string),
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
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
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
            debugPrint(k);
            this.widget.notificacao.setIncident(k);
            _categoriasMapPerguntasRespostas.forEach((key, listPerguntas) {
              if (key == k) {
                for (var pergunta in listPerguntas.keys.toList()) {
                  for (var resposta in listPerguntas[pergunta].keys) {
                    debugPrint(resposta);
                    if (listPerguntas[pergunta][
                        resposta]) //Se a boleana da resposta for true coloca a resposta na notificação
                      this
                          .widget
                          .notificacao
                          .setAnswer(pergunta, resposta);
                  }
                }
              }
            });
          }
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InfoExtra(widget.notificacao)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
