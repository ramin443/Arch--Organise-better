import 'package:archorganisebetter/getxcontrollers/basecontroller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Base extends StatelessWidget {
  const Base({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return
      GetBuilder<BaseController>(
          init: BaseController(),
          builder: (basecontroller){
            return
              Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: Container(
                  //  height: 91,
                //  height: screenwidth*0.233,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, -6),
                            color: Color(0x0000000D),
                            blurRadius: 25)
                      ],
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: BottomNavigationBar(
                    onTap: (index){
                      basecontroller.setindex(index);
                    },
                    iconSize:  screenwidth*0.0583,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: basecontroller.currentindex,
                    items: [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          title: Text(""),    icon:
                      basecontroller.currentindex==0?
                      SvgPicture.asset("assets/selectedhome.svg",
              //          width: 23,
                          width:screenwidth*0.0589
                      ):
                      SvgPicture.asset("assets/home.svg",
                 //       width: 23,
                      width:screenwidth*0.0589
                      )),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          title: basecontroller.currentindex==1?Container(
//                            width: 10,height: 12,
                            width: screenwidth*0.0256,height: screenwidth*0.0307,
                            decoration: BoxDecoration(
                                color: Color(0xff006EFF),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ):Container(
        //                    width: 10,height: 12,
                            width: screenwidth*0.0256,height: screenwidth*0.0307,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),   icon: SvgPicture.asset(
                        basecontroller.currentindex==1?
                        "assets/selectedtaskicon.svg":
                        "assets/unselectedtasks.svg",
            //            width: 23,
                          width:screenwidth*0.0589
                        //   color: Colors.black,
                      )),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          title: Text(""),    icon: SvgPicture.asset(
                        basecontroller.currentindex==2?
                        "assets/selectedlisticon.svg":
                        "assets/unselectedlists.svg",
                      //  width: 24,
                        width: screenwidth*0.0615,
                        //   color: Colors.black,
                      )),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          title: Text(""),    icon: SvgPicture.asset(
                        basecontroller.currentindex==3?
                        "assets/selectedpreferences.svg":
                        "assets/unselectedpreferences.svg",
                //        width: 24,
                        width: screenwidth*0.0615,
                        //   color: Colors.black,
                      )),
                    ],
                  ),
                ),
                body: basecontroller.children[basecontroller.currentindex],

              );});
  }
}
