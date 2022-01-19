import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/datamodels/TaskModel.dart';
import 'package:archorganisebetter/getxcontrollers/taskscontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
                leading: IconButton(
                  onPressed: (){
                  },
                  icon: Icon(Ionicons.apps,
             //       color:Color(0xffA6AEB9),
                    color: Color(0xffA3A3A3),
                    //      size: 19,
                    size:screenwidth*0.0487,    ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: Size(screenwidth,1),
                  child: Container(
                    width: screenwidth,
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color(0xffECEBEB)
                    ),
                  ),
                ),
                title: Container(
                  child:Text("All Tasks",style: TextStyle(
                      color: Colors.black,
                      fontFamily: sfprotextregular,
//                      fontSize: 16.5
                      fontSize: screenwidth*0.0423
                  ),),
                ),
                actions: [
                  PopupMenuButton(
                      tooltip: 'Menu',
                      child:  GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
  //                            right: 18
                                right: screenwidth*0.0461,
                          ),
                        child: Icon(CupertinoIcons.ellipsis_circle,
                          color: Color(0xffA3A3A3),
//                          size: 20.5,
                          size: screenwidth*0.0525,
                        ),
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
//                                    size: 18.0,
                                    size: screenwidth*0.0461,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){

                                  },  child: Icon(
                                    Icons.share,
                                    color: Colors.black.withOpacity(0.56),
                //                    size: 18.0,
                                  size: screenwidth*0.0461,
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
                             CupertinoIcons.checkmark_alt_circle_fill,
                              color: Colors.black.withOpacity(0.61),
      //                        size: 18.0,
                              size: screenwidth*0.0461,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text(
                                "Clear completed tasks",
                                style: TextStyle(
                                  fontFamily: sfprotextregular,
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
                              fontFamily:sfprotextregular,
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
              physics: BouncingScrollPhysics(),
              child: Container(
           //     height: screenheight,
                padding: EdgeInsets.only(
//                    bottom: 64
                    bottom: screenwidth*0.164
                ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenwidth,
                    padding: EdgeInsets.only(
//                        top: 21, left: 18,right: 18
                        top: screenwidth*0.0538,
                    ),
                    child: ReorderableListView(
                      onReorder: (oldindex,newindex){

                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          key: Key("today"),
                          margin: EdgeInsets.only(
                   //           bottom: 18
                              bottom:  screenwidth*0.023,
                          ),
                          padding: EdgeInsets.only(left: screenwidth*0.0461,right:  screenwidth*0.0461),
                          width:screenwidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Today",style: TextStyle(
                                  fontFamily: sfprotextsemibold,
                                  color: Color(0xff006EFF),
//                                  fontSize: 19
                                    fontSize: screenwidth*0.0487
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Color(0xff006EFF),
//                                size: 22,
                                  size: screenwidth*0.0564,
                                ),
                              )
                            ],
                          ),
                        ),
                        for(int i=0;i<
                            taskcontroller!.allincompletetaskslist!.length;i++)
                InkWell(
                  key: Key("$i"),
                onTap:(){
            taskcontroller.showbottomsheetfortasks(taskcontroller!.allincompletetaskslist![i], context);
            print(taskcontroller.allincompletetaskslist![i].listid);
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
                            if(taskcontroller.allincompletetaskslist![i].status=='1'){
                              taskController.uncompletethetask(i);
                            }else if(taskcontroller.allincompletetaskslist![i].status=='0'){
                              taskcontroller.completethetask(i);
                            }
                          },
                          child: Container(
                            margin:EdgeInsets.only(right: 10),
                            child: Icon(
                              taskcontroller.allincompletetaskslist![i].status=='1'?
                              CupertinoIcons.checkmark_alt_circle_fill:
                              CupertinoIcons.circle,
                              size: 18,
                              color: Color(0xffD0D0D0),),
                          ),
                        ),
                        Container(
                            margin:EdgeInsets.only(right: 10),
                            child: Text(taskcontroller.allincompletetaskslist![i].tasktitle.toString(),
                              style: TextStyle(
                                  fontFamily: sfprotextregular,
                                  color: Colors.black87,
                                  fontSize: 13.5
                              ),)
                        )
                      ],
                    ),

                  ],
                ),

              ),
            ),
            for(int j=0;j<taskcontroller.allcompletetaskslist!.length;j++)
              InkWell(
                key: Key((7+j).toString()),
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
                              if(taskcontroller.allcompletetaskslist![j].status=='1'){
                                taskController.uncompletethetask(j);
                                //      AnimatedList.of(context).removeItem(index, (context, animation) =>
                                // SizedBox(height: 0,));
                              }else if(taskcontroller.allcompletetaskslist![j].status=='0'){
                                taskcontroller.completethetask(j);
                              }
                            },
                            child: Container(
                              margin:EdgeInsets.only(right: 10),
                              child: Icon(
                                taskcontroller.allcompletetaskslist![j].status=='1'?
                                CupertinoIcons.checkmark_alt_circle_fill:
                                CupertinoIcons.circle,
                                size: 18,
                                color: Color(0xffD0D0D0),
                              ),
                            ),
                          ),
                          Container(
                              margin:EdgeInsets.only(right: 10),
                              child: Text(taskcontroller.allcompletetaskslist![j].tasktitle.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontFamily: sfprotextregular,
                                    color:Colors.grey,
                                    fontSize: 13.5
                                ),)
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: ()async{
                          taskcontroller.deletecompletedtask(
                              taskcontroller.allcompletetaskslist![j]
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
              ),
                        Container(
                          key: Key("tomorrow"),
                          padding: EdgeInsets.only(left: screenwidth*0.0461,right:  screenwidth*0.0461),
                          margin: EdgeInsets.only(
                            //           bottom: 18
                              bottom:  screenwidth*0.023, top:  screenwidth*0.023
                          ),
                          width:screenwidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Tomorrow",style: TextStyle(
                                    fontFamily: sfprotextsemibold,
                                    color: Color(0xff006EFF),
//                                  fontSize: 19
                                    fontSize: screenwidth*0.0487
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Color(0xff006EFF),
//                                size: 22,
                                  size: screenwidth*0.0564,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: screenwidth*0.0461,right:  screenwidth*0.0461),
                          key: Key("thisweek"),
                          margin: EdgeInsets.only(
                            //           bottom: 18
                              bottom:  screenwidth*0.023, top:  screenwidth*0.023
                          ),
                          width:screenwidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("This week",style: TextStyle(
                                    fontFamily: sfprotextsemibold,
                                    color: Color(0xff006EFF),
//                                  fontSize: 19
                                    fontSize: screenwidth*0.0487
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Color(0xff006EFF),
//                                size: 22,
                                  size: screenwidth*0.0564,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: screenwidth*0.0461,right:  screenwidth*0.0461),
                          key: Key("nextweek"),
                          margin: EdgeInsets.only(
                            //           bottom: 18
                              bottom:  screenwidth*0.023, top:  screenwidth*0.023
                          ),
                          width:screenwidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Next week",style: TextStyle(
                                    fontFamily: sfprotextsemibold,
                                    color: Color(0xff006EFF),
//                                  fontSize: 19
                                    fontSize: screenwidth*0.0487
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Color(0xff006EFF),
//                                size: 22,
                                  size: screenwidth*0.0564,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),taskcontroller.allincompletetaskslist!.length==0
                      && taskcontroller.allcompletetaskslist!.length==0
                      ?
                  SizedBox(height: screenwidth*0.153,):SizedBox(height: 0,),
                  taskcontroller.allincompletetaskslist!.length==0
                      && taskcontroller.allcompletetaskslist!.length==0
                      ?
                  emptystate(context):SizedBox(height: 0,),


                ],
              )
          ),
            ));
        });
  }
  Widget emptystate(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return  Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset("assets/No task empty state.svg",
                width: screenwidth*0.422,),
            ),
            Container(
              margin: EdgeInsets.only(
//                                top: 21,bottom: 9
                  top: screenwidth*0.0538,bottom: screenwidth*0.0230
              ),
              child: Text("No Tasks added yet",style: TextStyle(
                  fontFamily: sfprotextsemibold,
                  color: Colors.black,
                  fontSize: 18.5
              ),),
            ),
            Container(
              child: Text("Press the + button to add tasks. It could be your\n"
                  "assignments due, errands to run, you get it right",style: TextStyle(
                  fontFamily: sfproroundedmedium,
                  color: Color(0xffA3A3A3),
                  fontSize: 12.5
              ),),
            ),
          ],
        ),
      ],
    );
  }
}
