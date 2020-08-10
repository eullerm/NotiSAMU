import 'package:scoped_model/scoped_model.dart';

class Notify extends Model {

  String _notifying;
  String _profission;
  String _patient;
  String _age;
  String _sex;
  String _occurrenceNumber;
  String _local;
  DateTime _occurrenceDate;
  String _period;
  List<String> _category = List();
  List<String> _answer = List();
  String _infoExtra;
  final String _base;

  Notify(String base) : _base = base;
  
  String get notifying{
    return _notifying;
  }

  String get profission{
    return _profission;
  }

  String get patient{
    return _patient;
  }

  String get age{
    return _age;
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

  List<String> get category {
    return _category;
  }

  List<String> get answer {
    return _answer;
  }

  String get infoExtra{
    return _infoExtra;
  }

  String get base{
    return _base;
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

  setAge(String date){
    this._age = date;
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
    if(this._category == null)
      this._category = [string];
    else
      this._category.add(string);
  }

  setAnswer(String string){
    if(this._answer == null)
      this._answer = [string];
    else
      this._answer.add(string);

  }

  setInfoExtra(String info){
    _infoExtra = info;
  }

  incidentClear(){
    _category = List();
  }

  answerClear(){
    _answer = List();
  }


  
}
