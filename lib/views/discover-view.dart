import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/views/search-view.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        primaryFocus!.unfocus();
      },
      child: Container(
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
                    Padding(
                      padding: EdgeInsets.all(2.h),
                      child:GestureDetector(
                        onTap: (){
                          Get.to(
                              () => SearchView()
                          );
                        },
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          enabled: false,
                          cursorHeight: 15.sp,
                          // keyboardType: keyboadType,
                          cursorColor: Color(0xFF858585),
                          style: GoogleFonts.inter(color: Color(0xFF858585),fontSize: 15.sp),
                          decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minHeight: 50,minWidth:13.w,),
                            prefixIcon: Icon(EvaIcons.searchOutline,size: 20.sp,color: Color(0xFF858585),),
                            prefixIconColor: Colors.white,
                            // prefix: SvgPicture.asset('assets/images/search.svg',width: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                gapPadding: (4)
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Colors.white, width: 1),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                  color: Color(0xff3779B9),
                                  width: 2
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Colors.white, width: 1),

                            ) ,
                            // focusColor: Color(0xff1B1E64),
                            // fillColor: Colors.white,
                            label: Text("Search"),
                            labelStyle: GoogleFonts.inter(color: Color(0xFF858585),fontSize: 15.sp),
                            filled: true,

                            // hoverColor: Color(0xff1B1E64),
                            // floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ),

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
                padding: EdgeInsets.only(left: 3.h,right: 2.5.h,bottom: 1.5.h),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Text('Discover',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 22.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
                        Spacer(),
                        Opacity(opacity:0,child: IconButton(onPressed: (){}, icon: Icon(FeatherIcons.maximize,size: 20.sp,)))

                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
