import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:flutter/material.dart';
class Preferences extends StatelessWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Preferences",style: TextStyle(
          fontFamily: sfproroundedmedium,
          color: Colors.black,
          fontSize: 15.5
        ),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }
}
