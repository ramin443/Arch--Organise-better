import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:archorganisebetter/datastores/DailyClassdbhelper.dart';
import 'package:archorganisebetter/widgets/add_to_your_routine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController{
  bool isemergencymode=false;
  String yourmom='';
  DailyClassdbHelper dailyClassdbHelper = DailyClassdbHelper();
  List<DailyClassModel>? dailyclasseslist;
  int count = 0;
  int currentdate=1;
  bool alarm=false;
  List<DailyClassModel> selecteddatelist=[];
  ScrollController scrollController=ScrollController(
  initialScrollOffset:(
      double.parse(
          DateFormat.d('en_US').format(DateTime.now())
      )/
      (daysInMonth(
      int.parse(DateFormat
          .y('en_US')
          .format(DateTime
          .now())),
      int.parse(DateFormat
          .M('en_US')
          .format(DateTime
          .now())))    ).toDouble())*1203);
  String time='0';

  toggleremindertype(){
    alarm=true;
    update();
  }

  initializelistfortoday()async{

  }
  gototoday()async{
    
  }
  initializescrolloffset(){

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
  showbottomsheetfordailyroutine(
      DailyClassModel dailyClassModel,
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
                      child: Text(dailyClassModel.classtitle.toString(),
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
  addtoroutinedialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) {
          return ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(18)),
              child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(
                            18)),
                  ),
                  children: [
                    //      AddCardDialog()
                    //   OrderSuccesfulDialog()
                    //  CancelOrderDialog()
                    AddtoyourRoutine()
                  ]));
        });
  }
  setcurrentdate(int date){
    currentdate=date;
    update();
  }
  getclassesfromthisspecificdate()async{

  }
   getdatafromaspecificdate(int date)async{
     DateTime now = new DateTime.now();
     String daterequested=  DateFormat.yMMMd().format(DateTime(now.year
    ,now.month,date));
  print("Date requested: "+daterequested);
  updatecurrrentselecteddaylistvew(daterequested);
  //   updatealllistview();
     return daterequested;
  }
  void save(DailyClassModel dailyClassModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (dailyClassModel.id != null) {  // Case 1: Update operation
      result = await dailyClassdbHelper.updateClass(dailyClassModel);
    } else { // Case 2: Insert Operation
      result = await dailyClassdbHelper.insertClass(dailyClassModel);
    }

    if (result != 0) {  // Success
      print( 'Note Saved Successfully');
    } else {  // Failure
      print( 'Problem Saving Note');
    }

  }
  settodaysdate()async{
    print(DateFormat.d('en_US').format(DateTime.now()));
    currentdate=int.parse(DateFormat.d('en_US').format(DateTime.now()));
    update();
  }
  addascrolllistener()async{
    scrollController.addListener(_scrollListener);
  }
  animateinitialized(){

  }
  animtetospecifieddate(int date,int totaldaysinamonth){
    if (scrollController.hasClients){
      if(date<5){
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease
        );
      }else if(date>24){
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease
        );
      }else if(date>18 && date<25){
        scrollController.animateTo(
            date/totaldaysinamonth*scrollController.position.maxScrollExtent+40,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease
        );
      }
      else{
        scrollController.animateTo(date/totaldaysinamonth*scrollController.position.maxScrollExtent-40,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease
        );
      }
     }
  }
  getposition(int date,int totaldaysinamonth){
    if(date<5){
      return scrollController.position.minScrollExtent;
    }else if(date>24){
      return scrollController.position.maxScrollExtent;
    }else if(date>18 && date<25){
       return
         (date/totaldaysinamonth*scrollController.position.maxScrollExtent+40);
    }
    else{
     return (date/totaldaysinamonth*scrollController.position.maxScrollExtent-40);
    }
  }
  _scrollListener() {
    if(scrollController.offset/scrollController.position.maxScrollExtent*720>60){
      if((scrollController.offset/scrollController.position.maxScrollExtent*720-
          int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
          toStringAsFixed(0))*60)<0){
        time=(((scrollController.offset/scrollController.position.maxScrollExtent*720/60).floor()).toStringAsFixed(0)+'h '+
            (59+(scrollController.offset/scrollController.position.maxScrollExtent*720-
                int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
                toStringAsFixed(0))*60)).toStringAsFixed(0)+"m"
        );}else{
        time=(((scrollController.offset/scrollController.position.maxScrollExtent*720/60).floor()).toStringAsFixed(0)+'h '+
            (scrollController.offset/scrollController.position.maxScrollExtent*720-
                int.parse((scrollController.offset/scrollController.position.maxScrollExtent*720/60).
                toStringAsFixed(0))*60).toStringAsFixed(0)+"m"
        );
      }
    }else{
      time=(scrollController.offset/scrollController.position.maxScrollExtent*720).toStringAsFixed(0)+"m";
    }
    update();
  }

  toggleemergencymode(){
    isemergencymode=!isemergencymode;
    update();
  }
  void _save(DailyClassModel dailyClassModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (dailyClassModel.id != null) {  // Case 1: Update operation
      result = await dailyClassdbHelper.updateClass(dailyClassModel);
    } else { // Case 2: Insert Operation
      result = await dailyClassdbHelper.insertClass(dailyClassModel);
    }

    if (result != 0) {  // Success
      print( 'Note Saved Successfully');
    } else {  // Failure
      print( 'Problem Saving Note');
    }

  }
  void _delete(int id) async {


    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await dailyClassdbHelper.deleteClass(id);
    if (result != 0) {
      print('Note Deleted Successfully');
    } else {
      print('Error Occured while Deleting Note');
    }
  }
  void updatecurrrentselecteddaylistvew(String specificdate) {
    final Future<Database> dbFuture = dailyClassdbHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<DailyClassModel>> noteListFuture =
      dailyClassdbHelper.getspecificdateClassesList(specificdate);
      noteListFuture.then((noteList) {
        this.dailyclasseslist = noteList;
        this.count = noteList.length;
        update();
      });
    });
  }
  void updatealllistview() {
    final Future<Database> dbFuture = dailyClassdbHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<DailyClassModel>> noteListFuture =
      dailyClassdbHelper.getClassesList();
      noteListFuture.then((noteList) {
        this.dailyclasseslist = noteList;
        this.count = noteList.length;
        update();
      });
    });
  }
}