import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/home-view.dart';
import 'package:ultima/views/signup-view.dart';

import 'navigation-view.dart';

class LoginpageView extends StatefulWidget {
  const LoginpageView({Key? key}) : super(key: key);

  @override
  State<LoginpageView> createState() => _LoginpageViewState();
}

class _LoginpageViewState extends State<LoginpageView> {
  bool validate = true;
  String errEmail='', errPassword='';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.h,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0)
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(alignment: Alignment.centerLeft, child: Icon(FeatherIcons.chevronLeft,size: 23.sp,))
                ),
                Text('Login',style: GoogleFonts.inter(fontSize: 19.sp,fontWeight: FontWeight.w800,color: Colors.black, letterSpacing: 1)),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 11.h,),
            textInput('Email Address', _emailController, errEmail, validate),
            SizedBox(height: 2.5.h,),
            textInput('Password', _passwordController, errPassword, validate),
            SizedBox(height: 1.5.h,),
            Align(alignment: Alignment.centerRight,child: Text('Forgot Password?',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFF6E7A92)))),
            SizedBox(height: 4.h,),
            GestureDetector(
              onTap: (){
                Get.to(
                    () => NavigationBarView()
                );
              },
              child: Container(
                  height: 6.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFF4E82FF),
                  ),
                  child: Center(
                    child: Text('LOGIN',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.white, letterSpacing: 1)),
                  )
              ),
            ),
            SizedBox(height: 1.5.h,),
            Text('You don’t have an account?',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFF6E7A92))),
            SizedBox(height: 4.5.h,),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xFFCCCCCC),
                    thickness: 2.5,
                  ),
                ),
                Text('  OR  ',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Color(0xFFCCCCCC), letterSpacing: 1)),
                Expanded(
                  child: Divider(
                    color: Color(0xFFCCCCCC),
                    thickness: 2.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.5.h,),
            Text('Social Media Login',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF1E439B))),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AuthService().signInWithGoogle(context);
                    // Navigator.pop(context);
                  },
                  child: Image.asset('assets/images/google-icon.png',height: 6.5.h)
                ),
                SizedBox(width: 3.h,),
                GestureDetector(
                    onTap: () {
                      AuthService().signInWithFacebook(context);
                      // Navigator.pop(context);
                    },
                  child: Image.asset('assets/images/facebook-icon.png',height: 6.5.h)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
