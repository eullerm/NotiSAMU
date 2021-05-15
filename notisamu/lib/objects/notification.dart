import 'package:scoped_model/scoped_model.dart';

class Notify extends Model {
  String _notifying;
  String _occupation;
  String _patient;
  String _age;
  String _sex;
  String _occurrenceNumber;
  String _local;
  DateTime _occurrenceDate;
  String _period;
  String _route;
  List<String> _medicines = [];
  List<String> _category = [];
  List<String> _incidents = [];
  String _infoExtra;
  final String _base;

  Notify(String base) : _base = base;

  String get notifying {
    return _notifying;
  }

  String get occupation {
    return _occupation;
  }

  String get patient {
    return _patient;
  }

  String get age {
    return _age;
  }

  String get sex {
    return _sex;
  }

  String get occurrenceNumber {
    return _occurrenceNumber;
  }

  String get local {
    return _local;
  }

  DateTime get occurrenceDate {
    return _occurrenceDate;
  }

  String get period {
    return _period;
  }

  String get route {
    return _route;
  }

  List<String> get medicines {
    return _medicines;
  }

  List<String> get category {
    return _category;
  }

  List<String> get incidents {
    return _incidents;
  }

  String get infoExtra {
    return _infoExtra;
  }

  String get base {
    return _base;
  }

  setNotifying(String string) {
    this._notifying = string;
  }

  setOccupation(String string) {
    this._occupation = string;
  }

  setPatient(String string) {
    this._patient = string;
  }

  setAge(String date) {
    this._age = date;
  }

  setSex(String string) {
    this._sex = string;
  }

  setOccurrenceNumber(String number) {
    this._occurrenceNumber = number;
  }

  setLocal(String string) {
    this._local = string;
  }

  setDate(DateTime date) {
    this._occurrenceDate = date;
  }

  setPeriod(String string) {
    this._period = string;
  }

  setRoute(String string) {
    this._route = string;
  }

  setMedicines(String string) {
    if (this._medicines == null)
      this._medicines = [string];
    else
      this._medicines.add(string);
  }

  setCategory(String string) {
    if (this._category == null)
      this._category = [string];
    else
      this._category.add(string);
  }

  setIncident(String string) {
    if (this._incidents == null)
      this._incidents = [string];
    else
      this._incidents.add(string);
  }

  setInfoExtra(String info) {
    _infoExtra = info;
  }

  clearMedicines() {
    _medicines = List();
  }

  clearCategorys() {
    _category = List();
  }

  clearIncidents() {
    _incidents = List();
  }
}
