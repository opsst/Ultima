import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/auth-service.dart';
import '../services/user-controller.dart';
import 'camera-view.dart';

class RewardView extends StatefulWidget {
  const RewardView({Key? key}) : super(key: key);

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Stack(
                children: [

                  Container(
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight:Radius.circular(0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                        ]

                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.h,bottom: 1.5.h),
                      child: Column(
                        children: [
                          Spacer(),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Get.back();
                              }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
                              Text('Claim Reward',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 19.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
                              Spacer()

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 17.h),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // height: 20.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                // color: Color(0xFF4E82FF),
                                  borderRadius: BorderRadius.circular(6.w),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0XFF4D49FF),
                                      Color(0XFF5C4EFF),
                                      Color(0XFF527EFF),
                                      Color(0XFF72ABFD),
                                      Color(0XFF97C1FF)],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                  ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.5.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Point',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 14.sp,letterSpacing: 0.3,color: Colors.white.withOpacity(0.84))),
                                    Text(Get.find<userController>().userPoint.value.toString()+' P.',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 30.sp,letterSpacing: 0.3,color: Colors.white)),
                                    SizedBox(height: 4.w,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.31),
                                          borderRadius: BorderRadius.circular(100.w),
                                          boxShadow: [
                                            BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                          ]
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.h),
                                        child: Row(
                                          children: [
                                            Icon(FeatherIcons.clock,size: 19.sp,color: Colors.white),
                                            SizedBox(width: 1.5.w,),
                                            Text('Starbuck: Coffee',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 15.sp,letterSpacing: 0.3,color: Colors.white)),
                                            Spacer(),
                                            Text('-80 P.',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 15.sp,letterSpacing: 0.3,color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Align(
                              alignment: Alignment.centerLeft,
                                child: Text('Redeem Point',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 17.sp,letterSpacing: 0.3,color: Color(0XFF0B1F4F)))
                            ),
                            SizedBox(height: 2.h,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.w),
                                  boxShadow: [
                                    BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                  ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.7.w, top: 4.w, bottom: 4.w),
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/cofee.png',height: 8.h),
                                    SizedBox(width: 3.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Starbucks',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp,letterSpacing: 0.3,color: Color(0XFF0B1F4F))),
                                        SizedBox(height: 0.5.h,),
                                        Text('Iced Caffè Latte',style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,letterSpacing: 0.3,color: Color(0XFF9D9D9D))),
                                      ],
                                    ),
                                    Spacer(),
                                    Text('180 P.',style: GoogleFonts.inter(fontWeight: FontWeight.w800,fontSize: 20.sp,letterSpacing: 0.3,color: Color(0XFF4D49FE))),
                                    IconButton(onPressed: (){
                                      Get.back();
                                    }, icon: Icon(Icons.arrow_forward_ios_rounded)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Recommend Store',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 17.sp,letterSpacing: 0.3,color: Color(0XFF0B1F4F)))
                            ),
                            SizedBox(height: 2.h,),
                            Row(
                              children: [
                                Container(
                                  height : 25.h,
                                  width: 45.w,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 5.w,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5.w),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                              ]
                                          ),
                                          child: Padding(
                                            padding : EdgeInsets.only(left: 3.w,right: 3.w,bottom: 5.5.w,top: 5.h),
                                            child: Column(
                                              children: [
                                                Text('Starbucks',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp,letterSpacing: 0.3,color: Color(0XFF0B1F4F))),
                                                SizedBox(height: 0.5.h,),
                                                Text('3 Coffee',style: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp,letterSpacing: 0.3,color: Color(0XFF9D9D9D))),
                                                SizedBox(height: 2.h,),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFF5A4EFF),
                                                      borderRadius: BorderRadius.circular(5.w),
                                                      boxShadow: [
                                                        BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                                      ]
                                                  ),
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.2.h),
                                                      child: Text('See All',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 14.sp,letterSpacing: 0.3,color: Colors.white))
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 3.5.h,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 2.5.h,
                                            foregroundImage: AssetImage('assets/images/image 116.png'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ],
        )
    );
  }
}
