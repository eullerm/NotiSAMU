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
  
  final Map<String, Map<String, bool>> _mapQuestionsAnswers = {
    'Pergunta Prescrição 1': {'A0': false, 'A1': false},
    'Pergunta Prescrição 2': {'B0': false, 'B2': false},
    'Pergunta Prescrição 3': {'C0': false, 'C1': false, 'C2': false},
    'Pergunta Dispensação 1': {'A0': false, 'A1': false, 'A2': false},
    'Pergunta Dispensação 2': {'B1': false, 'B2': false},
    'Pergunta Dispensação 3': {'C0': false, 'C2': false},
    'Pergunta Preparo 1': {'A0': false, 'A2': false},
    'Pergunta Preparo 2': {'B0': false, 'B2': false},
    'Pergunta Preparo 3': {'C0': false, 'C1': false},
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
            _question(),
          ],
        ),
      ),
    );
  }

  _question() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Perguntas sobre o incidente:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _questionsToList(_mapQuestionsAnswers),
      ],
    );
  }

  _questionsToList(map) {
    return Column(
      children: map.keys
          .toList()
          .map<Widget>(
            (String string) => Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                _text(string),
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

  _text(perguntas) {
    return Text(
      perguntas,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
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
                title: _text(key),
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
        _mapQuestionsAnswers.forEach((question, listAnswer) {
          for (var answer in listAnswer.keys) {
            if (listAnswer[
                answer]) //Se a boleana da resposta for true coloca a resposta na notificação
              this.widget.notificacao.setAnswer(question, answer);
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
