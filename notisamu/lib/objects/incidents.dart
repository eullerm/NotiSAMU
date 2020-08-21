import 'package:scoped_model/scoped_model.dart';

class Incidents extends Model {
  Map<String, bool> _category = {
    'Erro de prescrição': false,
    'Erro de dispensação/armazenamento': false,
    'Erro de preparo/administração': false,
  };

  Map<String, Map<String, bool>> _mapCategoryQuestions = {
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

  Map<String, String> _mapCategoryExplanation = {
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

  Map<String, bool> get category {
    return _category;
  }

  Map<String, Map<String, bool>> get mapCategoryQuestions {
    return _mapCategoryQuestions;
  }

  Map<String, String> get mapCategoryExplanation {
    return _mapCategoryExplanation;
  }

  selectedCategory(String string, {bool booleana = true}) {
    this._category[string] = booleana;
  }

  selectedIncident(String string, String string2, bool booleana) {
    this._mapCategoryQuestions[string][string2] = booleana;
  }
}
