import 'package:flutter/material.dart';
import 'package:noti_samu/screens/notifying/record/infoExtra.dart';
import 'package:noti_samu/components/notification.dart';

class Category extends StatefulWidget {
  Notify notification;
  Category(this.notification);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final Map<String, bool> _category = {
    'Erro de prescrição': false,
    'Erro de dispensação/armazenamento': false,
    'Erro de preparo/administração': false,
  };

  final Map<String, Map<String, bool>> _mapCategoryQuestions = {
    'Erro de prescrição': {
      'Instrução para administração errada': false,
      'Medicamento inadequado para situação': false,
      'Contraindicação': false,
    },
    'Erro de dispensação/armazenamento': {
      'Forma farmacêutica errada': false,
      'Medicamento errado': false,
      'Armazenamento em local inadequado': false,
      'Armazenamento em temperatura inadequada': false,
      'Medicamento fora da validade': false,
      'Quantidade  inadequada': false,
    },
    'Erro de preparo/administração': {
      'Paciente errado': false,
      'Medicamento errado': false,
      'Dose errada': false,
      'Frequência de administração errada': false,
      'Via errada': false,
      'Dose ou medicamento omitido': false,
      'Diluição errada': false,
      'Utilização de dispositivo inadequado para a administração do medicamento':
          false,
      'Extravasamento de medicamento': false,
    },
  };

  final Map<String, String> _mapCategoryExplanation = {
    'Erro de prescrição':
        "Erro de prescrição com significado clínico é definido como um erro de decisão ou de redação, não intencional, que pode reduzir a probabilidade do tratamento ser efetivo ou aumentaro risco de lesão no paciente, quando comparado com as praticas clínicas estabelecidas e aceitas",
    'Erro de dispensação/armazenamento':
        """São apresentadas três definições. Entretanto, é preciso ressaltar que estas definições não abordam a possibilidade da prescrição médica estar errada e o atendimento de uma prescrição incorreta é também considerado erro de dispensação.
        - Definido como a discrepância entre a ordem escrita na prescrição médica e o atendimento dessa ordem28.
        - São erros cometidos por funcionários da farmácia (farmacêuticos, inclusive) quando realizam a dispensação de medicamentos para as unidades de internação10.
        - Erro de dispensação é definido como o desvio de uma prescrição médica escrita ou oral, incluindo modificações escritas feitas pelo farmacêutico após contato com o prescritor ou cumprindo normas ou protocolos preestabelecidos. E ainda considerado erro de dispensação qualquer desvio do que é estabelecido pelos órgãos regulatórios ou normas que afetam a dispensação """,
    'Erro de preparo/administração':
        """Qualquer desvio no preparo e administração de medicamentos mediante prescrição médica, não observância das recomendações ou guias do hospital ou das instruções técnicas do fabricante do produto. Considera ainda que não houve erro se o medicamento foi administrado de forma correta mesmo se a técnica utilizada contrarie a prescrição médica ou os procedimentos do hospital""",
  };

  @override
  void initState() {
    super.initState();
    if (this.widget.notification.category != null) {
      for (var incident in this.widget.notification.category) {
        _category[incident] = true;
      }
      _mapCategoryQuestions.values.forEach((key) {
          for(var question in key.keys){
            for (var answer in this.widget.notification.answer) {
              if(question.compareTo(answer) == 0){
                key[answer] = true;
                break;
                }
            }}
        });
    }
  }

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
      padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 40),
      child: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            _text("Categoria de incidente: "),
            _checkboxMapCategoryQuestions(_category, _mapCategoryQuestions),
          ],
        ),
      ),
    );
  }

  _checkboxMapCategoryQuestions(Map category, Map categoryQuestion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: category.keys
          .map<Widget>(
            (string) => Column(
              children: <Widget>[
                _checkboxCategory(category, string),
                _validateAnswer(category, string, categoryQuestion[string]),
              ],
            ),
          )
          .toList(),
    );
  }

  _checkboxCategory(Map category, String key) {
    return Row(
      children: <Widget>[
        _explanation(key),
        SizedBox(width: 5.0),
        GestureDetector(
          child: _text(key),
          onTap: () => setState(
            () {
              category[key] = !category[key];
            },
          ),
        ),
        Checkbox(
          value: category[key],
          onChanged: (bool value) {
            setState(
              () {
                category[key] = value;
              },
            );
          },
        )
      ],
    );
  }

  _explanation(String type) {
    String _text;

    for (var compare in _category.keys) {
      if (compare.compareTo(type) == 0) {
        _text = _mapCategoryExplanation[type];
        break;
      }
    }

    return GestureDetector(
      child: Icon(Icons.info),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          title: Text(
            type,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            ),
          ],
        ),
      ),
    );
  }

  _validateAnswer(Map category, String key, Map questions) {
    return category[key] == true
        ? _questionsToList(questions)
        : SingleChildScrollView(
            child: Container(),
          );
  }

  _questionsToList(Map map) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: map.keys
            .map<Widget>(
              (key) => CheckboxListTile(
                title: _text(key),
                value: map[key],
                onChanged: (bool change) {
                  setState(() {
                    map[key] = change;
                  });
                },
              ),
            )
            .toList(),
      ),
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

  _buttonNext() {
    return FloatingActionButton.extended(
      onPressed: () {
        this.widget.notification.incidentClear();
        this.widget.notification.answerClear();
        _category.forEach((k, v) {
          if (v == true) {
            this.widget.notification.setIncident(k);
            _mapCategoryQuestions.forEach((key, listQuestions) {
              if (key == k) {
                for (var question in listQuestions.keys.toList()) {
                  if (listQuestions[
                      question]) //Se a boleana da resposta for true coloca a resposta na notificação
                    this.widget.notification.setAnswer(question);
                }
              }
            });
          }
        });
        if (this.widget.notification.answer != null)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InfoExtra(widget.notification)));
      },
      label: Text('Continuar'),
      icon: Icon(Icons.skip_next),
      backgroundColor: Colors.redAccent,
    );
  }
}
