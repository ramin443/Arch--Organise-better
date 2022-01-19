import 'dart:convert';

import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:archorganisebetter/getxcontrollers/taskscontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quiver/time.dart';
import 'package:sqflite/sqflite.dart';

import 'homecontroller.dart';

class ProductivityHome extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  DateTime now = new DateTime.now();

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
        initState: (v) {
          homeController.addascrolllistener();
          homeController.settodaysdate();
          homeController.animtetospecifieddate(20, 30);
          homeController.updatecurrrentselecteddaylistvew(
              DateFormat.yMMMd().format(DateTime.now()));
        },
        init: HomeController(),
        builder: (homecontroller) {
          return GetBuilder(
              initState: (v) {},
              init: TaskController(),
              builder: (taskscontroller) {
                return Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                  floatingActionButton:
                  GestureDetector(
                    onTap: (){
                      homecontroller.showbottomsheettoadd(context);
               //       homecontroller.showexample(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
//                          right: 12,bottom: 12
                          right: screenwidth*0.0307,bottom: screenwidth*0.0307
                      ),
//                      height: 42, width: 42,
                      height: screenwidth*0.107, width: screenwidth*0.107,
                      decoration: BoxDecoration(
                        color: Color(0xff006EFF),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.16),blurRadius: 6,offset: Offset(0,3))],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(CupertinoIcons.add,
                          color: Colors.white,
                      //    size: 34,
                        size: screenwidth*0.087,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    brightness: Brightness.light,
                    leading: IconButton(
                      onPressed: (){
                        homecontroller.save(DailyClassModel("Programming in C and C++",
                            "SCC Hall 1 Hall 2", "Jan 5, 2022",
                            "14:15", "15:30"));
                        homecontroller.updatecurrrentselecteddaylistvew(
                            DateFormat.yMMMd('en_US').format(DateTime.now()));
                      },
                      icon: Icon(Ionicons.apps,
                      color:Color(0xffA6AEB9),
                //      size: 19,
                  size:screenwidth*0.0487,    ),
                    ),

                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Container(
                //      margin: EdgeInsets.only(left: 18),
                          child: SvgPicture.asset("assets/leaf.svg",
                      //    width: 25,
                        width: screenwidth*0.0641,  )
                        ),
                        Container(
                          margin: EdgeInsets.only(
//                              right: 14
                              right: screenwidth*0.0358
                          ),
                          child: Text("Arch",style: TextStyle(
                            fontFamily: sfproroundedmedium,
                            color: Colors.black,
                        //    fontSize: 24
                              fontSize: screenwidth*0.0615
                          ),),
                        )
                      ],
                    ),
                    actions: [
                      IconButton(onPressed: ()
                      async{
                   homecontroller.showbottomsheettoadd(context);
                      }, icon: Icon(
                        CupertinoIcons.add,
                        color: Colors.black87,
                   //     size: 24,
                     size: screenwidth*0.0615
                        , ))
                    ],
                    automaticallyImplyLeading: false,
                  ),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.only(bottom: screenwidth*0.0461),
                      width: screenwidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        /*  Container(
                            margin: EdgeInsets.symmetric(horizontal: screenwidth*0.0461),
                            child: Text(
                              "Hi, Alida",
                              style: TextStyle(
                                  fontFamily: sfproroundedsemibold,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                   //               fontSize: 24
                                  fontSize: screenwidth*0.0615
                              ),
                            ),
                          ),*/
                          Container(
                            margin: EdgeInsets.only(
                             //   top: 9, bottom: 24,
                               top: screenwidth*0.0230,bottom: screenwidth*0.0315,
                       //         left: 18, right: 18
                                left: screenwidth*0.0461, right: screenwidth*0.0461
                            ),
                            width: screenwidth,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        homecontroller.animtetospecifieddate(
                                            int.parse(
                                              DateFormat.d('en_US').format(DateTime.now())
                                            ),
                                           // (index + 1),
                                            (daysInMonth(
                                                int.parse(DateFormat
                                                    .y('en_US')
                                                    .format(DateTime
                                                    .now())),
                                                int.parse(DateFormat
                                                    .M('en_US')
                                                    .format(DateTime
                                                    .now())))
                                            ));
                                        homecontroller
                                            .setcurrentdate(
                                            int.parse(
                                                DateFormat.d('en_US').format(DateTime.now())
                                            )
                                        );
                                        homecontroller.getdatafromaspecificdate(
                                            int.parse(
                                                DateFormat.d('en_US').format(DateTime.now())
                                            ));
                                      },
                                      child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontFamily: sfproroundedregular,
                                                color: Colors.black,
//                                                fontSize: 24,
                                                fontSize: screenwidth*0.0615,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: "Today  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: sfproroundedsemibold,
                                                color: Color(0xff006EFF),
                                           //     fontSize: 24,
                                                fontSize: screenwidth*0.0615,
                                              ),
                                            ),
                                            TextSpan(
                                              text: DateFormat.yMMMd('en_US')
                                                  .format(DateTime.now()),
                                            ),
                                          ])),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: screenwidth*0.0461,
                                    bottom: screenwidth*0.0243),
                                child: Text(
                                  DateFormat('MMMM').format(DateTime.now()),
                                  style: TextStyle(
                                    fontFamily: sfprotextregular,
                                      fontSize: screenwidth*0.032,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                           //     bottom: 18
                            bottom: screenwidth*0.0461
                            ),
                            child: LimitedBox(
                              maxHeight: screenwidth*0.138,
                              child: ListView.builder(
                                  controller: homecontroller.scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: daysInMonth(
                                      int.parse(DateFormat.y('en_US')
                                          .format(DateTime.now())),
                                      int.parse(DateFormat.M('en_US')
                                          .format(DateTime.now()))),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        homecontroller.animtetospecifieddate(
                                            (index + 1),
                                            (daysInMonth(
                                                int.parse(DateFormat
                                                    .y('en_US')
                                                    .format(DateTime
                                                    .now())),
                                                int.parse(DateFormat
                                                    .M('en_US')
                                                    .format(DateTime
                                                    .now())))
                                        ));
                                        homecontroller
                                            .setcurrentdate(index + 1);
                                        homecontroller.getdatafromaspecificdate(
                                            index + 1);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: index == 0 ? 8 : 0,
                                            right: index ==
                                                    (daysInMonth(
                                                            int.parse(DateFormat
                                                                    .y('en_US')
                                                                .format(DateTime
                                                                    .now())),
                                                            int.parse(DateFormat
                                                                    .M('en_US')
                                                                .format(DateTime
                                                                    .now()))) -
                                                        1)
                                                ? 8
                                                : 0),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: screenwidth*0.0179,
                                          ),
                                     //     width: 38,
                                       width: screenwidth*0.0974,height:screenwidth*0.1384,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  DateFormat('EEEE')
                                                      .format(DateTime(
                                                          int.parse(DateFormat
                                                                  .y('en_US')
                                                              .format(DateTime
                                                                  .now())),
                                                          int.parse(DateFormat
                                                                  .M('en_US')
                                                              .format(DateTime
                                                                  .now())),
                                                          (index + 1)))
                                                      .substring(0, 3),
                                                  style: TextStyle(
                                                      fontFamily: sfprotextregular,
                                                      color: homecontroller
                                                                  .currentdate !=
                                                              (index + 1)
                                                          ? Color(0xff797979)
                                                          : Color(0xff006EFF),
                                                  //    fontSize: 11.5,
                                                    fontSize: screenwidth*0.0294,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Container(
//                                                width: 37, height: 37,
                                                width: screenwidth*0.0948, height:  screenwidth*0.0948,
                                                decoration: BoxDecoration(
                                                  color: homecontroller
                                                                  .currentdate !=
                                                              (index + 1) &&
                                                          now.day == (index + 1)
                                                      ? Color(0xff797979)
                                                          .withOpacity(0.40)
                                                      : homecontroller
                                                                  .currentdate !=
                                                              (index + 1)
                                                          ? Colors.transparent
                                                          : Color(0xff006EFF),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: TextStyle(
                                                          fontFamily: sfproroundedregular,
                                                          fontSize: screenwidth*0.0384,
                                                          color: homecontroller
                                                                          .currentdate !=
                                                                      (index +
                                                                          1) &&
                                                                  now.day ==
                                                                      (index +
                                                                          1)
                                                              ? Colors.white
                                                              : homecontroller
                                                                          .currentdate !=
                                                                      (index +
                                                                          1)
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          homecontroller.dailyclasseslist==null?
                              SizedBox(height: 0,):
                          homecontroller.dailyclasseslist!.length==0?
                              SizedBox(height: 0,):
                          homecontroller.dailyclasseslist!
                          [homecontroller.dailyclasseslist!.length-1].date!=
                          DateFormat.yMMMd('en_US').format(DateTime.now())?
                          SizedBox(height: 0,):
                          int.parse(homecontroller.dailyclasseslist!
                          [homecontroller.dailyclasseslist!.length-1].endtime
                          !.substring(0,2))<
                      int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                          dailycompletion(context):
                          int.parse(homecontroller.dailyclasseslist!
                          [homecontroller.dailyclasseslist!.length-1].endtime
                          !.substring(0,2))==
                              int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                          int.parse(homecontroller.dailyclasseslist!
                          [homecontroller.dailyclasseslist!.length-1].endtime
                          !.substring(3,5))<
                         int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                          dailycompletion(context):
                          SizedBox(height: 0,)
                              :SizedBox(height: 0,),
                          homecontroller.dailyclasseslist!=null
                          && homecontroller.dailyclasseslist!.length==0?
                          classesemptydtate(context):
                          ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: homecontroller.dailyclasseslist != null
                                ? homecontroller.dailyclasseslist!.length
                                : 0,
                            itemBuilder: (context, index) {
                              return Column(children: [
                                singleclass(context,
                                    homecontroller.dailyclasseslist![index]),
                                index ==
                                        homecontroller
                                                .dailyclasseslist!.length -
                                            1
                                    ? SizedBox(
                                        height: 0,
                                      )
                                    : dottedareas(context)
                              ]);
                            },
                          ),
                          //       SfCalendar(
                          //       view:homecontroller.yourmom==''? CalendarView.timelineWorkWeek:
                          //     homecontroller.yourmom=='week'?
                          //   CalendarView.timelineWeek:
                          //   homecontroller.yourmom=='month'?
                          //     CalendarView.timelineMonth: CalendarView.schedule, onTap: (a){},),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
  Widget dailycompletion(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return    Container(
      margin: EdgeInsets.only(
         // left: 18, right: 18, bottom: 14
          right: screenwidth*0.0461,left:screenwidth*0.0461,
        bottom: screenwidth*0.0358
      ),
      width: screenwidth,
   //   height: 52,
     height: screenwidth*0.133, padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0256),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(9)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: Offset(0, 2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
//            height: 30, width: 30,
            height: screenwidth*0.0769, width: screenwidth*0.0769,
            decoration: BoxDecoration(
                color: Color(0xff5AB898),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff5AB898)
                          .withOpacity(0.37),
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ]),
            child: Center(
              child: Icon(
                CupertinoIcons.checkmark_alt,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:  screenwidth*0.0256),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontFamily: sfprotextregular,
                      color: Colors.black,
                      fontSize: screenwidth*0.0358),
                  children: [
                    TextSpan(
                        text: "Congrats, ",
                        style: TextStyle(
                            fontFamily:
                            sfproroundedsemibold,
                            color: Color(0xff717386),
                            fontSize: screenwidth*0.0358)),
                    TextSpan(
                        text:
                        "Looks like you’re done for the day")
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget noclassesyet(BuildContext context) {
    return Container();
  }

  Widget singleclass(BuildContext context, DailyClassModel dailyClassModel) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenwidth*0.0461
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  child: Icon(
                    dailyClassModel.date!=
                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                    CupertinoIcons.circle:
                    int.parse(dailyClassModel.starttime!.substring(0,2))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    CupertinoIcons.checkmark_alt_circle_fill:
                    int.parse(dailyClassModel.starttime
                    !.substring(0,2))==
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    int.parse(dailyClassModel.starttime
                    !.substring(3,5))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                    CupertinoIcons.checkmark_alt_circle_fill:
                    CupertinoIcons.circle:CupertinoIcons.circle,
//                    CupertinoIcons.checkmark_alt_circle_fill
                    //       :CupertinoIcons.circle
             //       size: 14.5,
               size: screenwidth*0.0371,
                    color:
                    dailyClassModel.date!=
                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                    Colors.black:
                    int.parse(dailyClassModel.starttime!.substring(0,2))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    Color(0xff006EFF):
                    int.parse(dailyClassModel.starttime
                    !.substring(0,2))==
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    int.parse(dailyClassModel.starttime
                    !.substring(3,5))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                    Color(0xff006EFF):
                    Colors.black:Colors.black,
                    // :Colors.black

                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
           //         left: 10.5
             left: screenwidth*0.0269   ),
                child: Text(
                  dailyClassModel.starttime.toString(),
                  style: TextStyle(
                      fontFamily: sfprotextregular,
                      color: Colors.black,
             //         fontSize: 11.5
                    fontSize: screenwidth*0.0294,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 13 / 2),
                height: 110,
                width: 1,
                decoration: BoxDecoration(
                    color:    dailyClassModel.date!=
                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                    Colors.black:
                    int.parse(dailyClassModel.starttime!.substring(0,2))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?

                    Color(0xff006EFF):
                    int.parse(dailyClassModel.starttime
                    !.substring(0,2))==
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    int.parse(dailyClassModel.starttime
                    !.substring(3,5))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                    Color(0xff006EFF):
                    Colors.black:Colors.black,
                    //Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              GestureDetector(
                onTap: () {
                  homeController.showbottomsheetfordailyroutine(dailyClassModel,
                      context);
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(left:  screenwidth*0.0384),
                  height: 84,
                  width: screenwidth * 0.535,
                  decoration: BoxDecoration(
                      color:  dailyClassModel.date!=
                          DateFormat.yMMMd('en_US').format(DateTime.now())?
                      Colors.white:
                      int.parse(dailyClassModel.endtime!.substring(0,2))<
                          int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?

                      Color(0xff006EFF):
                      int.parse(dailyClassModel.endtime
                      !.substring(0,2))==
                          int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                      int.parse(dailyClassModel.endtime
                      !.substring(3,5))<
                          int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?

                      Color(0xff006EFF):
                      Colors.white:Colors.white,
                      //Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.07))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                fontFamily: sfprotextregular,
                                color:
                                dailyClassModel.date!=
                                    DateFormat.yMMMd('en_US').format(DateTime.now())?
                                Colors.black:
                                int.parse(dailyClassModel.endtime!.substring(0,2))<
                                    int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                Colors.white:
                                int.parse(dailyClassModel.endtime
                                !.substring(0,2))==
                                    int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                int.parse(dailyClassModel.endtime
                                !.substring(3,5))<
                                    int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                                Colors.white:
                                Colors.black:Colors.black
                                ,
//                                fontSize: 13.5,
                                fontSize: screenwidth*0.0346,
                              ),
                              children: [
                                TextSpan(
                                  text: "CH230B-  ",
                                ),
                                TextSpan(
                                  text: dailyClassModel.classtitle,
                                  style: TextStyle(
                                    fontFamily: sfprotextsemibold,
                                    color:    dailyClassModel.date!=
                                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                                    Colors.black:
                                    int.parse(dailyClassModel.endtime!.substring(0,2))<
                                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                    Colors.white:
                                    int.parse(dailyClassModel.endtime
                                    !.substring(0,2))==
                                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                    int.parse(dailyClassModel.endtime
                                    !.substring(3,5))<
                                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                                    Colors.white:
                                    Colors.black:Colors.black
                                    ,
                                    //Color(0xff5A59A0),
                                    fontSize: screenwidth*0.0346,
                                  ),
                                ),
                              ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              dailyClassModel.classlocation.toString(),
                              style: TextStyle(
                                  fontFamily: sfprotextregular,
                                  color:    dailyClassModel.date!=
                                      DateFormat.yMMMd('en_US').format(DateTime.now())?
                                  Colors.black:
                                  int.parse(dailyClassModel.endtime!.substring(0,2))<
                                      int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                  Colors.white:
                                  int.parse(dailyClassModel.endtime
                                  !.substring(0,2))==
                                      int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                                  int.parse(dailyClassModel.endtime
                                  !.substring(3,5))<
                                      int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                                  Colors.white:
                                  Colors.black:Colors.black
                                  ,
                                  //Colors.black,
                          //        fontSize: 10.5
                            fontSize:  screenwidth*0.0269   ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  child: Icon(
                    dailyClassModel.date!=
                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                    CupertinoIcons.circle:
                    int.parse(dailyClassModel.endtime!.substring(0,2))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    CupertinoIcons.checkmark_alt_circle_fill:
                    int.parse(dailyClassModel.endtime
                    !.substring(0,2))==
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    int.parse(dailyClassModel.endtime
                    !.substring(3,5))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                    CupertinoIcons.checkmark_alt_circle_fill:
                    CupertinoIcons.circle:CupertinoIcons.circle,
            //        size: 14.5,
                    size: screenwidth*0.0371,
                    color:
                    dailyClassModel.date!=
                        DateFormat.yMMMd('en_US').format(DateTime.now())?
                    Colors.black:
                    int.parse(dailyClassModel.endtime!.substring(0,2))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    Color(0xff006EFF):
                    int.parse(dailyClassModel.endtime
                    !.substring(0,2))==
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(0,2))?
                    int.parse(dailyClassModel.endtime
                    !.substring(3,5))<
                        int.parse(DateFormat.Hm('en_US').format(DateTime.now()).substring(3,5))?
                    Color(0xff006EFF):
                    Colors.black:Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
              //      left: 10.5
                left:  screenwidth*0.0269 ),
                child: Text(

                  dailyClassModel.endtime.toString(),
                  style: TextStyle(
                      fontFamily: sfprotextregular,
                      color: Colors.black,
            //          fontSize: 11.5
                    fontSize: screenwidth*0.0294,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget dottedareas(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              width: 1,
              height: 4.24,
              margin: EdgeInsets.only(
                  top: 2, bottom: index == 2 ? 2 : 0, left: 13 / 2 + screenwidth*0.0461),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ],
        );
      },
    );
  }
  Widget classesemptydtate(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
//          top: 45
          top: screenwidth*0.115
      ),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: SvgPicture.asset("assets/Group 507.svg",
                width: screenwidth*0.425,),
          ),
          Container(
            margin: EdgeInsets.only(
//                top: 32,bottom: 11
                top: screenwidth*0.082,bottom: screenwidth*0.0282
            ),
            child: Text("No classes today yet",
              textAlign: TextAlign.center,
              style: TextStyle(
              fontFamily: sfprotextsemibold,
              fontSize: screenwidth*0.0487,
              color: Colors.black,
            ),),
          ),
          Container(
            child: Text("Press the + button to add new classes/ events\n"
              "to your routine or import your class schedule\n"
              "from Campus Net from the settings tab\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: sfprotextmedium,
//                fontSize: 12.5,
                fontSize:screenwidth*0.0320,
                color: Color(0xff949DA5),
              ),),
          ),
          Container(
//            height: 35,width: 178,
            height: screenwidth*0.0897,width: screenwidth*0.456,
            margin: EdgeInsets.only(
//                top: 5
             top: screenwidth*0.0128
            ),
       //     padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff4A84F7),
                  Color(0xff3565FC)
                ]
              )
            ),
            child: Center(
              child: Text("Import from CampusNet",
              style: TextStyle(
                fontFamily: sfprotextmedium,
                color: Colors.white,
 //               fontSize: 12.5
                fontSize:screenwidth*0.0320,
              ),),
            ),
          )
        ],
      ),
    );
  }
  Widget routineemptystate(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/3973481.jpg",
              width: 257,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 17),
            child: Text(
              "A little empty here.\nAdd classes, events to your routine now",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize:  screenwidth*0.0384,
                  color: Colors.black,
                  fontFamily: sfproroundedmedium),
            ),
          ),
          GestureDetector(
            onTap: (){
              homeController.showbottomsheettoadd(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth*0.0346),
        //      width: 160,
          width: screenwidth*0.410,
              padding: EdgeInsets.symmetric(
//                  vertical: 9,horizontal: 7
                  vertical: screenwidth*0.0230,horizontal: screenwidth*0.0179
              ),
              decoration: BoxDecoration(
                color: Color(0xff006EFF),
                borderRadius: BorderRadius.all(Radius.circular(7.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                   margin: EdgeInsets.only(
          //             right: 7.5
            right: screenwidth*0.0192       ),
                    child: Text(
                      "Add to your routine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenwidth*0.0346,
                          color: Colors.white,
                          fontFamily: sfproroundedmedium),
                    ),
                  ),
                  Container(
                    child: Icon(
                      CupertinoIcons.plus,
                      color: Colors.white,
                      size: screenwidth*0.0397,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  checkfirebaseconnectivity() async {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection("newone")
        .add({"test": "succesful"});
  }

  testthejson() {
    String testjson =
        '{"id":"1","classtitle":"CH232A","classlocation":"SCC Hall 1",'
        '"date":"September 3'
        '","time":"14:15"}';
    Map<String, dynamic> response = jsonDecode(testjson);
    TestModel testModel = TestModel.fromJson(response);
    print("Class title is:" + testModel.classtitle.toString());
  }

  /*getdatafromcampusnet() async {
    final url = '$baseUrl/api/login';
    var response = await locator<ApiService>().campusnetlogin();
    print("Response is:" + response.toString());
  }*/
}

class TestModel {
  String? id;
  String? classtitle, classlocation, date, time;

  TestModel(
      {this.id, this.classtitle, this.classlocation, this.date, this.time});

  factory TestModel.fromJson(Map<String, dynamic> data) {
    var productdetails = TestModel(
        id: data["id"],
        classtitle: data["classtitle"],
        classlocation: data["classlocation"],
        date: data["date"],
        time: data["time"]);
    return productdetails;
  }
}
