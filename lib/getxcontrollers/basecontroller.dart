import 'package:archorganisebetter/getxcontrollers/productivity_home.dart';
import 'package:archorganisebetter/screens/base/lists.dart';
import 'package:archorganisebetter/screens/base/preferences.dart';
import 'package:archorganisebetter/screens/base/task.dart';
import 'package:get/get.dart';

class BaseController extends GetxController{
  int currentindex=0;
  List children=[ProductivityHome(),TaskPage(),ListsPage(),Preferences()];
  setindex(int index){
    currentindex=index;
    update();

  }
}