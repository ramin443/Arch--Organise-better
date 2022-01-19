import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:archorganisebetter/datastores/DailyClassdbhelper.dart';
import 'package:archorganisebetter/widgets/add_to_your_routine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  bool isemergencymode = false;
  String yourmom = '';
  List selecteddaylist=[0,1,2,3,4,5];
  List selectedtimeintervallist=[0];
  double? heightOfModalBottomSheet = 50;
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController newclasstitlecontroller = TextEditingController();
  DailyClassdbHelper dailyClassdbHelper = DailyClassdbHelper();
  List<DailyClassModel>? dailyclasseslist;
  int count = 0;
  int typeofrecurringevent=0;
  int currentdate = 1;
  bool addnewclassrecurringevent = false;
  bool alarm = false;
  String unrecurringdate="Today, "+DateFormat.yMMMMd('en_US').format(DateTime.now());
  List<DailyClassModel> selecteddatelist = [];
  ScrollController scrollController = ScrollController(
      initialScrollOffset: (double.parse(
                  DateFormat.d('en_US').format(DateTime.now())) /
              (daysInMonth(
                      int.parse(DateFormat.y('en_US').format(DateTime.now())),
                      int.parse(DateFormat.M('en_US').format(DateTime.now()))))
                  .toDouble()) *
          1203);
  String time = '0';

  addtoselecteddaylist(int index){
    selecteddaylist.add(index);
    update();
  }
  removefromselecteddaylist(int index){
    selecteddaylist.remove(index);
    update();
  }
  toggleremindertype() {
    alarm = true;
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
  setrecurringevent() {
    addnewclassrecurringevent = !addnewclassrecurringevent;
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

  initializelistfortoday() async {}

  gototoday() async {}

  initializescrolloffset() {}

  getdaysofweek(int weekno) {
    if (weekno == 0) {
      return 'Mon';
    } else if (weekno == 1) {
      return 'Tue';
    } else if (weekno == 2) {
      return 'Wed';
    } else if (weekno == 3) {
      return 'Thu';
    } else if (weekno == 4) {
      return 'Fri';
    } else if (weekno == 5) {
      return 'Sat';
    } else if (weekno == 6) {
      return 'Sun';
    }
  }
  setrecurringtoweekdays(){
    typeofrecurringevent=1;
    update();
  }
  setrecurringtocustomdate(){
    typeofrecurringevent=2;
    update();
  }
  showexample(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: heightOfModalBottomSheet,
              child: Column(
                children: [
                  RaisedButton(onPressed: () {
                    setState(() {
                      heightOfModalBottomSheet = heightOfModalBottomSheet! + 10;
                    });
                  }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setrecurringevent();
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      height: 24,
                      width: 45,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.4, vertical: 2.4),
                      decoration: BoxDecoration(
                          color: addnewclassrecurringevent
                              ? Color(0xff006EFF)
                              : Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Row(
                        mainAxisAlignment: addnewclassrecurringevent
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                 //             height: 19.5, width: 19.5,
                              height: screenwidth * 0.05,
                              width: screenwidth * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  showbottomsheettoadd(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Colors.transparent,
        //  backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
              child: Container(
                width: screenwidth,
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0461),
                height: screenheight * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
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
                          margin: EdgeInsets.only(
//                          top: 9
                              top: screenwidth * 0.0230),
//                      height: 4,width: 44,
                          height: screenwidth * 0.0102,
                          width: screenwidth * 0.112,
                          decoration: BoxDecoration(
                              color: Color(0xff9A9DBC),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
//                          top: 16
                              top: screenwidth * 0.041),
                          child: Text(
                            "Add new event",
                            style: TextStyle(
                                fontFamily: sfproroundedmedium,
                                color: Color(0xff8A8DA8),
//                          fontSize: 14.5
                                fontSize: screenwidth * 0.0371),
                          ),
                        ),
                        Container(
                          child: Icon(
                            CupertinoIcons.checkmark_alt_circle_fill,
                            color: Color(0xff006EFF),
                            //       size: 38,
                            size: screenwidth * 0.0974,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: screenwidth,
                      margin: EdgeInsets.only(top: screenwidth * 0.0256),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
//                                top: 6
                                  top: screenwidth * 0.0153),
                              //      height: 30,
                              height: screenwidth * 0.0769,
                              width: screenwidth * 0.85,
                              child: TextFormField(
                                style: TextStyle(
                                    fontFamily: sfprosemibold,
                                    color: Colors.black,
//                              fontSize: 20.5
                                    fontSize: screenwidth * 0.0525),
                                controller: newclasstitlecontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        " e.g., Calculus & Linear Algebra...",
                                    hintStyle: TextStyle(
                                        fontFamily: sfprosemibold,
                                        color: Colors.black45,
//                              fontSize: 20.5
                                        fontSize: screenwidth * 0.0525)),
                              )
                              /*  Text("Enter class title",
                              style: TextStyle(
                                  fontFamily:sfprosemibold
                                  ,color: Colors.black,
//                              fontSize: 20.5
                                  fontSize: screenwidth*0.0525
                              ),),*/

                              )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(),
                      width: screenwidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Location: ( optional)",
                              style: TextStyle(
                                  fontFamily: sfprotextregular,
                                  color: Colors.black,
//                            fontSize: 12.5
                                  fontSize: screenwidth * 0.0320),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
//                              horizontal: 8
                                horizontal: screenwidth * 0.0205),
                            margin: EdgeInsets.only(
//                              top: 9, bottom: 12
                                top: screenwidth * 0.0230,
                                bottom: screenwidth * 0.0307),
                            //    padding: EdgeInsets.all(4),
                            width: screenwidth,
                            //     height: 30,
                            height: screenwidth * 0.0769,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                color: Color(0xffC7C7C7),
                                width: 0.8,
                              ),
                              color: Color(0xffFDFDFD),
                            ),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: locationcontroller,
                                style: TextStyle(
                                    //fontSize: 12.5,
                                    fontSize: screenwidth * 0.0320,
                                    color: Colors.black87,
                                    fontFamily: sfprotextregular),
                                decoration: InputDecoration(
                                  hintText: "e.g., Reimar Lust Hall..",
                                  hintStyle: TextStyle(
                                      fontFamily: sfprotextregular,
                                      //      fontSize: 12.5,
                                      fontSize: screenwidth * 0.0320,
                                      color: Colors.grey[600]),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
//                              top: 4, bottom: 7
                                top: screenwidth * 0.0102,
                                bottom: screenwidth * 0.0179),
                            child: Text(
                              "Is this a recurring class/ event?",
                              style: TextStyle(
                                fontFamily: sfprotextregular,
                                color: Colors.black,
                                //        fontSize: 12.5
                                fontSize: screenwidth * 0.0320,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                setrecurringevent();
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 350),
//                            height: 24, width: 45,
                              height: screenwidth * 0.0615,
                              width: screenwidth * 0.115,
                              padding: EdgeInsets.symmetric(
//                                horizontal: 2.4, vertical: 2.4
                                  horizontal: screenwidth * 0.0061,
                                  vertical: screenwidth * 0.0061),
                              decoration: BoxDecoration(
                                  color: addnewclassrecurringevent
                                      ? Color(0xff5AB898)
                                      : Color(0xffD9D9D9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13))),
                              child: Row(
                                mainAxisAlignment: addnewclassrecurringevent
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
//                                    height: 19.5, width: 19.5,
                                      height: screenwidth * 0.05,
                                      width: screenwidth * 0.05,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle))
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  AnimatedSwitcher(duration: Duration(milliseconds: 250
                  ),
                  child: addnewclassrecurringevent?
                  Container(
                    width: screenwidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
//                top: 15.5, bottom: 14.5
                                  top: screenwidth*0.0397,
                              ),
                              child: Text("Occurs :\n",style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  //       fontSize: 10.5
                                  fontSize: screenwidth*0.0269 ),),
                            ),
                          ],
                        ),
                        Container(
                          width: screenwidth,
                          margin: EdgeInsets.only(
//                top: 15.5, bottom: 14.5
                              bottom: screenwidth*0.0171
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState((){

                                    });
                                    setrecurringtoeveryday();
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
//                            height: 14.5, width: 14.5,
                                          height: screenwidth*0.0371, width: screenwidth*0.0371,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                              typeofrecurringevent ==
                                                  0
                                                  ? Color(0xff006EFF)
                                                  : Colors
                                                  .transparent,
                                              border: typeofrecurringevent !=
                                                  0
                                                  ? Border.all(
                                                  color: Color(
                                                      0xff555555))
                                                  : Border.all(
                                                  width: 0,
                                                  color: Colors
                                                      .transparent)),
                                          child: typeofrecurringevent ==
                                              0
                                              ? Center(
                                            child: Container(
                                              child: Icon(
                                                CupertinoIcons
                                                    .checkmark_alt,
                                                color: Colors
                                                    .white,
//                                  size: 9.5,
                                                size: screenwidth*0.0243,
                                              ),
                                            ),
                                          )
                                              : SizedBox(
                                            height: 0,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
//                                left: 7.5
                                              left:screenwidth*0.0192
                                          ),
                                          child: Text(
                                            "Everyday",
                                            style: TextStyle(
                                              //           fontSize: 12,
                                              fontSize: screenwidth*0.0307,
                                              color: Colors.black,
                                              fontFamily: sfprotextregular,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState((){

                                    });
                                    setrecurringtoweekdays();
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          //       height: 14.5, width: 14.5,
                                          height: screenwidth*0.0371,width: screenwidth*0.0371,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: typeofrecurringevent ==
                                                  1
                                                  ? Color(0xff006EFF)
                                                  : Colors
                                                  .transparent,
                                              border: typeofrecurringevent !=
                                                  1
                                                  ? Border.all(
                                                  color: Color(
                                                      0xff555555))
                                                  : Border.all(
                                                  width: 0,
                                                  color: Colors
                                                      .transparent)),
                                          child: typeofrecurringevent ==
                                              1
                                              ? Center(
                                            child: Container(
                                              child: Icon(
                                                CupertinoIcons
                                                    .checkmark_alt,
                                                color: Colors
                                                    .white,
//                                  size: 9.5,
                                                size: screenwidth*0.0243,
                                              ),
                                            ),
                                          )
                                              : SizedBox(
                                            height: 0,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            //            left: 7.5
                                              left:screenwidth*0.0192
                                          ),
                                          child: Text(
                                            "Some weekdays",
                                            style: TextStyle(
                                              //              fontSize: 12,
                                              fontSize: screenwidth*0.0307,
                                              color: Colors.black,
                                              fontFamily: sfprotextregular,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ):
                    showunrecurringeventtime(context),
                  ),
                    //Occurs everyday
                   addnewclassrecurringevent?
                       typeofrecurringevent==0?
                   Column(
                      children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Container(
                      child: Text("Occurs everyday at:\n",style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                   //       fontSize: 10.5
                     fontSize: screenwidth*0.0269 ),),
                    ),
                  ],
                ),
                Container(
       //           height: 28,
         height: screenwidth*0.0717,
                  width: screenwidth,
                  margin: EdgeInsets.only(
//                      bottom: 10
                      bottom: screenwidth*0.0256
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
                                removefromtimeintervallist(index);
                                setState((){});
                              } else {
                                addtotimeintervallist(index);
                                setState((){});
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              margin: EdgeInsets.only(
                       //         right: 12,
                         right:  screenwidth*0.0307     ),
//                              width: 90, height: 22,
                              width: screenwidth*0.230, height: screenwidth*0.0564,
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
                        //              fontSize: 10.5
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
          //          height: 28,
                    height: screenwidth*0.0717,
                    width: screenwidth,
                    margin: EdgeInsets.only(
          //              bottom: 10
                       bottom: screenwidth*0.0256        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState((){});
                          },
                          child: Container(
                            //       padding: EdgeInsets.symmetric(horizontal: 6),
                            margin: EdgeInsets.only(
//                              right: 12,
                              right: screenwidth*0.0307,
                            ),
                //            width: 79,
               //             height: 28,
                            width: screenwidth*0.202,
                            height: screenwidth*0.0717,
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
                              //          fontSize: 10.5
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


                )]):typeofrecurringevent==1?
                       Column(
                         children: [
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
                                       setState((){});
                                     },
                                     child: AnimatedContainer(
                                       duration: Duration(milliseconds: 150),
                                       padding: EdgeInsets.all(12),
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
                                             fontSize: 11.5
                                         ),
                                       ),
                                     ),
                                   ),
                               ],
                             ),
                           ),
                           Column(
                               children:[
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Container(
                                       margin: EdgeInsets.only(top: 5),
                                       child: Text("Occurs on Monday at:\n",style: TextStyle(
                                           fontWeight: FontWeight.w400,
                                           color: Colors.black,
                                           //       fontSize: 10.5
                                           fontSize: screenwidth*0.0269 ),),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   //           height: 28,
                                   height: screenwidth*0.0717,
                                   width: screenwidth,
                                   margin: EdgeInsets.only(
//                      bottom: 10
                                       bottom: screenwidth*0.0256
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
                                                 removefromtimeintervallist(index);
                                                 setState((){});
                                               } else {
                                                 addtotimeintervallist(index);
                                                 setState((){});
                                               }
                                             },
                                             child: AnimatedContainer(
                                               duration: Duration(milliseconds: 150),
                                               margin: EdgeInsets.only(
                                                 //         right: 12,
                                                   right:  screenwidth*0.0307     ),
//                              width: 90, height: 22,
                                               width: screenwidth*0.230, height: screenwidth*0.0564,
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
                                                       //              fontSize: 10.5
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
                                   //          height: 28,
                                     height: screenwidth*0.0717,
                                     width: screenwidth,
                                     margin: EdgeInsets.only(
                                       //              bottom: 10
                                         bottom: screenwidth*0.0256        ),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         GestureDetector(
                                           onTap: () {
                                             setState((){});
                                           },
                                           child: Container(
                                             //       padding: EdgeInsets.symmetric(horizontal: 6),
                                             margin: EdgeInsets.only(
//                              right: 12,
                                               right: screenwidth*0.0307,
                                             ),
                                             //            width: 79,
                                             //             height: 28,
                                             width: screenwidth*0.202,
                                             height: screenwidth*0.0717,
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
                                                         //          fontSize: 10.5
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


                                 )])
                         ],
                       ):
                       SizedBox(height: 0,):
                   Column(
                       children:[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Container(
                               child: Text("Occurs at:\n",style: TextStyle(
                                   fontWeight: FontWeight.w400,
                                   color: Colors.black,
                                   //       fontSize: 10.5
                                   fontSize: screenwidth*0.0269 ),),
                             ),
                           ],
                         ),
                         Container(
                           //           height: 28,
                           height: screenwidth*0.0717,
                           width: screenwidth,
                           margin: EdgeInsets.only(
//                      bottom: 10
                               bottom: screenwidth*0.0256
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
                                         removefromtimeintervallist(index);
                                         setState((){});
                                       } else {
                                         addtotimeintervallist(index);
                                         setState((){});
                                       }
                                     },
                                     child: AnimatedContainer(
                                       duration: Duration(milliseconds: 150),
                                       margin: EdgeInsets.only(
                                         //         right: 12,
                                           right:  screenwidth*0.0307     ),
//                              width: 90, height: 22,
                                       width: screenwidth*0.230, height: screenwidth*0.0564,
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
                                               //              fontSize: 10.5
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
                           //          height: 28,
                             height: screenwidth*0.0717,
                             width: screenwidth,
                             margin: EdgeInsets.only(
                               //              bottom: 10
                                 bottom: screenwidth*0.0256        ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                     setState((){});
                                   },
                                   child: Container(
                                     //       padding: EdgeInsets.symmetric(horizontal: 6),
                                     margin: EdgeInsets.only(
//                              right: 12,
                                       right: screenwidth*0.0307,
                                     ),
                                     //            width: 79,
                                     //             height: 28,
                                     width: screenwidth*0.202,
                                     height: screenwidth*0.0717,
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
                                                 //          fontSize: 10.5
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


                         )])


                  ],
                ),
              ),
            );
          });
        });
  }
  showrecurringeventtime(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: screenwidth,
            margin: EdgeInsets.only(
//                top: 15.5, bottom: 14.5
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      setrecurringtoeveryday();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Container(
//                            height: 14.5, width: 14.5,
                            height: screenwidth*0.0371, width: screenwidth*0.0371,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                typeofrecurringevent ==
                                    0
                                    ? Color(0xff006EFF)
                                    : Colors
                                    .transparent,
                                border: typeofrecurringevent !=
                                    0
                                    ? Border.all(
                                    color: Color(
                                        0xff555555))
                                    : Border.all(
                                    width: 0,
                                    color: Colors
                                        .transparent)),
                            child: typeofrecurringevent ==
                                0
                                ? Center(
                              child: Container(
                                child: Icon(
                                  CupertinoIcons
                                      .checkmark_alt,
                                  color: Colors
                                      .white,
//                                  size: 9.5,
                                  size: screenwidth*0.0243,
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
//                                left: 7.5
                                left:screenwidth*0.0192
                            ),
                            child: Text(
                              "Everyday",
                              style: TextStyle(
                     //           fontSize: 12,
                                fontSize: screenwidth*0.0307,
                                color: Colors.black,
                                fontFamily: sfprotextregular,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      setrecurringtoweekdays();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Container(
                     //       height: 14.5, width: 14.5,
                       height: screenwidth*0.0371,width: screenwidth*0.0371,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: typeofrecurringevent ==
                                    1
                                    ? Color(0xff006EFF)
                                    : Colors
                                    .transparent,
                                border: typeofrecurringevent !=
                                    1
                                    ? Border.all(
                                    color: Color(
                                        0xff555555))
                                    : Border.all(
                                    width: 0,
                                    color: Colors
                                        .transparent)),
                            child: typeofrecurringevent ==
                                1
                                ? Center(
                              child: Container(
                                child: Icon(
                                  CupertinoIcons
                                      .checkmark_alt,
                                  color: Colors
                                      .white,
//                                  size: 9.5,
  size: screenwidth*0.0243,
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                    //            left: 7.5
                                left:screenwidth*0.0192
                            ),
                            child: Text(
                              "Some weekdays",
                              style: TextStyle(
                  //              fontSize: 12,
                                fontSize: screenwidth*0.0307,
                                color: Colors.black,
                                fontFamily: sfprotextregular,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    setrecurringtocustomdate();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Container(
//                          height: 14.5, width: 14.5,
                          height: screenwidth*0.0371, width: screenwidth*0.0371,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: typeofrecurringevent ==
                                  2
                                  ? Color(0xff006EFF)
                                  : Colors.transparent,
                              border: typeofrecurringevent !=
                                  2
                                  ? Border.all(
                                  color: Color(
                                      0xff555555))
                                  : Border.all(
                                  width: 0,
                                  color: Colors
                                      .transparent)),
                          child: typeofrecurringevent ==
                              2
                              ? Center(
                            child: Container(
                              child: Icon(
                                CupertinoIcons
                                    .checkmark_alt,
                                color:
                                Colors.white,
                 //               size: 9.5,
                   size: screenwidth*0.0243,
                              ),
                            ),
                          )
                              : SizedBox(
                            height: 0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                    //          left: 7.5
                              left:screenwidth*0.0192
                          ),
                          child: Text(
                            "Custom Date",
                            style: TextStyle(
                         //    fontSize: 12,
                           fontSize: screenwidth*0.0307,
                              color: Colors.black,
                              fontFamily: sfprotextregular,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  setrecurringtoeveryday(){
    typeofrecurringevent=0;
    update();
  }
  showunrecurringeventtime(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
//                              top: 9, bottom: 12
              top: screenwidth * 0.0307,
            ),
            child: Text(
              "Date",
              style: TextStyle(
                  fontFamily: sfprotextregular,
                  color: Colors.black,
//                            fontSize: 12.5
                  fontSize: screenwidth * 0.0320),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
//                              horizontal: 8
                horizontal: screenwidth * 0.0205),
            margin: EdgeInsets.only(
//                              top: 9, bottom: 12
                top: screenwidth * 0.0230,
                bottom: screenwidth * 0.0307),
            //    padding: EdgeInsets.all(4),
            width: screenwidth,
            //     height: 30,
            height: screenwidth * 0.0769,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Color(0xffC7C7C7),
                width: 0.8,
              ),
              color: Color(0xffFDFDFD),
            ),
            child: Center(
                child: Text(unrecurringdate,
                    style: TextStyle(
                        //fontSize: 12.5,
                        fontSize: screenwidth * 0.0320,
                        color: Colors.black87,
                        fontFamily: sfprotextregular))),
          ),
        ],
      ),
    );
  }

  showbottomsheetfordailyroutine(
      DailyClassModel dailyClassModel, BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Colors.transparent,
        //  backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            child: Container(
              width: screenwidth,
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0461),
              height: screenheight * 0.84,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
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
                        margin: EdgeInsets.only(
//                          top: 9
                            top: screenwidth * 0.0230),
//                      height: 4,width: 44,
                        height: screenwidth * 0.0102,
                        width: screenwidth * 0.112,
                        decoration: BoxDecoration(
                            color: Color(0xff9A9DBC),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
//                          top: 16
                            top: screenwidth * 0.041),
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontFamily: sfproroundedmedium,
                              color: Color(0xff8A8DA8),
//                          fontSize: 14.5
                              fontSize: screenwidth * 0.0371),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: screenwidth,
                    margin: EdgeInsets.only(top: screenwidth * 0.0256),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            dailyClassModel.classtitle.toString(),
                            style: TextStyle(
                                fontFamily: sfprosemibold,
                                color: Colors.black,
//                              fontSize: 20.5
                                fontSize: screenwidth * 0.0525),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenwidth * 0.0461),
                    width: screenwidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Occuring every:",
                            style: TextStyle(
                                fontFamily: sfprotextregular,
                                color: Colors.black,
//                            fontSize: 12.5
                                fontSize: screenwidth * 0.0320),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenwidth * 0.0179),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    //   fontSize: 13.5,
                                    fontSize: screenwidth * 0.0346,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(text: "MON "),
                                  TextSpan(
                                    text: "08:15 - 09:30,  ",
                                    style: TextStyle(
                                        //              fontSize: 13.5,
                                        fontSize: screenwidth * 0.0346,
                                        color: Colors.black,
                                        fontFamily: sfprosemibold),
                                  ),
                                  TextSpan(text: "TUE "),
                                  TextSpan(
                                    text: "09:45 - 11:00. ",
                                    style: TextStyle(
                                        //        fontSize: 13.5,
                                        fontSize: screenwidth * 0.0346,
                                        color: Colors.black,
                                        fontFamily: sfprosemibold),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          width: screenwidth,
                          margin: EdgeInsets.symmetric(
                              vertical: screenwidth * 0.0307),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int i = 0; i < 7; i++)
                                  GestureDetector(
                                    onTap: () {},
                                    child: AnimatedContainer(
                                      margin: EdgeInsets.only(
                                          right: screenwidth * 0.0166),
                                      duration: Duration(milliseconds: 150),
                                      padding:
                                          EdgeInsets.all(screenwidth * 0.0294),
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
                                            fontFamily: sfproroundedregular,
                                            color: Colors.white,
                                            //              fontSize: 12.5
                                            fontSize: screenwidth * 0.0320),
                                      ),
                                    ),
                                  ),
                              ]),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          "Remind me about this:",
                          style: TextStyle(
                              fontFamily: sfprotextregular,
                              color: Colors.black,
                              //            fontSize: 12.5
                              fontSize: screenwidth * 0.0320),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: screenwidth,
                    margin:
                        EdgeInsets.symmetric(vertical: screenwidth * 0.0217),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Alarm",
                            style: TextStyle(
                                fontFamily: sfprotextregular,
                                color: Colors.black,
                                //            fontSize: 12.5
                                fontSize: screenwidth * 0.0320),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("works");
                            toggleremindertype();
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.symmetric(
                              //              horizontal: 13.5
                              horizontal: screenwidth * 0.0346,
                            ),
                            duration: Duration(milliseconds: 350),
//                          height: 24, width: 45,
                            height: screenwidth * 0.0615,
                            width: screenwidth * 0.1153,
                            padding: EdgeInsets.symmetric(
//                              horizontal: 2.4, vertical: 2.4
                                horizontal: screenwidth * 0.00615,
                                vertical: screenwidth * 0.00615),
                            decoration: BoxDecoration(
                                color: alarm
                                    ? Color(0xff006EFF)
                                    : Color(0xffD9D9D9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                            child: Row(
                              mainAxisAlignment: alarm
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
//                                  height: 19.5, width: 19.5,
                                    height: screenwidth * 0.05,
                                    width: screenwidth * 0.05,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Notification",
                            style: TextStyle(
                                fontFamily: sfprotextregular,
                                color: Colors.black,
                                //            fontSize: 12.5
                                fontSize: screenwidth * 0.0320),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  addtoroutinedialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  children: [
                    //      AddCardDialog()
                    //   OrderSuccesfulDialog()
                    //  CancelOrderDialog()
                    AddtoyourRoutine()
                  ]));
        });
  }

  setcurrentdate(int date) {
    currentdate = date;
    update();
  }

  getclassesfromthisspecificdate() async {}

  getdatafromaspecificdate(int date) async {
    DateTime now = new DateTime.now();
    String daterequested =
        DateFormat.yMMMd().format(DateTime(now.year, now.month, date));
    print("Date requested: " + daterequested);
    updatecurrrentselecteddaylistvew(daterequested);
    //   updatealllistview();
    return daterequested;
  }

  void save(DailyClassModel dailyClassModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (dailyClassModel.id != null) {
      // Case 1: Update operation
      result = await dailyClassdbHelper.updateClass(dailyClassModel);
    } else {
      // Case 2: Insert Operation
      result = await dailyClassdbHelper.insertClass(dailyClassModel);
    }

    if (result != 0) {
      // Success
      print('Note Saved Successfully');
    } else {
      // Failure
      print('Problem Saving Note');
    }
  }

  settodaysdate() async {
    print(DateFormat.d('en_US').format(DateTime.now()));
    currentdate = int.parse(DateFormat.d('en_US').format(DateTime.now()));
    update();
  }

  addascrolllistener() async {
    scrollController.addListener(_scrollListener);
  }

  animateinitialized() {}

  animtetospecifieddate(int date, int totaldaysinamonth) {
    if (scrollController.hasClients) {
      if (date < 5) {
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 350), curve: Curves.ease);
      } else if (date > 24) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 350), curve: Curves.ease);
      } else if (date > 18 && date < 25) {
        scrollController.animateTo(
            date /
                    totaldaysinamonth *
                    scrollController.position.maxScrollExtent +
                40,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease);
      } else {
        scrollController.animateTo(
            date /
                    totaldaysinamonth *
                    scrollController.position.maxScrollExtent -
                40,
            duration: Duration(milliseconds: 350),
            curve: Curves.ease);
      }
    }
  }

  getposition(int date, int totaldaysinamonth) {
    if (date < 5) {
      return scrollController.position.minScrollExtent;
    } else if (date > 24) {
      return scrollController.position.maxScrollExtent;
    } else if (date > 18 && date < 25) {
      return (date /
              totaldaysinamonth *
              scrollController.position.maxScrollExtent +
          40);
    } else {
      return (date /
              totaldaysinamonth *
              scrollController.position.maxScrollExtent -
          40);
    }
  }

  _scrollListener() {
    if (scrollController.offset /
            scrollController.position.maxScrollExtent *
            720 >
        60) {
      if ((scrollController.offset /
                  scrollController.position.maxScrollExtent *
                  720 -
              int.parse((scrollController.offset /
                          scrollController.position.maxScrollExtent *
                          720 /
                          60)
                      .toStringAsFixed(0)) *
                  60) <
          0) {
        time = (((scrollController.offset /
                        scrollController.position.maxScrollExtent *
                        720 /
                        60)
                    .floor())
                .toStringAsFixed(0) +
            'h ' +
            (59 +
                    (scrollController.offset /
                            scrollController.position.maxScrollExtent *
                            720 -
                        int.parse((scrollController.offset /
                                    scrollController.position.maxScrollExtent *
                                    720 /
                                    60)
                                .toStringAsFixed(0)) *
                            60))
                .toStringAsFixed(0) +
            "m");
      } else {
        time = (((scrollController.offset /
                        scrollController.position.maxScrollExtent *
                        720 /
                        60)
                    .floor())
                .toStringAsFixed(0) +
            'h ' +
            (scrollController.offset /
                        scrollController.position.maxScrollExtent *
                        720 -
                    int.parse((scrollController.offset /
                                scrollController.position.maxScrollExtent *
                                720 /
                                60)
                            .toStringAsFixed(0)) *
                        60)
                .toStringAsFixed(0) +
            "m");
      }
    } else {
      time = (scrollController.offset /
                  scrollController.position.maxScrollExtent *
                  720)
              .toStringAsFixed(0) +
          "m";
    }
    update();
  }

  toggleemergencymode() {
    isemergencymode = !isemergencymode;
    update();
  }

  void _save(DailyClassModel dailyClassModel) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (dailyClassModel.id != null) {
      // Case 1: Update operation
      result = await dailyClassdbHelper.updateClass(dailyClassModel);
    } else {
      // Case 2: Insert Operation
      result = await dailyClassdbHelper.insertClass(dailyClassModel);
    }

    if (result != 0) {
      // Success
      print('Note Saved Successfully');
    } else {
      // Failure
      print('Problem Saving Note');
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
