import 'package:scoped_model/scoped_model.dart';

class Periods extends Model {
  List<String> _periods = [
    "Manhã",
    "Tarde",
    "Noite",
  ];

  List<String> get periods {
    return _periods;
  }
}
