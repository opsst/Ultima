import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';



class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  _user() async {
    await FirebaseAuth.instance.currentUser!.getIdTokenResult().then((result) {
      print('getIdTokenResult: ');
      print(result);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        primaryFocus!.unfocus();
      },
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Stack(
              children: [

                Padding(
                  padding: EdgeInsets.only(top: 11.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h,),

                      ],
                    ),
                  ),
                ),
                Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                      ]

                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.h,right: 2.5.h,bottom: 1.5.h),
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            CircleAvatar(),
                            SizedBox(width: 2.w,),
                            Text(FirebaseAuth.instance.currentUser!.displayName!.toString(),style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 18.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(FeatherIcons.moreVertical,size: 20.sp,))

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              AuthService().logout();
            },
            child: Container(
              width: 10.w,
              child: Text('logout'),
            ),
          )
        ],
      ),
    );
  }
}
