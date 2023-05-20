import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class userController extends GetxController{
  var instruction_State = 0.obs;
  PageController? thisControl;
  var statePage = 0.obs;
  var isScroll = false.obs;

  startControl(PageController controller){
    thisControl = controller;
  }

  changePage(int page){
    statePage.value = page;
    thisControl?.jumpToPage(page);
    // thisControl?.animateToPage(page, duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

}