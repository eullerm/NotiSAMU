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
  Map<String, String> respostas = {};

  Notificacao({
    this.notificante,
    this.profissao,
    this.paciente,
    this.nascimento,
    this.sexo,
    this.numeroDaOcorrencia,
    this.local,
    this.dataDaOcorrencia,
    this.periodo,
    this.incidente,
    this.infoExtra,
    this.respostas,
  });
}
