import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/user-controller.dart';
import 'camera-view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = TextEditingController();

  var allResult = [];
  var serchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSearch();
  }
  setSearch(){
  Get.find<userController>().cosmetic.value.forEach((element) {
    allResult.add(element.cos_name.value);
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 14.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight:Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                  ]

              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w,right: 5.w),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(EvaIcons.arrowBack)),
                      SizedBox(width: 1.w,),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          onChanged: (value){
                            if(value != ""){
                              var suggest = allResult;
                              // print(suggest);
                              var result = suggest.where((item) {
                                // print(item['coupon']['title']);
                                // print(item['coupon']['title'].toString().toLowerCase().contains(value));
                                return item.toString().toLowerCase().contains(value);
                              }).toList();
                              // print(suggest.runtimeType);
                              print(result);

                              setState(() {
                                serchResult = result;
                              });
                            }else{
                              setState(() {
                                serchResult = [];
                              });
                            }
                          },
                          textInputAction: TextInputAction.search,
                          // enabled: false,
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
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(color: Colors.white, width: 1),

                            ) ,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              borderSide: BorderSide(
                                  color: Color(0xff3779B9),
                                  width: 2
                              ),
                            ),
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
                    ],
                  ),
                ),
              ),

            ),


            SizedBox(height: 2.h,),

            Expanded(
              child: controller.text.isEmpty?Container(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFF3A3A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Center(child: Text('Loreal’s ร่วมกับ Shopee วันนี้ลดสูงสุด 80%',style: GoogleFonts.notoSansThai(color: Color(0xFFFB3737),fontWeight: FontWeight.w600),)),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        Container(
                          height: 5.h,
                          decoration: BoxDecoration(
                              color: Color(0xFFF3A3A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Center(child: Text('ส่วนลดพิเศษบน Sephora เพียงใช้งานผ่าน Ultima',style: GoogleFonts.notoSansThai(color: Color(0xFFFB3737),fontWeight: FontWeight.w600),)),
                          ),
                        ),
                        Spacer()
                      ],
                    )

                  ],
                ),
              ),):ListView.builder(
                physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: serchResult.length ,itemBuilder: (context,index){
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: (){
                        Get.back(result: allResult[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 5.w),
                        child: Row(
                          children: [
                            Icon(EvaIcons.search,color: Colors.grey,size: 18.sp,),
                            SizedBox(width: 2.w,),
                            Text(serchResult[index],style: TextStyle(fontSize: 15.sp),),
                            Spacer(),

                            Icon(EvaIcons.diagonalArrowRightUp,color: Colors.grey)
                          ],
                        ),
                      )),
                );
              }),
            )


          ],
        ),
      ),
    );
  }
}
