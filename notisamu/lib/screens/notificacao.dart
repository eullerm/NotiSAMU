import 'package:scoped_model/scoped_model.dart';

class Notificacao extends Model {

  String notificante;
  String profissao;
  String paciente;
  DateTime nascimento;
  String sexo;
  String numeroDaOcorrencia;
  String local;
  DateTime dataDaOcorrencia;
  String periodo;
  List<String> incidente = List();
  String infoExtra;

}
