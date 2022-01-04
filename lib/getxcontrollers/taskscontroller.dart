import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/TaskModel.dart';
import 'package:archorganisebetter/datastores/TaskDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class TaskController extends GetxController{
  TextEditingController addtaskcontroller=TextEditingController();
  Taskdbhelper taskdbhelper = Taskdbhelper();
  List<TaskModel>? allincompletetaskslist;
  List<TaskModel>? allcompletetaskslist;
  int count = 0;
  int currentlistid=0;
  bool alarm=false;

  completethetask(int index){
    this.allincompletetaskslist![index].status="1";
    save(allincompletetaskslist![index]);
 //   this.allcompletetaskslist![index].status="1";
   // save(allcompletetaskslist![index]);
    updateincompletetaskistView();
    updateincompletetaskistView();
    updatecompletetaskistView();
    updatecompletetaskistView();
    update();
  }
  uncompletethetask(int index){
  //  this.allincompletetaskslist![index].status="0";
    //save(allincompletetaskslist![index]);
    this.allcompletetaskslist![index].status="0";
    save(allcompletetaskslist![index]);
    updateincompletetaskistView();
    updateincompletetaskistView();
    updatecompletetaskistView();
    updatecompletetaskistView();
    update();
  }
  addatask(BuildContext context)async{
    if(addtaskcontroller.text!="") {
      save(TaskModel(
          addtaskcontroller.text,
          currentlistid,
          "",
          DateFormat.yMMMMd().format(DateTime.now()),
          DateFormat.Hm().format(DateTime.now()),
          "",
          "",
          "0",
          "",
          "",
          "Your Name"));
      updateincompletetaskistView();
      updatecompletetaskistView();
      //  AnimatedList.of(context).insertItem(0);
      addtaskcontroller.clear();
    }
  }
  deletecompletedtask(TaskModel taskModel)async{
    delete(taskModel);
    updatecompletetaskistView();
    update();
  }

  deleteallcompletedtasks(){
    for(int i=0;i<allcompletetaskslist!.length;i++){
      delete(allcompletetaskslist![i]);
      updatecompletetaskistView();
      update();
    }
  }
  void save(TaskModel taskModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (taskModel.id != null) {  // Case 1: Update operation
      result = await taskdbhelper.updateTask(taskModel);
    } else { // Case 2: Insert Operation
      result = await taskdbhelper.insertTask(taskModel);
    }

    if (result != 0) {  // Success
      print( 'Note Saved Successfully');
    } else {  // Failure
      print( 'Problem Saving Note');
    }

  }

  void delete(TaskModel taskModel) async {


    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await taskdbhelper.deleteTask(taskModel.id!.toInt());
    if (result != 0) {
      print('Note Deleted Successfully');
    } else {
      print('Error Occured while Deleting Note');
    }
  }
  void updateincompletetaskistView() {

    final Future<Database> dbFuture = taskdbhelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<TaskModel>> noteListFuture = taskdbhelper.getincompleteTasksList();
      noteListFuture.then((noteList) {
        this.allincompletetaskslist = noteList;
        this.count = noteList.length;
        update();
      });
    });
  }
  void updatecompletetaskistView() {

    final Future<Database> dbFuture = taskdbhelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<TaskModel>> noteListFuture = taskdbhelper.getcompleteTasksList();
      noteListFuture.then((noteList) {
        this.allcompletetaskslist = noteList;
        this.count = noteList.length;
        update();
      });
    });
  }
  showbottomsheetfortasks(
      TaskModel taskModel,
      BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return
      showModalBottomSheet(
          enableDrag: true,
          //  backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return GestureDetector(
              child: Container(
                width: screenwidth,
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: screenheight*0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28),
                      topRight: Radius.circular(28)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 9),
                          height: 4,width: 44,
                          decoration: BoxDecoration(
                              color: Color(0xff9A9DBC),
                              borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                        ),


                      ],
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16 ),
                          child: Text("Details",style: TextStyle(
                              fontFamily: sfproroundedmedium,
                              color: Color(0xff8A8DA8),
                              fontSize: 14.5
                          ),),
                        ),

                      ],
                    ),
                    Container(
                      width: screenwidth,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(taskModel.tasktitle.toString(),
                              style: TextStyle(
                                  fontFamily:sfprosemibold
                                  ,color: Colors.black,
                                  fontSize: 20.5
                              ),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      width: screenwidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Occuring every:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12.5
                              ),),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            child:RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 13.5,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                  children:[
                                    TextSpan(
                                        text: "MON "
                                    ),
                                    TextSpan(
                                      text: "08:15 - 09:30,  ",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.black,
                                          fontFamily: sfprosemibold),
                                    ),
                                    TextSpan(
                                        text: "TUE "
                                    ),
                                    TextSpan(
                                      text: "09:45 - 11:00. ",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.black,
                                          fontFamily: sfprosemibold),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Container(
                            width: screenwidth,
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  for (int i = 0; i < 7; i++)
                                    GestureDetector(
                                      onTap: () {
                                      },
                                      child: AnimatedContainer(
                                        margin: EdgeInsets.only(right: 6.5),
                                        duration: Duration(milliseconds: 150),
                                        padding: EdgeInsets.all(11.5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                            //      selecteddaylist.contains(i) ?
                                            Color(0xff006EFF)
                                          //            : Colors.transparent
                                        ),
                                        //    margin: EdgeInsets.only(left: 12,right: i==6?12:0),
                                        child: Text(
                                          getdaysofweek(i),
                                          style: TextStyle(
                                              fontFamily:sfproroundedregular,
                                              color:
                                              Colors.white
                                              ,
                                              fontSize: 12.5),
                                        ),
                                      ),
                                    ),]),
                          )

                        ],
                      ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Text("Remind me about this:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 12.5
                            ),),
                        ),

                      ],
                    ),
                    Container(
                      width: screenwidth,
                      margin: EdgeInsets.symmetric(vertical: 8.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Alarm",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12.5
                              ),),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("works");
                              toggleremindertype();
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(horizontal: 13.5),
                              duration:
                              Duration(milliseconds: 350),
                              height: 24,
                              width: 45,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.4, vertical: 2.4),
                              decoration: BoxDecoration(
                                  color: alarm
                                      ? Color(0xff006EFF)
                                      : Color(0xffD9D9D9),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(13))),
                              child: Row(
                                mainAxisAlignment:
                                alarm
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 19.5,
                                      width: 19.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Text("Notification",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12.5
                              ),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );}

      );
  }
  getdaysofweek(int weekno){
    if(weekno==0){
      return 'Mon';
    }else if(weekno==1){
      return 'Tue';

    }else if(weekno==2){
      return 'Wed';

    }else if(weekno==3){
      return 'Thu';

    }else if(weekno==4){
      return 'Fri';

    }else if(weekno==5){
      return 'Sat';

    }else if(weekno==6){
      return 'Sun';

    }

  }
  toggleremindertype(){
    alarm=true;
    update();
  }
}