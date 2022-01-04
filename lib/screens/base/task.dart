import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/TaskModel.dart';
import 'package:archorganisebetter/getxcontrollers/taskscontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPage extends StatelessWidget {
   TaskPage({Key? key}) : super(key: key);
  final TaskController taskController =
  Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    double screenwidth= MediaQuery.of(context).size.width;
    double screenheight= MediaQuery.of(context).size.height;
    return GetBuilder<TaskController>(
      initState: (v){
        taskController.updateincompletetaskistView();
        taskController.updatecompletetaskistView();
        if (taskController.allincompletetaskslist == null) {
          List<TaskModel>a=[];
          taskController.allincompletetaskslist =a;
        }
        if (taskController.allcompletetaskslist == null) {
          List<TaskModel>a=[];
          taskController.allcompletetaskslist =a;
        }
      },
        init: TaskController(),
        builder: (taskcontroller) {
          return
            Scaffold(
              appBar:   AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                centerTitle: true,
                title: Container(
                  child:Text("Your Tasks",style: TextStyle(
                      color: Colors.black,
                      fontFamily: sfpromedium,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.5
                  ),),
                ),
                actions: [
                  PopupMenuButton(
                      tooltip: 'Menu',
                      child:  GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(right: 18),
                        child: Icon(CupertinoIcons.ellipsis_circle,
                          color: Colors.black87,
                          size: 20.5,),
                      ),),
                      itemBuilder: (context)=>[

                        PopupMenuItem(
                          child: GestureDetector(
                            onTap:(){
                              taskcontroller.deleteallcompletedtasks();
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Icon(
                                   CupertinoIcons.printer_fill,
                                    color: Colors.black.withOpacity(0.56),
                                    size: 18.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },  child: Icon(
                                    Icons.share,
                                    color: Colors.black.withOpacity(0.56),
                                    size: 18.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    CupertinoIcons.xmark_circle_fill,
                                    color: Colors.black.withOpacity(0.56),
                                    size: 19.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                      child: GestureDetector(
                        onTap:(){
                      taskcontroller.deleteallcompletedtasks();
                      Navigator.pop(context);
                    },
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.black.withOpacity(0.61),
                              size: 18.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text(
                                "Clear completed tasks",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.61),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),

                ],
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                width: screenwidth,
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0xffFAFAFA)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 36,
                      width: screenwidth*0.816,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: Color(0xffE3E3E3),width: 1),

                      ),
                      child: Center(
                        child: TextField(
                          controller: taskcontroller.addtaskcontroller,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontSize: 13.5
                          ),
                          decoration: InputDecoration(
                            hintText: 'I want to...',
                            hintStyle: TextStyle(
                                fontFamily:sfprotextregular,
                                color: Color(0xff747474),
                              fontSize: 13.5
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        taskcontroller.addatask(context);
                      },
                      child: Container(
                        height: 36,width: 36,
                        decoration: BoxDecoration(
                          color: Color(0xff006EFF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            child: Icon(CupertinoIcons.up_arrow,
                            color: Colors.white,
                            size: 20,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
          body:
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: screenheight,
                padding: EdgeInsets.only(bottom: 64),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    margin:EdgeInsets.only(top: 12)    ,
                    child: ListView.builder(
                 // controller: ,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: taskcontroller!.allincompletetaskslist!.length,
                      itemBuilder: (context,index){
                    return  InkWell(
                      onTap:(){
                        taskcontroller.showbottomsheetfortasks(taskcontroller!.allincompletetaskslist![index], context);
                        print(taskcontroller.allincompletetaskslist![index].listid);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 11,horizontal: 18),
                          width: screenwidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      if(taskcontroller.allincompletetaskslist![index].status=='1'){
                                        taskController.uncompletethetask(index);
                                      }else if(taskcontroller.allincompletetaskslist![index].status=='0'){
                                      taskcontroller.completethetask(index);
                                      }
                                    },
                                    child: Container(
                                      margin:EdgeInsets.only(right: 10),
                                      child: Icon(
                                        taskcontroller.allincompletetaskslist![index].status=='1'?
                                        CupertinoIcons.checkmark_alt_circle_fill:
                                        CupertinoIcons.circle,
                                      size: 18,
                                      color: Color(0xffD0D0D0),),
                                    ),
                                  ),
                        Container(
                            margin:EdgeInsets.only(right: 10),
                            child: Text(taskcontroller.allincompletetaskslist![index].tasktitle.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 13.5
                              ),)
                        )
                                ],
                              ),

                            ],
                          ),

                      ),
                    );
                }),
                  ),
                  ListView.builder(
                    // controller: ,
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: taskcontroller!.allcompletetaskslist!.length,
                      itemBuilder: (context,index){
                        return  InkWell(
                          onTap: (){

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 11,horizontal: 18),
                              width: screenwidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          if(taskcontroller.allcompletetaskslist![index].status=='1'){
                                            taskController.uncompletethetask(index);
                                      //      AnimatedList.of(context).removeItem(index, (context, animation) =>
                                           // SizedBox(height: 0,));
                                          }else if(taskcontroller.allcompletetaskslist![index].status=='0'){
                                            taskcontroller.completethetask(index);
                                          }
                                        },
                                        child: Container(
                                          margin:EdgeInsets.only(right: 10),
                                          child: Icon(
                                            taskcontroller.allcompletetaskslist![index].status=='1'?
                                            CupertinoIcons.checkmark_alt_circle_fill:
                                            CupertinoIcons.circle,
                                            size: 18,
                                            color: Color(0xffD0D0D0),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin:EdgeInsets.only(right: 10),
                                          child: Text(taskcontroller.allcompletetaskslist![index].tasktitle.toString(),
                                            style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w400,
                                                color:Colors.grey,
                                                fontSize: 13.5
                                            ),)
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      taskcontroller.deletecompletedtask(
                                        taskcontroller.allcompletetaskslist![index]
                                      );
                                    },
                                    child: Container(
                                      child: Icon(
                                        CupertinoIcons.xmark_circle_fill,
                                        size: 18,
                                        color: Color(0xffD0D0D0),
                                      ),
                                    ),
                                  )

                                ],
                              ),

                          ),
                        );
                      }),

                ],
              )
          ),
            ));
        });
  }
}
