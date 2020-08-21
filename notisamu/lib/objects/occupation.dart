import 'package:scoped_model/scoped_model.dart';

class Occupations extends Model {
  final List<String> _list = [
    'Enfermeira(o)',
    'Técnico de enfermagem',
    'Médica(o)',
  ];

  List<String> get occupations {
    return _list;
  }
}
