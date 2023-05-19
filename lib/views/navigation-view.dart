import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/views/account-view.dart';
import 'package:ultima/views/discover-view.dart';
import 'package:ultima/views/home-view.dart';
import 'package:ultima/views/notification-view.dart';

import '../services/service.dart';
import '../services/user-controller.dart';


class NavigationBarView extends StatefulWidget {
  const NavigationBarView({Key? key}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  APIService service = APIService();

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
                top: false,
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.h),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(offset: Offset(0,18),color: Colors.black.withOpacity(0.1),blurRadius: 100,spreadRadius: 20)
                      ]
                    ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.5.h,bottom: .5.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var res = await service.checkAllUser();
                                print(res);
                                //
                                // var res2 = await service.loginUser('Frank', "123456");
                                // print(res2);

                                Get.find<userController>().changePage(0);
                              },
                              child: Container(
                                width: 25.w,
                                // height: 5.h,
                                child: Column(
                                  children: [
                                    Icon(Boxicons.bx_home_circle,color: Get.find<userController>().statePage.value==0?Color(0xFF4E82FF):Color(0xFFBBBBBB),size: 20.sp),
                                    SizedBox(height: 0.2.h,),
                                    Text('Home',style: GoogleFonts.inter(fontSize: 12.sp,fontWeight: FontWeight.w600,color: Get.find<userController>().statePage.value==0?Color(0xFF4E82FF):Color(0xFFBBBBBB)),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.find<userController>().changePage(1);

                              },
                              child: Container(
                                width: 25.w,
                                // height: 5.h,
                                child: Column(
                                  children: [
                                    Icon(Boxicons.bx_search,color: Get.find<userController>().statePage.value==1?Color(0xFF4E82FF):Color(0xFFBBBBBB),size: 20.sp),
                                    SizedBox(height: 0.2.h,),
                                    Text('Search',style: GoogleFonts.inter(fontSize: 12.sp,fontWeight: FontWeight.w600,color: Get.find<userController>().statePage.value==1?Color(0xFF4E82FF):Color(0xFFBBBBBB)),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.find<userController>().changePage(2);

                              },
                              child: Container(
                                width: 25.w,
                                // height: 5.h,
                                child: Column(
                                  children: [
                                    Icon(EvaIcons.bellOutline,color: Get.find<userController>().statePage.value==2?Color(0xFF4E82FF):Color(0xFFBBBBBB),size: 20.sp),
                                    SizedBox(height: 0.2.h,),
                                    Text('Notification',style: GoogleFonts.inter(fontSize: 12.sp,fontWeight: FontWeight.w600,color: Get.find<userController>().statePage.value==2?Color(0xFF4E82FF):Color(0xFFBBBBBB)),)

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.find<userController>().changePage(3);
                              },
                              child: Container(
                                width: 25.w,
                                // height: 5.h,
                                child: Column(
                                  children: [
                                    Icon(Boxicons.bx_user,color: Get.find<userController>().statePage.value==3?Color(0xFF4E82FF):Color(0xFFBBBBBB),size: 20.sp),
                                    SizedBox(height: 0.2.h,),
                                    Text('Account',style: GoogleFonts.inter(fontSize: 12.sp,fontWeight: FontWeight.w600,color: Get.find<userController>().statePage.value==3?Color(0xFF4E82FF):Color(0xFFBBBBBB)),)

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 1.w,)
                      ],
                    ),
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
