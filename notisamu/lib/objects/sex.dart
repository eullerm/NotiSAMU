import 'package:scoped_model/scoped_model.dart';

class Sex extends Model {
  List<String> _sex = ["M", "F", "Não informar"];

  List<String> get sex {
    return _sex;
  }
}
