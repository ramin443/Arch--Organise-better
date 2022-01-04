import 'package:archorganisebetter/datamodels/TaskModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Taskdbhelper {

  static Taskdbhelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;                // Singleton Database
  String tasktable = 'classeslist';
  String colId = 'id';
  String colTaskTitle = 'tasktitle';
  String colListId = 'listid';
  String colLocation = 'location';
  String colcreatedDate = 'createddate';
  String colcreatedTime = 'createdtime';
  String coltimer = 'timer';
  String colsubtasks = 'subtasks';
  String colstatus = 'status';
  String colremindat = 'remindat';
  String colnotesorlinks = 'notesorlinks';
  String colcreatedby = 'createdby';

  Taskdbhelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory Taskdbhelper() {

    if (_databaseHelper == null) {
      _databaseHelper = Taskdbhelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'taskks.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tasktable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colTaskTitle TEXT, $colListId INTEGER, $colLocation TEXT, $colcreatedDate TEXT, $colcreatedTime TEXT,'
        '$coltimer TEXT,$colsubtasks TEXT,$colstatus TEXT,$colremindat TEXT,'
        '$colnotesorlinks TEXT,$colcreatedby TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getincompleteTasksmapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(tasktable, orderBy: '$colId DESC',where: '$colstatus=0');
    return result;
  }
  Future<List<Map<String, dynamic>>> getcompleteTasksmapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(tasktable, orderBy: '$colId DESC',where: '$colstatus=1');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertTask(TaskModel taskModel) async {
    Database db = await this.database;
    var result = await db.insert(tasktable, taskModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateTask(TaskModel taskModel) async {
    var db = await this.database;
    var result = await db.update(tasktable, taskModel.toMap(), where: '$colId = ?',
        whereArgs: [taskModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteTask(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tasktable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tasktable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<TaskModel>> getincompleteTasksList() async {

    var taskMapList = await getincompleteTasksmapList(); // Get 'Map List' from database
    int count = taskMapList.length;         // Count the number of map entries in db table
    List<TaskModel> tasksList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      tasksList.add(TaskModel.fromMapObject(taskMapList[i]));
    }

    return tasksList;
  }
  Future<List<TaskModel>> getcompleteTasksList() async {

    var taskMapList = await getcompleteTasksmapList(); // Get 'Map List' from database
    int count = taskMapList.length;         // Count the number of map entries in db table
    List<TaskModel> tasksList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      tasksList.add(TaskModel.fromMapObject(taskMapList[i]));
    }

    return tasksList;
  }

}


