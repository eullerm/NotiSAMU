import 'package:scoped_model/scoped_model.dart';

class Sex extends Model {
  List<String> _sex = ["Masculino", "Feminino", "Não informar"];

  List<String> get sex {
    return _sex;
  }
}
