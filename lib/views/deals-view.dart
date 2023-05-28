import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/user-controller.dart';

class AllDealsView extends StatefulWidget {
  const AllDealsView({Key? key}) : super(key: key);

  @override
  State<AllDealsView> createState() => _AllDealsViewState();
}

class _AllDealsViewState extends State<AllDealsView> {
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
                              Text('All Deals',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 19.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
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
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.w),
                                  boxShadow: [
                                    BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                  ]
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 6.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Container(
                                        //   height : 2.h,
                                        //   width: 2.h,
                                        //   decoration: BoxDecoration(
                                        //       image: DecorationImage(
                                        //       image: AssetImage('/assets/images/sephora.webp'),
                                        //       fit: BoxFit.cover,
                                        //       alignment: Alignment.center,
                                        //     ),
                                        //     borderRadius: BorderRadius.circular(5.w),
                                        //   ),
                                        // ),
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.circular(2.w),
                                        //   child: Image(
                                        //     image: Image.asset('assets/images/shopping.webp',width: 4.5.w),
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        //
                                        // ),
                                        SizedBox(width: 3.w),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Sephora',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w600,color: Color(0xFF9D9D9D))),
                                            Text("Don't miss it ! Get up to\n10% cashback",style: GoogleFonts.inter(fontSize: 16.5.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F)))

                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1.5.h,),
                                    Text("Unleash your beauty potential with Sephora's unbeatable promotions. Explore a vast selection of high-quality cosmetics, skincare, and fragrances. Elevate your style and embrace your unique glow with Sephora.",
                                        style: GoogleFonts.inter(fontSize: 14.5.sp,fontWeight: FontWeight.w500,height: 0.36.w,color: Color(0xFF9D9D9D))),
                                    SizedBox(height: 1.5.h,),
                                    Image.asset('assets/images/cos-sph.png',width: 100.w),
                                    SizedBox(height: 2.h,),
                                    Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.w),
                                        color: Color(0XFF4E82FF),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 1.3.h,horizontal: 2.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/shopping.webp',width: 4.5.w),
                                            SizedBox(width: 1.8.w,),
                                            Text('Shop Now',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.white)),

                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),

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
