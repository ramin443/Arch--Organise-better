import 'package:archorganisebetter/constants/font_constants.dart';
import 'package:archorganisebetter/getxcontrollers/listcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
class ListsPage extends StatelessWidget {
   ListsPage({Key? key}) : super(key: key);
   final ListController listController =
   Get.put(ListController());
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return
      GetBuilder<ListController>(
          init: ListController(),
          initState: (v){
            listController.updatelistslistView();
          },
          builder: (listcontroller){
        return
      Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:
      GestureDetector(
        onTap: (){
          listcontroller.createnewlist();
        },
        child: Container(
          margin: EdgeInsets.only(right: 12,bottom: 12),
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Color(0xff006EFF),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.16),blurRadius: 6,offset: Offset(0,3))],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(CupertinoIcons.add,
            color: Colors.white,
                size: 34,),
          ),
        ),
      ),
     appBar:  AppBar(

       leading: IconButton(
         onPressed: (){

         },
         icon: Icon(Ionicons.apps,
           color:Color(0xff006EFF),
           //      size: 21,
           size: screenwidth*0.0538,    ),
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
           /*     homecontroller.save(DailyClassModel("Introduction to Computer Science",
                            "SCC Hall 1 Hall 2", DateFormat.yMMMd('en_US').format(DateTime.now()),
                            "00:17", "01:00"));
                        homecontroller.updatecurrrentselecteddaylistvew(
                            DateFormat.yMMMd('en_US').format(DateTime.now()));*/
           //   Map response=await locator<ApiService>().campusnetlogin();
           // print(response.values);
         }, icon: Icon(
           CupertinoIcons.add_circled_solid,
           color: Colors.transparent,
           //     size: 24,
           size: screenwidth*0.0615
           , ))
       ],
       automaticallyImplyLeading: false,
     ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: screenwidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenwidth,
                margin: EdgeInsets.only(left: 18,right: 18,bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Lists",style: TextStyle(
                        fontFamily: sfproroundedsemibold,
                        color: Colors.black,
                        fontSize: 22.5
                      ),),
                    ),
                    Container(
                      child:  Text("+",style: TextStyle(
                          fontFamily: sfproroundedregular,
                          color: Colors.black,
                          fontSize: 32
                      ),),
                    )
                  ],
                ),
              ),
              Container(
                width: screenwidth,
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text("Recent",style: TextStyle(
                              fontFamily: sfproroundedsemibold,
                              color: Color(0xff7C7F9B),
                              fontSize: 15.5
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Icon(CupertinoIcons.chevron_down_circle_fill,
                              color: Color(0xff7C7F9B),
                              size: 14.5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(CupertinoIcons.list_dash,
                        color: Color(0xff7C7F9B),
                        size: 20.5,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 18,right: 18,top: 18,bottom: 18),
                  child: staggeredgridview(context)),
            ],
          ),
        ),
      ),
    );});
  }

   Widget staggeredgridview(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
     double screenheight = MediaQuery.of(context).size.height;
     double screenarea = screenwidth * screenheight;

     return StaggeredGridView.countBuilder(
       shrinkWrap: true,
       physics: BouncingScrollPhysics(),
       scrollDirection: Axis.vertical,
       crossAxisCount: 4,
       itemCount:  listController.allcreatedlists!=null?
       listController.allcreatedlists!.length:0,
       itemBuilder: (BuildContext context, int index) {
         return GestureDetector(
             onTap: (){
               listController.deletealist(listController.allcreatedlists![index]);
    //           Navigator.pushNamedAndRemoveUntil(context, '/DrinkDetails', (route) => true);
             },
             child:
             Container(
                 decoration: BoxDecoration(
                   boxShadow: [BoxShadow(color: Colors.black12,
                       offset: Offset(0,3),blurRadius: 10)],
                 ),
                 child:
                 ClipRRect(
                     borderRadius:
                     BorderRadius.all(Radius.circular(12)),
                     child:
                     Container(
                       padding: EdgeInsets.all(12),
                       //  height: 135,
                         width: screenwidth * 0.38,
                         decoration: BoxDecoration(
                           color: Color(0xff006EFF),
                           borderRadius:
                           BorderRadius.all(Radius.circular(12)),
                         ),
                         child: Container(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(listController.allcreatedlists![index].listtitle.toString(),
                                 style: TextStyle(
                                     fontSize: 22,
                                     color: Colors.white,
                                   fontFamily: sfproroundedsemibold
                                 ),),
                               Text(listController.allcreatedlists![index].listid.toString(),
                                 style: TextStyle(
                                     fontSize: 22,
                                     color: Colors.white
                                 ),
                               ),
                             ],
                           ),
                         )))))
         ;
       },
       staggeredTileBuilder: (int index) =>
       new StaggeredTile.count(2, index.isEven ? 2 : 2),
//          mainAxisSpacing: 18.0, crossAxisSpacing: 18.0,
       mainAxisSpacing: screenwidth*0.0437, crossAxisSpacing: screenwidth*0.0437,
     );
   }
   getimageforrow1(int index){
     if(index.isEven){
       return "assets/images/coffee1.png";
     }
     else{
       return "assets/images/coffe2.png";
     }
   }
   gettitleforrow1(int index){
     if(index.isEven){
       return "Café Latte";
     }
     else{
       return "Latte Machiato";
     }


   }
   getpriceforrow1(int index){
     if(index.isEven){
       return "3.00";
     }
     else{
       return "2.00";
     }
   }
   Widget alternatelistingoptions(BuildContext context) {
     double screenwidth=MediaQuery.of(context).size.width;
     return      Container(
       margin: EdgeInsets.only(top: 14,bottom:14,left: 18,right: 18),
       padding: EdgeInsets.symmetric(horizontal: 16,
           vertical: 21),
       width: screenwidth*0.933,
       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.all(Radius.circular(11)),
           boxShadow: [BoxShadow(
               color: Colors.black.withOpacity(0.16),
               offset: Offset(0,0),
               blurRadius: 6
           )]
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 child: Text("Lists",style: TextStyle(
                     fontFamily: sfprosemibold,
                     fontSize: 24,
                     color: Colors.black
                 ),),
               )
             ],
           ),
           Container(
             margin: EdgeInsets.only(top: 16),
             width: screenwidth,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 //List title goes here
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       height: 21,width:21,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: Color(0xff006EFF),
                       ),
                       child: Center(
                         child: Icon(CupertinoIcons.checkmark_alt,
                           color: Colors.white,
                           size: 16,),
                       ),
                     ),
                     Container(
                       width: 1,
                       height: 53,
                       margin: EdgeInsets.symmetric(vertical: 6),
                       decoration: BoxDecoration(
                           color: Color(0xffE2E2E2),

                           borderRadius:BorderRadius.all(Radius.circular(20))
                       ),
                     )

                   ],
                 ),
                 Container(
                   margin: EdgeInsets.only(left: 9),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         child: Text("Assignments",style:
                         TextStyle(
                             fontFamily: sfproroundedregular,
                             color: Colors.black,
                             fontSize: 15
                         ),),
                       )
                     ],
                   ),
                 )
               ],
             ),
           )

         ],
       ),
     );

   }
}
