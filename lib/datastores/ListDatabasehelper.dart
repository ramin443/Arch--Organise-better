import 'package:archorganisebetter/datamodels/ListModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ListDatabaseHelper {

  static ListDatabaseHelper? _databaseHelper;    // Singleton DatabaseHelper
  static Database? _database;
  String listtable = 'listttablee';
  String colId = 'id';
  String colListTitle = 'listtitle';
  String colListId = 'listid';
  String colcreatedDate = 'createddate';
  String colcreatedTime = 'createdtime';
  String colstatus = 'status';
  String colremindat = 'remindat';
  String colcreatedby = 'createdby';

  ListDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory ListDatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = ListDatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'lisdjhfbksdf.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $listtable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colListTitle TEXT, $colListId INTEGER, $colcreatedDate TEXT,  $colcreatedTime TEXT,'
        '$colstatus TEXT,$colremindat TEXT,$colcreatedby TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getalllistsmapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(listtable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertList(ListModel listModel) async {
    Database db = await this.database;
    var result = await db.insert(listtable, listModel.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updatelist(ListModel listModel) async {
    var db = await this.database;
    var result = await db.update(listtable, listModel.toMap(), where: '$colId = ?',
        whereArgs: [listModel.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteList(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $listtable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $listtable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<ListModel>> getalllistsList() async {

    var taskMapList = await getalllistsmapList(); // Get 'Map List' from database
    int count = taskMapList.length;         // Count the number of map entries in db table
    List<ListModel> tasksList = [];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      tasksList.add(ListModel.fromMapObject(taskMapList[i]));
    }

    return tasksList;
  }


}


