import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/dailyclassmodel.dart';
import 'package:archorganisebetter/getxcontrollers/homecontroller.dart';
import 'package:archorganisebetter/getxcontrollers/routinecontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class AddtoyourRoutine extends StatelessWidget {
  AddtoyourRoutine({Key? key}) : super(key: key);

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return GetBuilder<RoutineController>(
        init: RoutineController(),
        builder: (addtoroutinecontroller) {
          return GetBuilder<HomeController>(
              init: HomeController(),
              builder: (homecontroller) {
                return Container(
                  padding: EdgeInsets.symmetric(
//          horizontal: 22,vertical: 12
                      horizontal: screenwidth * 0.0535,
                      vertical: screenwidth * 0.0291),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Add to your calendar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: sfprosemibold,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
//                    fontSize: 14.5
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        width: screenwidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Class title",
                                    style: TextStyle(
                                        fontSize: 11.5, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.only(top: 6, bottom: 12),
                              //    padding: EdgeInsets.all(4),
                              width: screenwidth,
                              height: 30,
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
                                  controller: titlecontroller,
                                  style: TextStyle(fontSize: 12.5),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Location( optional)",
                                    style: TextStyle(
                                        fontSize: 11.5, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: EdgeInsets.only(top: 6, bottom: 12),
                              //    padding: EdgeInsets.all(4),
                              width: screenwidth,
                              height: 30,
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
                                  controller: locationcontroller,
                                  style: TextStyle(fontSize: 12.5),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 12.5,
                                        color: Colors.grey[600]),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenwidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 4, bottom: 7),
                                          child: Text(
                                            "Is this a recurring Event?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontSize: 11.5),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            addtoroutinecontroller
                                                .setrecurringevent();
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 350),
                                            height: 24,
                                            width: 45,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.4, vertical: 2.4),
                                            decoration: BoxDecoration(
                                                color: addtoroutinecontroller
                                                        .recurringevent
                                                    ? Color(0xff006EFF)
                                                    : Color(0xffD9D9D9),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(13))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  addtoroutinecontroller
                                                          .recurringevent
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            !addtoroutinecontroller.recurringevent
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Container(
                                    width: screenwidth,
                                    margin: EdgeInsets.only(
                                        top: 15.5, bottom: 14.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              addtoroutinecontroller
                                                  .setrecurringtoeveryday();
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 14.5,
                                                    width: 14.5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: addtoroutinecontroller
                                                                    .typeofrecurringevent ==
                                                                0
                                                            ? Color(0xff006EFF)
                                                            : Colors
                                                                .transparent,
                                                        border: addtoroutinecontroller
                                                                    .typeofrecurringevent !=
                                                                0
                                                            ? Border.all(
                                                                color: Color(
                                                                    0xff555555))
                                                            : Border.all(
                                                                width: 0,
                                                                color: Colors
                                                                    .transparent)),
                                                    child: addtoroutinecontroller
                                                                .typeofrecurringevent ==
                                                            0
                                                        ? Center(
                                                            child: Container(
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .checkmark_alt,
                                                                color: Colors
                                                                    .white,
                                                                size: 9.5,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 0,
                                                          ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.5),
                                                    child: Text(
                                                      "Everyday",
                                                      style: TextStyle(
                                                          fontSize: 11.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              addtoroutinecontroller
                                                  .setrecurringtoweekdays();
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 14.5,
                                                    width: 14.5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: addtoroutinecontroller
                                                                    .typeofrecurringevent ==
                                                                1
                                                            ? Color(0xff006EFF)
                                                            : Colors
                                                                .transparent,
                                                        border: addtoroutinecontroller
                                                                    .typeofrecurringevent !=
                                                                1
                                                            ? Border.all(
                                                                color: Color(
                                                                    0xff555555))
                                                            : Border.all(
                                                                width: 0,
                                                                color: Colors
                                                                    .transparent)),
                                                    child: addtoroutinecontroller
                                                                .typeofrecurringevent ==
                                                            1
                                                        ? Center(
                                                            child: Container(
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .checkmark_alt,
                                                                color: Colors
                                                                    .white,
                                                                size: 9.5,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 0,
                                                          ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.5),
                                                    child: Text(
                                                      "Some weekdays",
                                                      style: TextStyle(
                                                          fontSize: 11.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            addtoroutinecontroller
                                                .setrecurringtocustomdate();
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 14.5,
                                                  width: 14.5,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: addtoroutinecontroller
                                                                  .typeofrecurringevent ==
                                                              2
                                                          ? Color(0xff006EFF)
                                                          : Colors.transparent,
                                                      border: addtoroutinecontroller
                                                                  .typeofrecurringevent !=
                                                              2
                                                          ? Border.all(
                                                              color: Color(
                                                                  0xff555555))
                                                          : Border.all(
                                                              width: 0,
                                                              color: Colors
                                                                  .transparent)),
                                                  child: addtoroutinecontroller
                                                              .typeofrecurringevent ==
                                                          2
                                                      ? Center(
                                                          child: Container(
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .checkmark_alt,
                                                              color:
                                                                  Colors.white,
                                                              size: 9.5,
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 0,
                                                        ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5.5),
                                                  child: Text(
                                                    "Custom Date",
                                                    style: TextStyle(
                                                        fontSize: 11.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                      ),
                      !addtoroutinecontroller.recurringevent
                          ? SizedBox(
                              height: 0,
                            )
                          : addtoroutinecontroller.typeofrecurringevent == 0
                              ? addtoroutinecontroller.everydayoptions(context):
                      addtoroutinecontroller.typeofrecurringevent == 1? 
                      addtoroutinecontroller.weekdayoptions(context):
                      addtoroutinecontroller.customdateoptions(context),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Color(0xff006EFF),
                                    fontSize: 14.5,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homecontroller.save(DailyClassModel(
                                    titlecontroller.text,
                                    locationcontroller.text,
          //                          datecontroller.text,
                                    DateFormat.yMMMd('en_US').format(DateTime.now()),
                                    starttimecontroller.text,
                                    endtimecontroller.text));
                                homecontroller.updatecurrrentselecteddaylistvew(
                                    DateFormat.yMMMd('en_US').format(DateTime.now()));
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
