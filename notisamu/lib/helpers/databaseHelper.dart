import 'dart:async';
import 'dart:io';
import 'package:noti_samu/components/notificacao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String notificationTable = 'notification';
  String colNotifying = 'notifying';
  String colProfission = 'profission';
  String colPatient = 'patient';
  String colBirth = 'birth';
  String colSex = 'sex';
  String colOccurrenceNumber = 'occurrenceNumber';
  String colLocal = 'local';
  String colOccurenceDate = 'occurrenceDate';
  String colPeriod = 'period';
  String colIncident = 'incident';
  String colQuestion = 'question';
  String colAnswer = 'answer';
  String colInfoExtra = 'infoExtra';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null)
      _databaseHelper = DatabaseHelper._createInstance();
    else
      _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notification.db';

    var notificationDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
  }

  _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $notificationTable()');
  }
}
