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
  Map<String, String> respostas = {};
  String infoExtra;

  setIncidentes(String string){
    if(incidente == null)
      incidente = [string];
    else
      incidente.add(string);
  }

  setRespostas(String key, String value){
    if(respostas == null)
      respostas = {key: value};
    else
      respostas.putIfAbsent(key, () => value);

  }

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
