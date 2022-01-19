import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  int pageindex=0;

  setpageindex(int index){
    pageindex=index;
    update();
  }
  void reorderData(int oldindex, int newindex){
      if(newindex>oldindex){
        newindex-=1;
      }
   //   final items =widget.item.removeAt(oldindex);
     // widget.item.insert(newindex, items);
  update();
  }
  Widget slide3(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      key: Key("onboardingswitcher"),
      margin: EdgeInsets.only(
        //       top: 56
          top: screenwidth*0.1508 ),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/4197677.jpg",
              width: screenwidth*0.647,),
          ),
          Container(
            child: Text("Teamwork",style: TextStyle(
                fontFamily: sfproroundedmedium,
                color: Colors.black,
                //     fontSize: 21.5
                fontSize: screenwidth*0.0502 ),),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0303),
            child: Text("Collaborate with friends, teams, and groups\n"
                "and manage projects, assign tasks, check status, and\n"
                "plan ahead",
              textAlign:TextAlign.center,
              style: TextStyle(
                  fontFamily: sfproroundedregular,
                  color: Color(0xff6E6E6E),
                  //        fontSize: 15.5
                  fontSize: screenwidth*0.0362
              ),),
          ),

        ],
      ),
    );
  }
  Widget slide2(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      key: Key("onboardingswitcher"),
      margin: EdgeInsets.only(
   //       top: 56
     top: screenwidth*0.1508 ),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/3411092.jpg",
            width: screenwidth*0.647,),
          ),
          Container(
            child: Text("Task Management",style: TextStyle(
              fontFamily: sfproroundedmedium,
              color: Colors.black,
         //     fontSize: 21.5
           fontSize: screenwidth*0.0502 ),),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.0303),
            child: Text("Collaborate with friends, teams, and groups\n"
    "and manage projects, assign tasks, check status, and\n"
    "plan ahead",
              textAlign:TextAlign.center,
              style: TextStyle(
                fontFamily: sfproroundedregular,
                color: Color(0xff6E6E6E),
        //        fontSize: 15.5
                fontSize: screenwidth*0.0362
            ),),
          ),

        ],
      ),
    );
  }
  Widget slideinfo(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
   //       top: 35
     top: screenwidth*0.0817 ),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            margin: EdgeInsets.only(
        //        left: 4
          left: screenwidth*0.00934  ),
            duration: Duration(milliseconds: 200),
         //   height: 4,
           height: screenwidth*0.00934, width: pageindex==0?20:4,
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
          ), AnimatedContainer(
            margin: EdgeInsets.only(
       //         left: 4
         left: screenwidth*0.00934   ),
            duration: Duration(milliseconds: 200),
        //    height: 4,
          height: screenwidth*0.00934,
            width: pageindex==1?screenwidth*0.0467: screenwidth*0.00934,
            decoration: BoxDecoration(
              color: Color(0xffBFBFBF),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(
         //       left: 4
           left: screenwidth*0.00934 ),
            duration: Duration(milliseconds: 200),
       //    height: 4,
         height: screenwidth*0.00934,
            width: pageindex==2?screenwidth*0.0467: screenwidth*0.00934,
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
          ),
        ],
      ),

    );
  }
  Widget nextbutton(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        setpageindex(pageindex+1);
      },
      child: Container(
        width: screenwidth,
        margin: EdgeInsets.only(
          //       top: 56
            top: screenwidth*0.1408 ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenwidth*0.574,
               //   height: 35,
                  height: screenwidth*0.0817,
                  decoration: BoxDecoration(
                    color: Color(0xff006EFF),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Center(
                    child: Container(
                      child: Text("Next",style: TextStyle(
                        fontFamily: sfproroundedregular,
                        color: Colors.white,
//                      fontSize: 14.5
                          fontSize:screenwidth*0.0338
                      ),),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                top: 35,left: 27
                  top: screenwidth*0.0817,left: screenwidth*0.0630
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Skip",style: TextStyle(
                    fontFamily: sfproroundedregular,
//                  fontSize: 15.5,
                      fontSize: screenwidth*0.0362,
                      color: Color(0xff6A6A6A)
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}