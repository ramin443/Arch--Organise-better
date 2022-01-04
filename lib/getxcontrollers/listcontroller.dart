import 'dart:math';

import 'package:archorganisebetter/datamodels/ListModel.dart';
import 'package:archorganisebetter/datastores/ListDatabasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ListController extends GetxController{
  TextEditingController listtitlecontroller=TextEditingController();
  ListDatabaseHelper listDatabasehelper = ListDatabaseHelper();
  List<ListModel>? allcreatedlists;
  int count=0;

 int createalistid(){
    int listid=Random().nextInt(100000);
    return listid;
  }

  createnewlist()async{
   int randomlistid=Random().nextInt(200000);
    save(ListModel("Groceries", randomlistid,
        DateFormat.yMMMMd().format(DateTime.now()),
        DateFormat.Hm().format(DateTime.now()),
        "Incomplete", "",
        "User"));
    //save(ListModel("_listtitle", 542, _createddate, _createdtime, _status, _remindat, _createdby))
    updatelistslistView();
    update();
  }
  deletealist(ListModel listModel)async{
   delete(listModel);
   updatelistslistView();
   update();
  }

  void save(ListModel listModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (listModel.id != null) {  // Case 1: Update operation
      result = await listDatabasehelper.updatelist(listModel);
    } else { // Case 2: Insert Operation
      result = await listDatabasehelper.insertList(listModel);
    }

    if (result != 0) {  // Success
      print( 'List Saved Successfully');
    } else {  // Failure
      print( 'Problem Saving List');
    }

  }

  void delete(ListModel listModel) async {


    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await listDatabasehelper.deleteList(listModel.id!.toInt());
    if (result != 0) {
      print('List Deleted Successfully');
    } else {
      print('Error Occured while Deleting the List');
    }
  }
  void updatelistslistView() {
    final Future<Database> dbFuture = listDatabasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ListModel>> noteListFuture = listDatabasehelper.getalllistsList();
      noteListFuture.then((noteList) {
        this.allcreatedlists = noteList;
        this.count = noteList.length;
        update();
      });
    });
  }
}