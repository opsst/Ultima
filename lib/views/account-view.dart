import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';
import 'package:ultima/views/welcome-view.dart';



class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final storage = const FlutterSecureStorage();
  List<ListSetting> list_setting = [
    ListSetting(title: "Reward", icon: Icon(FeatherIcons.award,size: 19.sp,color: Color(0xFF0B1F4F),)),
    // ListSetting(title: "Favourite Items", icon: Icon(FeatherIcons.heart,size: 19.sp,color: Color(0xFF0B1F4F),)),
    // ListSetting(title: "History", icon: Icon(FeatherIcons.clock,size: 19.sp,color: Color(0xFF0B1F4F),)),
    ListSetting(title: "Linked Account", icon: Icon(FeatherIcons.link2,size: 19.sp,color: Color(0xFF0B1F4F),)),
    ListSetting(title: "Account", icon: Icon(FeatherIcons.user,size: 19.sp,color: Color(0xFF0B1F4F),)),
    ListSetting(title: "Support", icon: Icon(FeatherIcons.lifeBuoy,size: 19.sp,color: Color(0xFF0B1F4F),)),
    ListSetting(title: "Logout", icon: Icon(FeatherIcons.logOut,size: 19.sp,color: Color(0xFFEF1B1B),)),
  ];
  
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
                      // borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                      ]

                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.5.h,bottom: 1.5.h),
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            CircleAvatar(),
                            SizedBox(width: 2.5.w,),
                            // Text(FirebaseAuth.instance.currentUser!.displayName!,style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 18.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
                            // Text(FirebaseAuth.instance.currentUser!.displayName!.toString(),style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 18.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(1.5.h),
                child: Column(
                  children: [
                    SizedBox(height: 1.5.h,),
                    Container(
                      height: 28.h,
                      child: Row(
                        children: [
                          Container(
                            width : 50.w,
                            decoration: BoxDecoration(
                                // color: Color(0xFF4E82FF),
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [Color(0XFF413DFF), Color(0XFF63A1FF)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                ]
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/profile-point.png',height: 2.5.h,),
                                      SizedBox(width: 1.h,),
                                      Text('Point',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.white)),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Align(alignment: Alignment.centerRight,child: Text('1300',style: GoogleFonts.inter(fontSize: 29.sp,fontWeight: FontWeight.w700,color: Colors.white))),
                                  SizedBox(height: 0.2.h,),
                                  Align(alignment: Alignment.centerRight,child: Text('Expired Date 31/12/66',style: GoogleFonts.inter(fontSize: 13.sp,fontWeight: FontWeight.w500,color: Colors.white))),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 1.5.h,),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(1.5.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset('assets/images/profile-item.png',height: 2.5.h,),
                                          SizedBox(width: 1.h,),
                                          Text('Item Purchases',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF1E439B))),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Align(alignment: Alignment.centerRight,child: Text('5',style: GoogleFonts.inter(fontSize: 29.sp,fontWeight: FontWeight.w700,color: Color(0xFF1E439B)))),
                                      Align(alignment: Alignment.centerRight,child: Text('items',style: GoogleFonts.inter(fontSize: 13.sp,fontWeight: FontWeight.w500,color: Color(0xFF1E439B)))),
                                    ],
                                  ),
                                ),
                              ),

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(blurRadius: 20,spreadRadius: -1,color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2))
                          ]
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            itemCount: list_setting.length,
                            itemBuilder: (context,index){
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onTap: () async {
                                    if(index == 4){
                                      AuthService().logout();
                                      await storage.delete(key: "token");
                                      Get.off(
                                              () => WelcomepageView()
                                      );
                                    }
                                  },

                                  child: Padding(
                                    padding: EdgeInsets.all(1.5.h),
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                list_setting[index].icon,
                                                SizedBox(width: 1.5.h,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(list_setting[index].title,style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 15.5.sp,letterSpacing: 0.3,
                                                        color: list_setting[index].title!='Logout'?Color(0xFF0B1F4F):Color(0xFFEF1B1B)),),
                                                    list_setting[index].title == 'Linked Account' ? Padding(
                                                      padding: EdgeInsets.only(top: 3.w),
                                                      child: Row(
                                                        children: [
                                                          Image.asset('assets/images/facebook-icon.png',height: 4.7.h),
                                                          SizedBox(width : 3.w),
                                                          Image.asset('assets/images/google-icon.png',height: 4.7.h)
                                                        ],
                                                      ),
                                                    ) : Container()
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                Icon(FeatherIcons.chevronRight,size: 20.sp,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListSetting{
  String title;
  Icon icon;


  ListSetting({required this.title, required this.icon, });
}
