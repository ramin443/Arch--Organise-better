import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/getxcontrollers/onboardingcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainOnBoarding extends StatelessWidget {
  const MainOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    return GetBuilder<OnBoardingController>(
    init: OnBoardingController(),
      builder:(onboardingcontroller){
        return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(top: 6,),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Container(

                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.5,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/leaf.svg",
                                //    width: 28,
                                width: screenwidth*0.0654,
                              ),
                              Container(
                                //             margin: EdgeInsets.only(left: ),
                                child: Text(
                                  "Arch",
                                  style: TextStyle(
                                    fontFamily: sfproroundedmedium,
                                    color: Colors.black,
                                    //       fontSize: 28
                                    fontSize: screenwidth*0.0654, ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:EdgeInsets.only(left: 8,top: 2),
                              child: Text("Organise Better.",style: TextStyle(
                                  fontFamily: sfproroundedsemibold,
                                  color: Color(0xff006EE9),
                                  fontSize: 19.5
                              ),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  AnimatedSwitcher(duration: Duration(milliseconds: 150),

                  child:
                      onboardingcontroller.pageindex==0?
                  onboardingcontroller.slide2(context):onboardingcontroller.slide3(context)),
              onboardingcontroller.slideinfo(context),
              onboardingcontroller.nextbutton(context),


            ],
          ),
        ),
      );});

  }
}
