import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/services/cosmetic-service.dart';
import 'package:ultima/services/incidecode-scrap.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CosmeticView extends StatefulWidget {
  const CosmeticView({Key? key}) : super(key: key);

  @override
  State<CosmeticView> createState() => _CosmeticViewState();
}

class _CosmeticViewState extends State<CosmeticView> {
  
  var scape = Scraper();


  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startScrape();
    
  }

  startScrape() async {
    // print(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]);

    // launchUrl(Uri.parse(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]),
    //   mode: LaunchMode.externalApplication,
    // );
    var my = await scape.getSuggest(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]);
    print(my);
    var x = my.toString().substring(my.toString().indexOf('image" content="')).substring(16);
    var y = x.substring(0,x.indexOf('"'));
    print(y);

    
    // print(my.indexOf('<meta name="og:url" content="'));
    //

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 100.h,
            width: 100.w,
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              Get.find<userController>().cosmetic.value[Get.arguments].cos_brand.value,style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Color(0xFF9D9D9D)),
                            ),
                            SizedBox(height: .5.h,),
                            Text(
                              Get.find<userController>().cosmetic.value[Get.arguments].cos_name.value,maxLines: 2,style: GoogleFonts.inter(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 18.sp),
                            )
                          ],),
                        ),
                      ),
                      // Spacer(),
                      Get.find<userController>().cosmetic.value[Get.arguments].cos_istryon.value?Padding(
                        padding: EdgeInsets.only(left: 10.w,top: 1.5.h,right: 5.w),
                        child: Container(
                          width: 20.w,
                          decoration: BoxDecoration(
                              color: Color(0xFF4E82FF),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: .5.h,horizontal: .5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Boxicons.bx_brush,color: Colors.white,size: 20.sp,),
                                SizedBox(width: 1.w,),
                                Text('Try-on',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w700),)
                              ],
                            ),
                          ),
                        ),
                      ):Spacer()


                    ],
                  ),
                ),
                Container(
                  height: 20.h,
                  width: 100.w,
                  // color: Colors.black,
                  child:Image.network(Get.find<userController>().cosmetic.value[Get.arguments].cos_img.value[0]),

                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                      height: 4.h,
                      child: ListView.builder(padding: EdgeInsets.zero
                      ,scrollDirection: Axis.horizontal,itemCount: Get.find<userController>().cosmetic.value[Get.arguments].cos_color_img.value.length ,itemBuilder: (context,colorIndex){

                        return colorIndex==7?Center(child: Text("  +${Get.find<userController>().cosmetic.value[Get.arguments].cos_color_img.value.length-7}",style: GoogleFonts.inter(color: Color(0xFF9FA2A8),fontWeight: FontWeight.w600),)):colorIndex>6?Container():Padding(
                          padding: EdgeInsets.only(right: 1.2.w),
                          child: CircleAvatar(
                            // backgroundColor: Get.find<userController>().cosmetic.value[index].cos_color_img.value[index],
                            backgroundColor: Colors.white,
                            foregroundImage: NetworkImage(Get.find<userController>().cosmetic.value[Get.arguments].cos_color_img.value[colorIndex]),
                            radius: 5.w,
                          ),
                        );
                      })),
                ),
                SizedBox(height: 2.h,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text('Description',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                ),
                SizedBox(height: 2.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(Get.find<userController>().cosmetic.value[Get.arguments].cos_desc.value,style: GoogleFonts.inter(color: Color(0xFF9FA2A8),fontSize: 14.sp,fontWeight: FontWeight.w500),),
                ),
                SizedBox(height: 3.h,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text('Shopping Suggestion',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
