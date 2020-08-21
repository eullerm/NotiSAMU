import 'package:scoped_model/scoped_model.dart';

class Locals extends Model {
  List<String> _locals = [
    "Residência",
    "Via pública",
    "Unidade de saúde",
    "Outros"
  ];

  List<String> get locals {
    return _locals;
  }
}
