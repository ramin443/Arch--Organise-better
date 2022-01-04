import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool changescreen=false;
  @override
  initState() {
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight=MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(
            milliseconds: 1200
        ),
        width: screenwidth,
        height: screenheight,
        decoration: BoxDecoration(
            color: changescreen?Color(0xff006EFF):
            Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: changescreen?Image.asset(
              "assets/bluebg.png",
                width: screenwidth*0.29,):
              Image.asset("assets/whitelogobg.png",
                width:  screenwidth*0.29,),
            ),
          ],
        ),
      ),
    );
  }
  startTime() async {
    var _duration = new Duration(seconds: 5);
    Future.delayed(Duration(milliseconds: 1000),changecolor);
    return new Timer(_duration, navigationPage);
  }
   changecolor(){
    setState(() {
      changescreen=true;
    });
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Base');
  }
}
