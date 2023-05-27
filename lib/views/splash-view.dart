import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';
import 'package:ultima/services/service.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/navigation-view.dart';
import 'package:ultima/views/welcome-view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  FlutterSecureStorage storage = FlutterSecureStorage();
  APIService service = APIService();

  var checkFirebase = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }

  isLogin() async {
    String? mytoken = await storage.read(key: "token");
    print(mytoken);
    if(mytoken == null){

      setState(() {
        checkFirebase = true;
      });


    }else{

      await Get.find<userController>().initData();

    }

  }

  @override
  Widget build(BuildContext context) {
    return !checkFirebase?Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(35.w),
            child: Image.asset('assets/icons/icon.png'),
          ),
        ),
    ):WelcomepageView();
  }
}
