import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/home-view.dart';
import 'package:ultima/views/signup-view.dart';
import '../services/service.dart';
import '../services/user-controller.dart';
import 'navigation-view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  APIService service = APIService();
  final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();

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
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                        child: Align(alignment: Alignment.centerLeft, child: Icon(FeatherIcons.chevronLeft,size: 23.sp,)))
                ),
                Text('Login',style: GoogleFonts.inter(fontSize: 19.sp,fontWeight: FontWeight.w800,color: Colors.black, letterSpacing: 1)),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 11.h,),
            Form(
              key: _formKey,
                child: Column(children: [
              email('Email Address', _emailController, errEmail, validate),
              SizedBox(height: 2.5.h,),
              password('Password', _passwordController, errPassword, validate),
            ],)),

            SizedBox(height: 1.5.h,),
            Align(alignment: Alignment.centerRight,child: Text('Forgot Password?',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFF6E7A92)))),
            SizedBox(height: 4.h,),
            GestureDetector(
              onTap: () async {
                // Get.to(
                //     () => NavigationBarView()
                // );

                if(_formKey.currentState!.validate()){
                  service.loginUser(_emailController.text, _passwordController.text).then((res) async {
                    print(res.data['status']);
                    if(res.data['status']==200){
                        await storage.write(key: "token", value: res.data['token']);
                        await Get.find<userController>().initData();

                    }else{
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

                }



                // print(res2);
                // final data = jsonDecode(res2.toString());
                //
                //
                // if(data['message']== "success"){
                //   await storage.delete(key: "token");
                //   await storage.write(key: "token", value: data['token']);
                //   String? mytoken = await storage.read(key: "token");
                //   print("TOKEN: "+mytoken.toString());
                //   await Get.find<userController>().initData();
                //
                // }

                //navigator




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
            GestureDetector(
              onTap: (){
                Get.back();
                showModalBottomSheet<dynamic>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => SignupView());

              },
                child: Text('You don’t have an account?',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFF6E7A92)))),
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
                  onTap: () async {
                    UserCredential result = await AuthService().signInWithGoogle(context);
                    // List<String> name = result.user!.displayName!.toString().split(" ")??[""];
                    // print(result.user!.uid);
                    service.googleCreate(result.user!.displayName!, "", result.user!.uid).then((res) async {
                      print(res.data);
                      Get.back();

                      await storage.write(key: "token", value: res.data['token']);
                      await Get.find<userController>().initData();
                    });
                    // Navigator.pop(context);
                  },
                  child: Image.asset('assets/images/google-icon.png',height: 6.5.h)
                ),
                SizedBox(width: 3.h,),
                GestureDetector(
                    onTap: () async {
                      var result =  await AuthService().signInWithFacebook(context);
                      print(result);
                      Get.back();
                      service.facebookCreate(result.user!.displayName!, "", result.user!.uid).then((res) async {
                        print(res.data);
                        await storage.write(key: "token", value: res.data['token']);
                        await Get.find<userController>().initData();
                      });
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
