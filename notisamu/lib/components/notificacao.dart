import 'package:scoped_model/scoped_model.dart';

class Notificacao extends Model {
  String notifying;
  String profission;
  String patient;
  DateTime birth;
  String sex;
  String occurrenceNumber;
  String local;
  DateTime occurrenceDate;
  String period;
  List<String> incident = List();
  Map<String, String> answer = {};
  String infoExtra;

  /*Getters
  String get notifying{
    return _notifying;
  }

  String get profission{
    return _profission;
  }

  String get patient{
    return _patient;
  }

  DateTime get birth{
    return _birth;
  }

  String get sex{
    return _sex;
  }

  String get occurrenceNumber{
    return _occurrenceNumber;
  }

  String get local{
    return _local;
  }

  DateTime get occurrenceDate{
    return _occurrenceDate;
  }

  String get period{
    return _period;
  }

  List<String> get incident {
    return _incident;
  }

  Map<String, String> get answer {
    return _answer;
  }

  String get infoExtra{
    return _infoExtra;
  }

  */

  setNotifying(String string){
    this.notifying = string;
  }

  setProfission(String string){
    this.profission = string;
  }

  setPatient(String string){
    this.patient = string;
  }

  setBirth(DateTime date){
    this.birth = date;
  }

  setSex(String string){
    this.sex = string;
  }

  setOccurrenceNumber(String number){
    this.occurrenceNumber = number;
  }

  setLocal(String string){
    this.local = string;
  }

  setDate(DateTime date){
    this.occurrenceDate = date;
  }

  setPeriod(String string){
    this.period = string;
  }

  setIncident(String string){
    if(this.incident == null)
      this.incident = [string];
    else
      this.incident.add(string);
  }

  setAnswer(String key, String value){
    if(this.answer == null)
      this.answer = {key: value};
    else
      this.answer.putIfAbsent(key, () => value);

  }

  setInfoExtra(String info){
    infoExtra = info;
  }

  Map<String, dynamic> toMap(){

    var map = <String, dynamic>{
      'notifying': notifying,
      'profission': profission,
      'patient': patient,
      'birth': birth,
      'sex': sex,
      'occurrenceNumber': occurrenceNumber,
      'local': local,
      'occurrenceDate': occurrenceDate,
      'period': period,
      'incident': incident,
      'answer': answer,
      'infoExtra': infoExtra, 
    };
      return map;
  }

  Notificacao.fromMap(Map<String, dynamic> map){
      notifying = map['notifying'];
      profission = map['profission'];
      patient = map['patient'];
      birth = map['birth'];
      sex = map['sex'];
      occurrenceNumber = map['occurrenceNumber'];
      local = map['local'];
      occurrenceDate = map['occurrenceDate'];
      period = map['period'];
      incident = map['incident'];
      answer = map['answer'];
      infoExtra = map['infoExtra'];
  }

  Notificacao({
    this.notifying,
    this.profission,
    this.patient,
    this.birth,
    this.sex,
    this.occurrenceNumber,
    this.local,
    this.occurrenceDate,
    this.period,
    this.incident,
    this.answer,
    this.infoExtra,
  });

}
