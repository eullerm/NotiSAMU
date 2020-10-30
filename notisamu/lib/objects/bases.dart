import 'package:scoped_model/scoped_model.dart';

class Bases extends Model {
  Map<String, String> _bases = {
    "marica": "Maricá",
    "niteroi": "Niterói",
  };

  Map<String, String> get bases {
    return _bases;
  }

  String getSpecificBase(String base) {
    return _bases[base];
  }
}
