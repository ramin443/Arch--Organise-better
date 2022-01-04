
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DailyClassdbHelper {

  static DailyClassdbHelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;                // Singleton Database

  String classtable = 'classeslist';
  String colId = 'id';
  String colTitle = 'classtitle';
  String colLocation = 'classlocation';
  String colDate = 'date';
  String colstartTime = 'starttime';
  String colendTime = 'endtime';

  DailyClassdbHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DailyClassdbHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DailyClassdbHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tesclasses.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $classtable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colLocation TEXT, $colDate INTEGER, $colstartTime TEXT,$colendTime TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getClassesmapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(classtable, orderBy: '$colId DESC');
    return result;
  }
  Future<List<Map<String, dynamic>>> getspecificdateClassesmapList(String specificdate) async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(classtable, where: '$colDate="$specificdate"',orderBy: '$colstartTime ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertClass(DailyClassModel dailyClassModel) async {
    Database db = await this.database;
    var result = await db.insert(classtable, dailyClassModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateClass(DailyClassModel dailyClassModel) async {
    var db = await this.database;
    var result = await db.update(classtable, dailyClassModel.toMap(), where: '$colId = ?',
        whereArgs: [dailyClassModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteClass(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $classtable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $classtable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<DailyClassModel>> getClassesList() async {

    var noteMapList = await getClassesmapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<DailyClassModel> classList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      classList.add(DailyClassModel.fromMapObject(noteMapList[i]));
    }

    return classList;
  }
  Future<List<DailyClassModel>> getspecificdateClassesList(String date) async {

    var noteMapList = await getspecificdateClassesmapList(date); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<DailyClassModel> classList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      classList.add(DailyClassModel.fromMapObject(noteMapList[i]));
    }

    return classList;
  }

}


