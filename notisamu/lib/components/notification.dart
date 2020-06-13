import 'package:scoped_model/scoped_model.dart';

class Notify extends Model {
  String _notifying;
  String _profission;
  String _patient;
  DateTime _birth;
  String _sex;
  String _occurrenceNumber;
  String _local;
  DateTime _occurrenceDate;
  String _period;
  List<String> _incident = List();
  Map<String, String> _answer = {};
  String _infoExtra;

  
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

  

  setNotifying(String string){
    this._notifying = string;
  }

  setProfission(String string){
    this._profission = string;
  }

  setPatient(String string){
    this._patient = string;
  }

  setBirth(DateTime date){
    this._birth = date;
  }

  setSex(String string){
    this._sex = string;
  }

  setOccurrenceNumber(String number){
    this._occurrenceNumber = number;
  }

  setLocal(String string){
    this._local = string;
  }

  setDate(DateTime date){
    this._occurrenceDate = date;
  }

  setPeriod(String string){
    this._period = string;
  }

  setIncident(String string){
    if(this._incident == null)
      this._incident = [string];
    else
      this._incident.add(string);
  }

  setAnswer(String key, String value){
    if(this._answer == null)
      this._answer = {key: value};
    else
      this._answer.putIfAbsent(key, () => value);

  }

  setInfoExtra(String info){
    _infoExtra = info;
  }

  
}
