import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ultima/services/service.dart';
import 'package:ultima/views/camera-view.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {

  CarouselController carouselController = CarouselController();
  var indicator = 0;
  var imageAds = ['https://theaxo.com/wp-content/uploads/2022/03/Untitled-design-4.jpg','https://www.brandbuffet.in.th/wp-content/uploads/2021/07/Konvy-Free-PR-1.jpg','https://www.truemoney.com/wp-content/uploads/2021/03/truemoneywallet-lazada-shop-pro-031-banner-20220503-1100X550.jpeg'];
  var tabIndex = 0;


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
                      child:TextFormField(
                        textInputAction: TextInputAction.search,

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
                    CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: 3, itemBuilder: (context,index,pageView){
                      return CachedNetworkImage(imageUrl: imageAds[index],fit: BoxFit.fill,  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),);
                    }, options: CarouselOptions(
                      autoPlay: true,autoPlayAnimationDuration: Duration(seconds: 1),
                      viewportFraction: 1,
                      onPageChanged: (index, page){
                        setState(() {
                          indicator = index;
                        });
                        // indicator.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.linear);
                      }
                    )),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h,bottom: 3.h),
                      child: AnimatedSmoothIndicator(count: 3, activeIndex: indicator,effect: ExpandingDotsEffect(expansionFactor: 2.5,dotWidth: 1.h,dotHeight: 1.h,spacing: 1.w,activeDotColor: Color(0xFF4E82FF),dotColor: Color(0xFF9FA2A8)),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Container(height: 13.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4E82FF),
                                      borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2),blurRadius: 30)

                                        ]
                                    ),),
                                ),
                                Image.asset('assets/images/cosmetic-tryon.png',height: 15.h),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 4.h,left: 3.w),
                                        child: Text('Cosmetic\nTry-on',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.white),))),
                              ],
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.bottomLeft,

                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Container(height: 13.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFBBDDFF),
                                        borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2),blurRadius: 30)

                                      ]

                                    ),),
                                ),
                                Image.asset('assets/images/product-discovery.png',height: 15.h,),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 4.h,right: 3.w),
                                        child: Text('Product\nDiscovery',textAlign: TextAlign.right,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.white),))),

                              ],
                            ),
                          ),


                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 2.h),
                      child: Row(
                        children: [
                          Expanded(child: Container(
                            height: 13.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2),blurRadius: 10)
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/menu1.png',height: 4.h,),
                                SizedBox(height: 2.w,),
                                Text('Ingredient\nInvestigator',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Color(0xFF576580))),

                        ],
                            ),
                          )),


                          SizedBox(width:4.w,),

                          Expanded(child: Container(
                            height: 13.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2),blurRadius: 10)
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/menu2.png',height: 4.h,),
                                SizedBox(height: 2.w,),
                                Text('Compare\nProduct',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Color(0xFF576580))),

                              ],
                            ),
                          )),

                          SizedBox(width: 4.w,),
                          Expanded(child: Container(
                            height: 13.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFA5A5A5).withOpacity(0.11),offset: Offset(1,2),blurRadius: 10)
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/menu3.png',height: 4.h,),
                                SizedBox(height: 2.w,),
                                Text('Similar\nFinder',textAlign: TextAlign.center,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Color(0xFF576580))),

                              ],
                            ),
                          )),




                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
                      child: Row(
                        children: [
                          Text('Top Pick',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),
                          Spacer(),
                          Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text('See more',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w600,color: Color(0xFF0B1F4F))),
                                SizedBox(width: 1.w,),
                                Icon(Icons.arrow_forward_ios,size: 16.sp,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 32.h,
                      child: ContainedTabBarView(
                        onChange: (index){
                          print(index);
                          setState(() {
                            tabIndex = index;
                          });
                        },
                        tabs: [
                          Text('Skincare'),
                          Text('Cosmetics'),
                          Text('Perfume'),

                        ],
                        tabBarProperties: TabBarProperties(
                          unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600,fontSize: 14.sp),
                          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 14.sp),
                          padding: EdgeInsets.only(top: 1.h),
                          height: 7.h,
                          width: 70.w,
                          indicatorColor: Color(0xFF4E82FF),
                          indicator: ContainerTabIndicator(
                            padding: EdgeInsets.only(top: 0.5.h),
                            width: 20.w,
                            height: 0.4.h,
                            radius: BorderRadius.circular(8.0),
                          ),
                          indicatorWeight: 3.h,
                            labelColor: Color(0xFF4E82FF),
                            unselectedLabelColor: Color(0xFF9FA2A8),
                          position: TabBarPosition.top,
                            alignment: TabBarAlignment.start,
                          isScrollable: false,

                        ),

                        views: [
                          CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: 3, itemBuilder: (context,index,pageView){
                        return Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.01),blurRadius: 40,spreadRadius: 20)
                              ]
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: Row(
                                children: [
                                  Expanded(flex: 4,child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',)),
                                  Expanded(flex: 7,child: Padding(
                                    padding: EdgeInsets.only(top: 5.w,right: 2.w,bottom: 3.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Pixi Skintreasts Makeup Fixing Mist',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                        SizedBox(height: 1.w,),
                                        Text('Lorem Ipsum is simply 🍌 of the printing and typesetting and doing but I love you. ',overflow: TextOverflow.ellipsis,maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFF9D9D9D))),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                            Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                            Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                            Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                            Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107).withOpacity(0.35),),
                                            SizedBox(width: 0.5.w,),
                                            Text('4.5',maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFFFFC107))),
                                            Spacer(),
                                            Opacity(
                                              opacity: 0,
                                              child: RawChip(backgroundColor:Color(0xFF4E82FF),label: Text('Try-on',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w700),)
                                                , avatar: InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 1.w),
                                                    child: Icon(Boxicons.bx_brush,color: Colors.white,size: 20.sp,),
                                                ),
                                              ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                            SizedBox(width: 1.w,),
                                            Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                          ],
                                        ),



                                      ],
                                    ),
                                  )),

                                ],
                              ),
                            ),
                          ),
                        );
                      }, options: CarouselOptions(
                            enableInfiniteScroll: false,
                          viewportFraction:0.92,
                          onPageChanged: (index, page){
                            setState(() {
                              indicator = index;
                            });
                            // indicator.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.linear);
                          }
                      )),
                          CarouselSlider.builder(
                              carouselController: carouselController,
                              itemCount: 3, itemBuilder: (context,index,pageView){
                            return Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.01),blurRadius: 40,spreadRadius: 20)
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 4,child: CachedNetworkImage(imageUrl: 'https://s2.konvy.com/static/team/2022/0913/16630588358685.jpg',)),
                                      Expanded(flex: 7,child: Padding(
                                        padding: EdgeInsets.only(top: 5.w,right: 2.w,bottom: 3.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Bobbi Brown Skin Full Cover Concealer',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                            SizedBox(height: 1.w,),
                                            Text('Lorem Ipsum is simply 🍌 of the printing and typesetting and doing but I love you. ',overflow: TextOverflow.ellipsis,maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFF9D9D9D))),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                SizedBox(width: 0.5.w,),
                                                Text('4.8',maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFFFFC107))),
                                                Spacer(),
                                                RawChip(backgroundColor:Color(0xFF4E82FF),label: Text('Try-on',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w700),)
                                                  , avatar: InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 1.w),
                                                      child: Icon(Boxicons.bx_brush,color: Colors.white,size: 20.sp,),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                                SizedBox(width: 1.w,),
                                                Text('1,100-1.200 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                              ],
                                            ),



                                          ],
                                        ),
                                      )),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction:0.92,
                              onPageChanged: (index, page){
                                setState(() {
                                  indicator = index;
                                });
                                // indicator.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.linear);
                              }
                          )),

                          CarouselSlider.builder(
                              carouselController: carouselController,
                              itemCount: 3, itemBuilder: (context,index,pageView){
                            return Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.01),blurRadius: 40,spreadRadius: 20)
                                    ]
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 4,child: CachedNetworkImage(imageUrl: 'https://img.kingpowerclick.com/cdn-cgi/image/format=auto/kingpower-com/image/upload/w_1400,h_1400,f_auto/prod/779967-L1.jpg',)),
                                      Expanded(flex: 7,child: Padding(
                                        padding: EdgeInsets.only(top: 5.w,right: 2.w,bottom: 3.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dior Savage Eau De Parfum',overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                            SizedBox(height: 1.w,),
                                            Text('Lorem Ipsum is simply 🍌 of the printing and typesetting and doing but I love you. ',overflow: TextOverflow.ellipsis,maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFF9D9D9D))),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107),),
                                                Icon(Icons.star,size: 16.sp,color: Color(0xFFFFC107).withOpacity(0.35),),
                                                SizedBox(width: 0.5.w,),
                                                Text('4.5',maxLines: 3,style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xFFFFC107))),
                                                Spacer(),
                                                Opacity(
                                                  opacity: 0,
                                                  child: RawChip(backgroundColor:Color(0xFF4E82FF),label: Text('Try-on',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w700),)
                                                    , avatar: InkWell(
                                                      onTap: () {},
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 1.w),
                                                        child: Icon(Boxicons.bx_brush,color: Colors.white,size: 20.sp,),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                                SizedBox(width: 1.w,),
                                                Text('5,600-7,050 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                              ],
                                            ),



                                          ],
                                        ),
                                      )),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction:0.92,
                              onPageChanged: (index, page){
                                setState(() {
                                  indicator = index;
                                });
                                // indicator.animateToPage(index, duration: Duration(milliseconds: 800), curve: Curves.linear);
                              }
                          )),


                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 2.h),
                      child: Row(
                        children: [
                          Text('Hot Deal',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),
                          SizedBox(width: 2.w,),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF4E82FF),
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(1.w),
                              child: Text('21',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w600),),
                            ),
                          ),
                          SizedBox(width: 1.w,),
                          Text(':',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),
                          SizedBox(width: 1.w,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF4E82FF),
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(1.w),
                              child: Text('10',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w600),),
                            ),
                          ),

                          SizedBox(width: 1.w,),
                          Text(':',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),
                          SizedBox(width: 1.w,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF4E82FF),
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(1.w),
                              child: Text('35',style: GoogleFonts.inter(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w600),),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Container(
                        height: 16.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: ExactAssetImage('assets/images/ads.png'),fit: BoxFit.contain,),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 2.h),
                      child: Row(
                        children: [
                          Text('Official Mall',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),
                          Spacer(),
                          Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text('See more',style: GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w600,color: Color(0xFF0B1F4F))),
                                SizedBox(width: 1.w,),
                                Icon(Icons.arrow_forward_ios,size: 16.sp,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Row(
                        children: [
                          Expanded(child: Container(
                            height: 10.h,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),image: DecorationImage(image: ExactAssetImage('assets/images/laz.png'))),
                          )),
                          SizedBox(width: 3.w,),
                          Expanded(child: Container(
                            height: 10.h,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),image: DecorationImage(image: ExactAssetImage('assets/images/shopee.png'))),

                          )),

                          SizedBox(width: 3.w,),

                          Expanded(child: Container(
                            height: 10.h,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12),image: DecorationImage(image: ExactAssetImage('assets/images/konvy.png'))),

                          )),


                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 2.h),
                      child: Row(
                        children: [
                          Text('Discover More',style: GoogleFonts.inter(fontSize: 18.sp,fontWeight: FontWeight.w800,color: Color(0xFF0B1F4F))),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: GridView.count(childAspectRatio: 0.8, crossAxisCount: 2,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,physics: NeverScrollableScrollPhysics(),padding: EdgeInsets.zero,shrinkWrap: true,children: [
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),
                        Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(offset: Offset(3,7),color: Colors.black.withOpacity(0.02),blurRadius: 40,spreadRadius: 20)]),child: Column(
                          children: [
                            Expanded(flex:3,child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                              child: CachedNetworkImage(imageUrl: 'https://perfumestore.ph/wp-content/uploads/2020/07/3-185.jpg',),
                            )),
                            Expanded(flex:2,child: Padding(
                              padding: EdgeInsets.only(left: 2.h,right: 2.h),

                              child: Column(
                                children: [
                                  Text('Bobbi Brown Crushed Lip',maxLines: 2,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF0B1F4F))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_circle_right_outlined,size: 18.sp,color: Color(0xFF576580),),
                                      SizedBox(width: 1.w,),
                                      Text('1,200-1,750 THB',maxLines: 1,style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF576580))),

                                    ],
                                  ),

                                ],
                              ),
                            )),

                          ],
                        ),),




                      ],),
                    ),

                    SizedBox(height: 5.h,)

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
                        Text('Ultima',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 22.sp,letterSpacing: 1,color: Color(0xFF0B1F4F)),),
                        Spacer(),
                        IconButton(onPressed: (){
                          Get.to(
                              () => CameraView()
                          );
                        }, icon: Icon(FeatherIcons.maximize,size: 20.sp,))

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
