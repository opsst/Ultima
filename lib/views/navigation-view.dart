import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/views/account-view.dart';
import 'package:ultima/views/discover-view.dart';
import 'package:ultima/views/home-view.dart';
import 'package:ultima/views/notification-view.dart';

import '../services/user-controller.dart';


class NavigationBarView extends StatefulWidget {
  const NavigationBarView({Key? key}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {

  late PageController _pageController;
  void initState() {
    super.initState();
    _pageController = PageController();
    Get.find<userController>().startControl(_pageController);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF9F9F9),
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.0.h,bottom: 1.h),
                  child: PageView(
                    pageSnapping: false,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: const [
                      HomepageView(),DiscoverView(),NotificationView(),AccountView()
                    ],
                  ),
                ),
              ),
            ),
            Obx(
                  ()=> Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.find<userController>().changePage(0);
                            },
                            child: Container(
                              width: 25.w,
                              // height: 5.h,
                              child: Icon(EvaIcons.homeOutline,color: Get.find<userController>().statePage.value==0?Color(0xFF4E82FF):Color(0xFFBBBBBB),size: 22.sp),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.find<userController>().changePage(1);

                            },
                            child: Container(
                              width: 25.w,
                              // height: 5.h,
                              child: Icon(EvaIcons.clockOutline,color: Get.find<userController>().statePage.value==1?Colors.white:Colors.grey,size: 22.sp),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.find<userController>().changePage(2);

                            },
                            child: Container(
                              width: 25.w,
                              // height: 5.h,
                              child: Icon(EvaIcons.playCircleOutline,color: Get.find<userController>().statePage.value==2?Colors.white:Colors.grey,size: 22.sp),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.find<userController>().changePage(3);

                            },
                            child: Container(
                              width: 25.w,
                              // height: 5.h,
                              child: Icon(EvaIcons.bellOutline,color: Get.find<userController>().statePage.value==3?Colors.white:Colors.grey,size: 22.sp),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 2.h,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
