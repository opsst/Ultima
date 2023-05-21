import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/navigation-view.dart';
import 'package:ultima/views/splash-view.dart';
import 'package:ultima/views/welcome-view.dart';

import 'firebase_options.dart';

void main() async {

  Get.put(userController(),permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Ultima",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType){
        return  GetMaterialApp(
            title: "Ultima",
            theme: _buildTheme(Brightness.light),
            debugShowCheckedModeBanner: false,
            home: SplashView(),
            // home: AuthService().handleAuthState()
            // home: NavigationBarView(),
        );
      },
    );
  }
}

