import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class SignUppageView extends StatefulWidget {
  const SignUppageView({Key? key}) : super(key: key);

  @override
  State<SignUppageView> createState() => _SignUppageViewState();
}

class _SignUppageViewState extends State<SignUppageView> {
  bool validate = true;
  String errFirstname='', errLastname='', errEmail='', errPassword='';
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
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
                Text('Sign Up',style: GoogleFonts.inter(fontSize: 19.sp,fontWeight: FontWeight.w800,color: Colors.black, letterSpacing: 1)),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 6.h,),
            Row(
              children: [
                Expanded(child: textInput('Firstname', _firstnameController, errFirstname, validate)),
                SizedBox(width: 2.5.h),
                Expanded(child: textInput('Lastname', _lastnameController, errLastname, validate)),
              ],
            ),
            SizedBox(height: 2.5.h,),
            textInput('Email Address', _emailController, errEmail, validate),
            SizedBox(height: 2.5.h,),
            textInput('Password', _passwordController, errPassword, validate),
            SizedBox(height: 4.h,),
            Row(
              children: [
                RoundCheckBox(
                  onTap: (selected) {},
                  size: 3.h,
                  uncheckedColor: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF7182AA),
                  ),
                  checkedWidget: Icon(FeatherIcons.check, color: Colors.white, size: 2.h,),
                  checkedColor: Color(0xFF7182AA),
                  animationDuration: Duration(
                    milliseconds: 80,
                  ),
                ),
                SizedBox(width: 1.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'By creating an account you agree to the ',
                        style: GoogleFonts.inter(fontSize: 13.5.sp,fontWeight: FontWeight.w600,color: Color(0xFF576580)),
                        children: [
                          TextSpan(
                            text: 'terms of use',
                            style: GoogleFonts.inter(fontSize: 13.5.sp,fontWeight: FontWeight.w600,color: Color(0xFF4E82FF), textStyle: TextStyle(decoration: TextDecoration.underline))
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 0.4.h,),
                    Text.rich(
                        TextSpan(
                            text: 'and our ',
                            style: GoogleFonts.inter(fontSize: 13.5.sp,fontWeight: FontWeight.w600,color: Color(0xFF576580)),
                            children: [
                              TextSpan(
                                  text: 'privacy policy',
                                  style: GoogleFonts.inter(fontSize: 13.5.sp,fontWeight: FontWeight.w600,color: Color(0xFF4E82FF), textStyle: TextStyle(decoration: TextDecoration.underline))
                              )
                            ]
                        )
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 4.h,),
            Container(
                height: 6.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF4E82FF),
                ),
                child: Center(
                  child: Text('CREATE ACCOUNT',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.white, letterSpacing: 1)),
                )
            ),
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
            Container(
                height: 6.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xFF9FA2A8), width: 0.25.h),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google-icon.png',height: 3.h),
                    SizedBox(width: 2.h,),
                    Text('Create account with Google',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.black)),
                  ],
                )
            ),
            SizedBox(height: 2.5.h,),
            Container(
                height: 6.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xFF9FA2A8), width: 0.25.h),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/facebook-icon.png',height: 3.h),
                    SizedBox(width: 2.h,),
                    Text('Create account  with Facebook',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.black)),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField textInput(String hintText, TextEditingController controller, String errorText, bool validate){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.roboto(color: Color(0xFFB2BFEB),fontSize: 15.sp, fontWeight: FontWeight.w500),
      filled: true,
      fillColor: Color(0xFFF5F8FF),
      contentPadding: EdgeInsets.fromLTRB(2.5.h, 2.0.h, 2.5.h, 2.0.h),
      errorText: validate ? null : errorText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF5F8FF), width: 1),
        borderRadius: BorderRadius.circular(11.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF4E82FF), width: 2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(11.0),
      ),
    ),
  );
}

