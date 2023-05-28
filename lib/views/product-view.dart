import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:ultima/views/point-navigated-view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'camera-view.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  var isShow = false;
  var scape = Scraper();

  @override
  void initState() {
    // TODO: implement initState
    startScrape();

    super.initState();



  }
  @override
  void dispose(){

    setState(() {
      Get.find<userController>().image.value = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2048px-Solid_white.svg.png';

    });

    super.dispose();
  }
  startScrape() async {
    // print(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]);

    // launchUrl(Uri.parse(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]),
    //   mode: LaunchMode.externalApplication,
    // );
    var my = await scape.getSuggest(Get.find<userController>().skincare.value[Get.arguments].l_link.value[0]);
    // print(my);
    var x = my.toString().substring(my.toString().indexOf('image" content="')).substring(16);
    var y = x.substring(0,x.indexOf('"'));
    print(y);

    var pdt_name = my.toString().substring(my.toString().indexOf('"pdt_name')).substring(14);
    var pdt_name_fin = pdt_name.substring(0,pdt_name.indexOf('"')-1);
    print(pdt_name_fin);

    var pdt_price = my.toString().substring(my.toString().indexOf('"pdt_price')).substring(15);
    var pdt_price_fin = pdt_price.substring(0,pdt_price.indexOf('"')-1);
    print(pdt_price_fin);

    setState(() {
      Get.find<userController>().image.value = y;
      Get.find<userController>().pdt_name.value = pdt_name_fin;
      Get.find<userController>().pdt_price.value = pdt_price_fin;
    });
    // print(pdt_name);
    // print(my.indexOf('<meta name="og:url" content="'));
    //

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              height: 11.5.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<userController>().skincare.value[Get.arguments].p_brand.value,style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Color(0xFF9D9D9D)),
                          ),
                          SizedBox(height: .5.h,),
                          Text(
                            Get.find<userController>().skincare.value[Get.arguments].p_name.value,maxLines: 2,style: GoogleFonts.inter(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 18.sp),
                          )
                        ],),
                    ),
                  ),
                  // Spacer(),


                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // height: 100.h,
                  // width: 100.w,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20.h,
                        width: 100.w,
                        // color: Colors.black,
                        child:Image.network(Get.find<userController>().skincare.value[Get.arguments].p_img.value),

                      ),
                      SizedBox(height: 3.h,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text('Description',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                      ),
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: GestureDetector(
                            onTap: (){
                              setState(() {
                                isShow = !isShow;
                              });
                            },
                            child: Text(Get.find<userController>().skincare.value[Get.arguments].p_desc.value,maxLines: !isShow?5:100,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF9FA2A8),fontSize: 15.sp,fontWeight: FontWeight.w500),)),
                      ),
                      !isShow&&Get.find<userController>().skincare.value[Get.arguments].p_desc.value.length>250?GestureDetector(
                        onTap: (){
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w,top: 2.h),
                          child: Text('See more',overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5),fontSize: 15.sp,fontWeight: FontWeight.w800),),
                        ),
                      ):Container(),
                      SizedBox(height: 3.h,),

                      Container(
                        width: 100.w,
                        // height: 100.h,
                        color: Color(0xFFF6F8FA),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h,),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Text('Shopping Suggestion',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                              child: GestureDetector(
                                onTap: (){
                                  Get.find<userController>().url.value = Get.find<userController>().skincare.value[Get.arguments].l_link.value[0];
                                  Get.to(
                                          () => PointNavigatedView()
                                  );



                                },
                                child: Container(
                                  width: 45.w,
                                  // height: 30.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(3.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(

                                            imageUrl: Get.find<userController>().image.value,
                                            placeholder: (context, url) => Container(
                                              width: 20.w,
                                              height: 20.w,
                                              color: Colors.transparent,
                                            ),
                                            errorWidget:  (context, text, index) {
                                              return Container(
                                                width: 20.w,
                                                height: 20.w,
                                                color: Colors.transparent,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 1.5.h,),
                                        Text(Get.find<userController>().pdt_name.value ,maxLines: 3,overflow: TextOverflow.ellipsis,style: GoogleFonts.notoSansThai(color: Color(0xFF576580),fontSize: 15.sp,fontWeight: FontWeight.w700,height: 1.2),),
                                        SizedBox(height: 1.5.h,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(Get.find<userController>().pdt_price.value ,style: GoogleFonts.notoSansThai(color: Color(0xFF0B1f4f),fontSize: 15.sp,fontWeight: FontWeight.w700,height: 1.2),),
                                            Spacer(),
                                            CircleAvatar(
                                              radius: 4.w,
                                              foregroundImage: NetworkImage('https://lzd-img-global.slatic.net/g/tps/tfs/TB1PApewFT7gK0jSZFpXXaTkpXa-200-200.png'),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h,)


                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
