import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NavigatedView extends StatefulWidget {
  const NavigatedView({Key? key}) : super(key: key);

  @override
  State<NavigatedView> createState() => _NavigatedViewState();
}

class _NavigatedViewState extends State<NavigatedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 12.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight:Radius.circular(0)),
                boxShadow: [
                  BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                ]

            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(EvaIcons.arrowBack,color: Color(0xFF4E82FF),))
                ],
              ),
            ),
          ),
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(EvaIcons.checkmarkCircle2Outline,size: 34.sp,color: Color(0xFF32A060)),
                SizedBox(height: 1.h,),
                Text('Redirected to',style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w700), ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h,left: 15.w,right: 15.w),
                  child: Text(' ${Get.arguments}',textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Colors.black38),),
                ),
                SizedBox(height: 6.h,),

                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    width: 80.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF4E82FF),
                      borderRadius: BorderRadius.circular(200)
                    ),
                    child: Center(child: Text('Back',style: GoogleFonts.inter(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 17.sp),)),
                  ),
                ),
                SizedBox(height: 15.h,),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
