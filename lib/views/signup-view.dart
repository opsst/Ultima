import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:ultima/views/splash-view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/auth-service.dart';
import '../services/service.dart';
import '../services/user-controller.dart';
import 'navigation-view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  var isAccept = false;
  final _formKey = GlobalKey<FormState>();

  APIService service = APIService();
  final storage = const FlutterSecureStorage();
  bool validate = true;
  String errFirstname='', errLastname='', errEmail='', errPassword='';
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Container(
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
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                        child: Align(alignment: Alignment.centerLeft, child: Icon(FeatherIcons.chevronLeft,size: 23.sp,)))
                  ),
                  Text('Sign Up',style: GoogleFonts.inter(fontSize: 19.sp,fontWeight: FontWeight.w800,color: Colors.black, letterSpacing: 1)),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(height: 6.h,),
              Form(
                key: _formKey,
                  child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: textInput('Firstname', _firstnameController, errFirstname, validate)),
                        SizedBox(width: 2.5.h),
                        Expanded(child: textInput('Lastname', _lastnameController, errLastname, validate)),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  SizedBox(
                      height: 10.h,

                      child: email('Email Address', _emailController, errEmail, validate)),
                  SizedBox(
                      height: 10.h,

                      child: password('Password', _passwordController, errPassword, validate)),
                ],
              )),

              Row(
                children: [
                  RoundCheckBox(
                    isChecked: isAccept,
                    onTap: (selected) {
                      setState(() {
                        isAccept = !isAccept;
                      });
                    },
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
                  GestureDetector(
                    onTap: (){
                      launchUrl(Uri.parse('https://www.termsofusegenerator.net/live.php?token=0eVTNNt0jzpmhthNIkO8ENiT7dSp7c8i'));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'By creating an account you agree to the ',
                            style: GoogleFonts.inter(fontSize: 13.5.sp,fontWeight: FontWeight.w600,color: Color(0xFF576580)),
                            children: [
                              TextSpan(
                                text: 'Terms of use',
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
                    ),
                  )
                ],
              ),
              SizedBox(height: 4.h,),
              GestureDetector(
                onTap: () async {


                  // print(_emailController.text);
                  // print(_passwordController.text);
                  // print(_firstnameController.text);
                  // print(_lastnameController.text);
                  //
                  _formKey.currentState!.validate();
                  if(_formKey.currentState!.validate() && isAccept){
                    service.registerUser(_emailController.text, _passwordController.text,
                        _firstnameController.text, _lastnameController.text).then((res) async {
                          print(res);
                      if(res.data['status'] == 200){
                        await storage.write(key: "token", value: res.data['token']);
                        await Get.find<userController>().initData();

                      }else{
                        print('false');
                        Fluttertoast.showToast(
                            msg: res.data['message'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            // timeInSecForIosWeb: 1,
                            backgroundColor: Color(0xFF3C3D89),
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    });
                    // print(register.data);

                    // final data = jsonDecode(register.toString());
                    // print(data);
                    //
                    // if(data["message"]=="Success"){
                    //
                    //   var res2 = await service.loginUser(_emailController.text, _passwordController.text);
                    //   final data2 = jsonDecode(res2.toString());
                    //   if(data2["message"]=="Success"){
                    //     await storage.delete(key: "token");
                    //
                    //     await storage.write(key: "token", value: data2['token']);
                    //     String? mytoken = await storage.read(key: "token");
                    //     print("TOKEN: "+mytoken.toString());
                    //
                    //     Get.off(
                    //             () => SplashView()
                    //     );
                    //   }
                    //
                    //   //navigator
                    //
                    //   //navigator
                    // }
                  }
                  else{
                    print('hi');
                  }



                },
                child: Container(
                    height: 6.5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isAccept?Color(0xFF4E82FF):Colors.grey,
                    ),
                    child: Center(
                      child: Text('CREATE ACCOUNT',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w800,color: Colors.white, letterSpacing: 1)),
                    )
                ),
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
              GestureDetector(
                onTap: () async {
                  UserCredential result = await AuthService().signInWithGoogle(context);
                  // List<String> name = result.user!.displayName!.toString().split(" ")??[""];
                  // print(result.user!.uid);
                  service.googleCreate(result.user!.displayName!, "", result.user!.uid).then((res) async {
                    print(res.data);
                    await storage.write(key: "token", value: res.data['token']);
                    await Get.find<userController>().initData();
                  });
                },
                child: Container(

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
              ),
              SizedBox(height: 2.5.h,),
              GestureDetector(
                onTap: () async {
                  var result =  await AuthService().signInWithFacebook(context);
                  print(result);
                  service.facebookCreate(result.user!.displayName!, "", result.user!.uid).then((res) async {
                    print(res.data);
                    await storage.write(key: "token", value: res.data['token']);
                    await Get.find<userController>().initData();
                  });
                },
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField textInput(String hintText, TextEditingController controller, String errorText, bool validate){
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (value){

    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Field is Required';
      }
      return null;
    },
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
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(11.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      errorStyle: GoogleFonts.roboto(color: Colors.red,fontSize: 15.sp, fontWeight: FontWeight.w500),
    ),
  );
}

TextFormField email(String hintText, TextEditingController controller, String errorText, bool validate){
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (value){

    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Field is Required';
      }
      return null;
    },
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
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(11.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      errorStyle: GoogleFonts.roboto(color: Colors.red,fontSize: 15.sp, fontWeight: FontWeight.w500),
    ),
  );
}


TextFormField password(String hintText, TextEditingController controller, String errorText, bool validate){
  return TextFormField(
    obscureText: true,
    controller: controller,
    keyboardType: TextInputType.visiblePassword,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (value){

    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Field is Required';
      }else if(value.length<8){
        return 'Password must length more than 8 characters';
      }
      return null;
    },
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
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(11.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(11.0),
      ),
      errorStyle: GoogleFonts.roboto(color: Colors.red,fontSize: 15.sp, fontWeight: FontWeight.w500),
    ),
  );
}
