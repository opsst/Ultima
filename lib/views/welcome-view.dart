import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/views/signup-view.dart';

import 'login-view.dart';

class WelcomepageView extends StatefulWidget {
  const WelcomepageView({Key? key}) : super(key: key);

  @override
  State<WelcomepageView> createState() => _WelcomepageViewState();
}

class _WelcomepageViewState extends State<WelcomepageView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: (){
          primaryFocus!.unfocus();
        },
        child: Container(
          color: Color(0xFF1E439B),
          child: Stack(
            children: [
              Container(
                height: 80.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/welcome.png'),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 14.h,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text('Welcome to',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Colors.white)),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/logo_icon.png',scale: 1, height: 36),
                              SizedBox(width: 2.w),
                              Text('Ultima',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 25.sp,fontWeight: FontWeight.w700,color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 17.h,
                        left: 0,
                        right: 0,
                        child: Text('Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry. Lorem Ipsum',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.white))
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8.h,
                left: 5.h,
                right: 5.h,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<dynamic>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => SignUppageView());
                      },
                      child: Container(
                          height: 6.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text('SIGNUP',style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w800,color: Color(0xFF4E82FF), letterSpacing: 1)),
                          )
                      ),
                    ),
                    SizedBox(height: 3.5.h,),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<dynamic>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => LoginpageView());
                      },
                      child: Container(
                          height: 6.5.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFF4E82FF),
                          ),
                          child: Center(
                            child: Text('LOGIN',style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w800,color: Colors.white, letterSpacing: 1)),
                          )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
