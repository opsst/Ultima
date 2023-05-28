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
import 'package:ultima/services/service.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/point-navigated-view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'camera-view.dart';

class CosmeticView extends StatefulWidget {
  const CosmeticView({Key? key}) : super(key: key);

  @override
  State<CosmeticView> createState() => _CosmeticViewState();
}

class _CosmeticViewState extends State<CosmeticView> {
  
  var scape = Scraper();
  APIService service = APIService();
  //
  // var image = '';
  // var pdt_name = '';
  // var pdt_price = '';
  //
  
  var fightAcne = false;
  var brightening = false;
  var moisturizer = false;
  var soothing = false;
  var uvProtection = false;
  var antioxidant = false;
  var preservation = false;
  var exfoliant = false;
  var perfuming = false;
  var antibacterial = false;



  var isShow = false;
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

    service.getIngCos(Get.find<userController>().cosmetic.value[Get.arguments].id.value).then((value) {
      print(value.data['data'].length);
      for(var i=0; i<value.data['data'].length ; i++){
        print(value.data['data'][i][0]['func'].toString());

        if(value.data['data'][i][0]['func'].toString().contains('perfuming')){
          setState(() {
            perfuming =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('skin brightening')){
          setState(() {
            brightening =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('moisturizer/humectant')){
          setState(() {
            moisturizer =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('soothing')){
          setState(() {
            soothing =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('sunscreen')){
          setState(() {
            uvProtection =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('antioxidant')){
          setState(() {
            antioxidant  =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('preservative')){
          setState(() {
            preservation =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('exfoliant')){
          setState(() {
            exfoliant =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('antimicrobial/antibacterial')){
          setState(() {
            antibacterial =true;
          });
        }

        if(value.data['data'][i][0]['func'].toString().contains('anti-acne')){
          setState(() {
            fightAcne =true;
          });
        }
      }

    });
    // print(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]);

    // launchUrl(Uri.parse(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]),
    //   mode: LaunchMode.externalApplication,
    // );
    var my = await scape.getSuggest(Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0]);
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
                    child: GestureDetector(
                      onTap: (){
                        if (Get.find<userController>().cosmetic.value[Get.arguments].cos_cate.value == 'Lipstick'){
                          for(var i = 0; i<Get.find<userController>().lipstick.value.length; i++){
                            if(Get.find<userController>().cosmetic.value[Get.arguments].id.value==Get.find<userController>().lipstick.value[i].id.value){
                              Get.find<userController>().currentExtent.value = 50.h;
                              Get.find<userController>().lipSelect.value = Get.find<userController>().cosmetic.value[Get.arguments].cos_tryon_name.value[0];
                              Get.find<userController>().lipIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 3;
                              Get.find<userController>().modeSelect.value = 1;
                              Get.off(
                                      () => CameraView()
                              );
                            }
                          }
                        }
                        else if (Get.find<userController>().cosmetic.value[Get.arguments].cos_cate.value == 'Eyeshadows'){
                          for(var i = 0; i<Get.find<userController>().eyeshadow.value.length; i++){
                            if(Get.find<userController>().cosmetic.value[Get.arguments].id.value==Get.find<userController>().eyeshadow.value[i].id.value){
                              Get.find<userController>().currentExtent.value = 50.h;
                              Get.find<userController>().eyeSelect.value = Get.find<userController>().cosmetic.value[Get.arguments].cos_tryon_name.value[0];
                              Get.find<userController>().eyeIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 1;
                              Get.find<userController>().modeSelect.value = 1;
                              Get.off(
                                      () => CameraView()
                              );
                            }
                          }
                        }
                        else if (Get.find<userController>().cosmetic.value[Get.arguments].cos_cate.value == 'Blush on'){
                          for(var i = 0; i<Get.find<userController>().blushOn.value.length; i++){
                            if(Get.find<userController>().cosmetic.value[Get.arguments].id.value==Get.find<userController>().blushOn.value[i].id.value){
                              Get.find<userController>().currentExtent.value = 50.h;
                              Get.find<userController>().blushSelect.value = Get.find<userController>().cosmetic.value[Get.arguments].cos_tryon_name.value[0];
                              Get.find<userController>().blushIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 2;
                              Get.find<userController>().modeSelect.value = 1;
                              Get.off(
                                      () => CameraView()
                              );
                            }
                          }
                        }


                      },
                      child: Container(
                        width: 25.w,
                        decoration: BoxDecoration(
                            color: Color(0xFF4E82FF),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: .8.h,horizontal: .5.w),
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
                    ),
                  ):Spacer()


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
                        child:Image.network(Get.find<userController>().cosmetic.value[Get.arguments].cos_img.value[0]),

                      ),
                      SizedBox(height: 3.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w,),
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
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                            child: Text(Get.find<userController>().cosmetic.value[Get.arguments].cos_desc.value,maxLines: !isShow?5:100,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF9FA2A8),fontSize: 15.sp,fontWeight: FontWeight.w500),)),
                      ),
                      !isShow&&Get.find<userController>().cosmetic.value[Get.arguments].cos_desc.value.length>250?GestureDetector(
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
                      (  fightAcne || brightening ||
                       moisturizer ||
                       soothing ||
                       uvProtection ||
                       antioxidant ||
                       preservation ||
                       exfoliant ||
                       perfuming ||
                       antibacterial
                      )?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text('Highlight Ingredients',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                          ),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Wrap(
                              spacing: 2.w,
                              runSpacing: 1.w,
                              children: [
                                brightening?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFBA2797)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Brightening.png',width: 5.w,),
                                        SizedBox(width: 2.w,),
                                        Text('Skin Brightening',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                antibacterial?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF5E0E94)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Antibacterial.png',width: 5.w,),
                                        SizedBox(width: 2.w,),
                                        Text('Antibacterial',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),

                                antioxidant?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF2C0398)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Antioxidant.png',width: 5.w,),
                                        SizedBox(width: 2.w,),
                                        Text('Antioxidant',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                moisturizer?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF2B64AD)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Moisturizer.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Moisturizer',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                exfoliant?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF439697)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Exfoliant.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Exfoliant',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                fightAcne?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF52B535)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Fight Acne.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Fight Acne',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),

                                perfuming?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFF09F39)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Perfuming.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Perfuming',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                preservation?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFEC6F2E)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Preservation.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Preservation',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                soothing?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFE84826)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Soothing.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Soothing',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                                uvProtection?Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFFE93324)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                                    child: Wrap(
                                      children: [
                                        Image.asset('assets/images/Sunscreen.png',width: 5.w,),
                                        SizedBox(width: 1.w,),
                                        Text('Sunscreen',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ):Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.5.h,),

                        ],
                      ):Container(),


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
                                  Get.find<userController>().url.value = Get.find<userController>().cosmetic.value[Get.arguments].l_link.value[0];
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
