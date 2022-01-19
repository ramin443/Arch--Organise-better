import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:archorganisebetter/datastores/DailyClassdbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
class RoutineController extends GetxController{
  DailyClassdbHelper dailyClassdbHelper = DailyClassdbHelper();
  List<DailyClassModel>? dailyclasseslist;
  int count = 0;
  int selectedday=0;
  List selecteddaylist=[0];
  List selectedtimeintervallist=[0];
  int selectedtimeinterval=0;
  int typeofrecurringevent=0;
  bool recurringevent=true;
  List addedweekdays=[];

  addtoselecteddaylist(int index){
    selecteddaylist.add(index);
    update();
  }
  removefromselecteddaylist(int index){
    selecteddaylist.remove(index);
    update();
  }
  addtotimeintervallist(int index){
    selectedtimeintervallist.add(index);
    update();
  }
  removefromtimeintervallist(int index){
    selectedtimeintervallist.remove(index);
    update();
  }
  setselectedday(int index){
    selectedday=index;
    update();
  }
  setselectedtimeinterval(int index){
    selectedtimeinterval=index;
    update();
  }
  getcustomintervals(int index){
    if(index==0){
      return "08:15 - 09:30";
    }else if(index==1){
      return "09:30 - 11:00";
    }else if(index==2){
      return "11:15 - 12:30";
    }else if(index==3){
      return "14:15 - 15:30";
    }else if(index==4){
      return "15:45 - 17:00";
    }else if(index==5){
      return "17:15 - 18:30";
    }
  }
  getcustomdays(int index){
    if(index==0){
      return "Today";
    }else if(index==1){
      return "Tomorrow";
    }else if(index==2){
      return "Oct 13, 2021";
    }else if(index==3){
      return "Oct 14, 2021";
    }
  }
  setrecurringevent(){
    recurringevent=!recurringevent;
    update();
  }
  getdaysofweek(int weekno){
    if(weekno==0){
      return 'MON';
    }else if(weekno==1){
      return 'TUE';

    }else if(weekno==2){
      return 'WED';

    }else if(weekno==3){
      return 'THU';

    }else if(weekno==4){
      return 'FRI';

    }else if(weekno==5){
      return 'SAT';

    }else if(weekno==6){
      return 'SUN';

    }

  }
  setrecurringtoeveryday(){
    typeofrecurringevent=0;
    update();
  }
  setrecurringtoweekdays(){
    typeofrecurringevent=1;
    update();
  }
  setrecurringtocustomdate(){
    typeofrecurringevent=2;
    update();
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

  void delete(int id) async {


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
  void updateListView() {

    final Future<Database> dbFuture = dailyClassdbHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<DailyClassModel>> noteListFuture = dailyClassdbHelper.getClassesList();
      noteListFuture.then((noteList) {
          this.dailyclasseslist = noteList;
          this.count = noteList.length;
      update();
      });
    });
  }
  Widget everydayoptions(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text("Occurs everyday at:\n",style: TextStyle(
                    fontFamily:sfprotextregular,color: Colors.black,
          //        fontSize: 10.5
                    fontSize: screenwidth*0.0269
                ),),
              ),
            ],
          ),
          Container(
            height: 28,
            width: screenwidth,
            margin: EdgeInsets.only(top: 0, bottom: 10),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (selectedtimeintervallist
                            .contains(index)) {
                          removefromtimeintervallist(index);
                        } else {
                          addtotimeintervallist(index);
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        margin: EdgeInsets.only(
                          right: 12,
                        ),
                        width: 90,
                        height: 22,
                        decoration: BoxDecoration(
                            color: selectedtimeintervallist
                                .contains(index)
                                ? Color(0xff006EFF)
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            border: selectedtimeintervallist
                                .contains(index)
                                ? Border.all(color: Colors.transparent, width: 0)
                                : Border.all(color: Colors.black, width: 1),
                            boxShadow: [
                              selectedtimeintervallist
                                  .contains(index)
                                  ? BoxShadow(
                                  color: Color(0xff006EFF).withOpacity(0.24),
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                                  : BoxShadow(color: Colors.transparent)
                            ]),
                        child: Center(
                          child: Text(
                            getcustomintervals(index),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: selectedtimeintervallist
                                    .contains(index)
                                    ? Colors.white
                                    : Colors.black,
            //                    fontSize: 10.5
                                fontSize: screenwidth*0.0269
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            height: 28,
            width: screenwidth,
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                     //       padding: EdgeInsets.symmetric(horizontal: 6),
                            margin: EdgeInsets.only(
                              right: 12,
                            ),
                            width: 79,
                            height: 28,
                            decoration: BoxDecoration(
                                color:Color(0xff006EFF)
                                    ,
                                borderRadius: BorderRadius.all(Radius.circular(14)),
                                border:Border.all(color: Colors.transparent, width: 0)
                                 ,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff006EFF).withOpacity(0.24),
                                      blurRadius: 6,
                                      offset: Offset(0, 3))

                                ]),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Custom   +",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white
                                            ,
                      //                  fontSize: 10.5
                                        fontSize: screenwidth*0.0269
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
              ],
            )


          )
        ],
      ),
    );
  }
  Widget weekdayoptions(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Column(children: [
      Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Container(
            margin:EdgeInsets.only(
                top: screenwidth*0.0064
            ),
            child: Text("Occurs every:",style:
            TextStyle(
                fontFamily: sfproroundedregular,
                color: Colors.black,
//                fontSize: 11.5
                fontSize: screenwidth*0.0294
            ),),
          ),
        ],
      ),
      for(int i=0;i<selecteddaylist.length;i++)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                getdaysofweek(selecteddaylist[i]),
                style: TextStyle(
      //            fontSize: 11.5,
                    fontSize: screenwidth*0.0294,
                    fontFamily: sfprotextregular,
                 ),),)
          ],
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
    selecteddaylist.length==0?"":
                getdaysofweek(
                    selecteddaylist[
                    selecteddaylist.length-1])
                    + "at" +
                    getcustomintervals(
                        selectedtimeintervallist[
                        selectedtimeintervallist.length-1 ])

            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: screenwidth*0.0102),
        //    padding: EdgeInsets.symmetric(horizontal: 8),
        width: screenwidth,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < 7; i++)
              GestureDetector(
                onTap: () {
                  if (selecteddaylist
                      .contains(i)) {
                    removefromselecteddaylist(
                        i);
                  } else {
                    addtoselecteddaylist(i);
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:selecteddaylist
                          .contains(i)
                          ? Color(0xff006EFF)
                          : Colors.transparent),
                  //    margin: EdgeInsets.only(left: 12,right: i==6?12:0),
                  child: Text(
                    getdaysofweek(i),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color:
                       selecteddaylist
                            .contains(i)
                            ? Colors.white
                            : Colors.black,
//                        fontSize: 10.5
                        fontSize: screenwidth*0.0269
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4.5),
            child:    selecteddaylist.length==0?Text(""):
            Text(

              "Select time for " +
                getdaysofweek(
                    selecteddaylist[selecteddaylist.length-1]),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
   //           fontSize: 10.5
                fontSize: screenwidth*0.0269
            ),
            )
          ),
        ],
      ),

      Container(
//        height: 28,
        height: screenwidth*0.0717,
        width: screenwidth,
        margin:
        EdgeInsets.only(
//            top: 7.5, bottom: 10
            top: 7.5, bottom: 10
        ),
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (selectedtimeintervallist
                        .contains(index)) {
                     removefromtimeintervallist(
                          index);
                    } else {
                      addtotimeintervallist(
                          index);
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    margin: EdgeInsets.only(
                      right: 12,
                    ),
                    width: 90,
                    height: 22,
                    decoration: BoxDecoration(
                        color: selectedtimeintervallist
                            .contains(index)
                            ? Color(0xff006EFF)
                            : Colors.white,
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                14)),
                        border: selectedtimeintervallist
                            .contains(index)
                            ? Border.all(
                            color: Colors
                                .transparent,
                            width: 0)
                            : Border.all(
                            color: Colors.black,
                            width: 1),
                        boxShadow: [
                          selectedtimeintervallist
                              .contains(index)
                              ? BoxShadow(
                              color: Color(
                                  0xff006EFF)
                                  .withOpacity(
                                  0.24),
                              blurRadius: 6,
                              offset:
                              Offset(0, 3))
                              : BoxShadow(
                              color: Colors
                                  .transparent)
                        ]),
                    child: Center(
                      child: Text(
                        getcustomintervals(
                            index),
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            color: selectedtimeintervallist
                                .contains(index)
                                ? Colors.white
                                : Colors.black,
        //                    fontSize: 10.5
                            fontSize: screenwidth*0.0269
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    ]);
  }
  Widget customdateoptions(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(

            height: 25,
            width: screenwidth,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (selectedtimeintervallist
                            .contains(index)) {
                          removefromtimeintervallist(index);
                        } else {
                          addtotimeintervallist(index);
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        margin: EdgeInsets.only(
                          right: 12,
                        ),
                        width: 90,
                        height: 22,
                        decoration: BoxDecoration(
                            color: selectedtimeintervallist
                                .contains(index)
                                ? Color(0xff006EFF)
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            border: selectedtimeintervallist
                                .contains(index)
                                ? Border.all(color: Colors.transparent, width: 0)
                                : Border.all(color: Colors.black, width: 1),
                            boxShadow: [
                              selectedtimeintervallist
                                  .contains(index)
                                  ? BoxShadow(
                                  color: Color(0xff006EFF).withOpacity(0.24),
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                                  : BoxShadow(color: Colors.transparent)
                            ]),
                        child: Center(
                          child: Text(
                            getcustomdays(index),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: selectedtimeintervallist
                                    .contains(index)
                                    ? Colors.white
                                    : Colors.black,
                //                fontSize: 10.5
                                fontSize: screenwidth*0.0269
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
              height: 25,
              width: screenwidth,
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      //       padding: EdgeInsets.symmetric(horizontal: 6),
                      margin: EdgeInsets.only(
                        right: 12,
                      ),
                      width: 79,
                      height: 28,
                      decoration: BoxDecoration(
                          color:Color(0xff006EFF)
                          ,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          border:Border.all(color: Colors.transparent, width: 0)
                          ,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff006EFF).withOpacity(0.24),
                                blurRadius: 6,
                                offset: Offset(0, 3))

                          ]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Custom   +",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                                  ,
                  //                fontSize: 10.5
                                  fontSize: screenwidth*0.0269
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )


          )
        ],
      ),
    );
  }
}