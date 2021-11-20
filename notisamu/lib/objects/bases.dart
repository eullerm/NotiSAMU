import 'package:scoped_model/scoped_model.dart';

class Bases extends Model {
  Map<String, String> _bases = {
    "marica": "Maricá",
    "niteroi": "Niterói",
    "saogoncalo": "São gonçalo",
    "riobonito": "Rio Bonito",
    "silvajardim": "Silva Jardim",
    "itaborai": "Itaboraí",
    "tangua": "Tangua",
  };

  Map<String, String> get bases {
    return _bases;
  }

  String getSpecificBase(String base) {
    return _bases[base];
  }
}
