import 'package:camera/camera.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'dart:io';

import '../services/config.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraView({this.cameras,Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with TickerProviderStateMixin{

  var modeSelect = 0;
  var animationStart = false;

  var cosmeticSelect = 0;

  final deepArController = CameraDeepArController(config);
  String _platformVersion = 'Unknown';
  bool isRecording = false;
  CameraMode cameraMode = config.cameraMode;
  DisplayMode displayMode = config.displayMode;

  late CameraController deepController;
  late CameraDeepArController cameraDeepArController;
  late List<CameraDescription> _cameras;
  bool cameraReady = false;

  late CameraController controller;
  File? import;
  XFile? pictureFile;
  bool flash = false;

  Future takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.import = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }


  var mySystemTheme= SystemUiOverlayStyle.dark
      .copyWith(systemNavigationBarColor: Colors.red);

  late TabController _tabController;
  @override
  void initState() {

    cameraInit();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);


    // _tabController.addListener(() {
    //   if(_tabController.indexIsChanging){
    //     setState(() {
    //       modeSelect = (modeSelect+1)%2;
    //       animationStart = true;
    //     });
    //
    //     // Future.delayed(Duration(seconds: 2));
    //     //
    //     // setState(() {
    //     //   animationStart = false;
    //     // });
    //   }
    // });

    CameraDeepArController.checkPermissions();
    deepArController.setEventHandler(DeepArEventHandler(onCameraReady: (v) {
      _platformVersion = "onCameraReady $v";
      setState(() {});
    }, onSnapPhotoCompleted: (v) {
      _platformVersion = "onSnapPhotoCompleted $v";
      setState(() {});
    }, onVideoRecordingComplete: (v) {
      _platformVersion = "onVideoRecordingComplete $v";
      setState(() {});
    }, onSwitchEffect: (v) {
      _platformVersion = "onSwitchEffect $v";
      setState(() {});
    }));

  }


  cameraInit() async {
    _cameras = await availableCameras();

    controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    //
    // deepController = CameraController(_cameras[0], ResolutionPreset.max);
    // deepController.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {
    //     cameraReady = true;
    //   });
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //       // Handle access errors here.
    //         break;
    //       default:
    //       // Handle other errors here.
    //         break;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    deepArController?.dispose();
    // controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Container(
            height: 100.h,
            width: 100.w,
            color: Colors.green,
            child: modeSelect==0?CameraPreview(controller!):DeepArPreview(deepArController),
            // cameraReady?
            // CameraPreview(
            //   controller!,
            // ):Container()
          ),
          Positioned(
            top: 0,
            right: 3.w,
            child: SafeArea(
              child: IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close,color: Colors.white,size: 20.sp,),

              )
            ),
          ),
          Positioned(
            top:40.h,
            left: 3.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(60)
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:1.w,vertical: 1.w),
                  child: SizedBox(
                    height: 13.w,
                    width: 26.w,
                    child: TabBar(
                      onTap: (index){
                        // _tabController.addListener(() {
                        //   if(_tabController.indexIsChanging){
                          if(index==0){
                            controller.pausePreview();


                          }else{
                            controller.resumePreview();
                          }
                            setState(() {
                              modeSelect = index;
                              animationStart = true;
                            });
                        //
                            Future.delayed(Duration(milliseconds: 1200)).then((value){
                              setState(() {
                                animationStart = false;
                              });
                            });


                        //   }
                        // });
                      },
                      controller: _tabController,
                        tabs: [
                          Tab(
                            child: SvgPicture.asset('assets/icons/barcode.svg',width: 4.w,color: modeSelect==0?Colors.black:Colors.white,),
                          ),
                          Tab(
                            child: RotatedBox(quarterTurns:2,child: SvgPicture.asset('assets/icons/star.svg',width: 5.w,color: modeSelect==1?Colors.black:Colors.white,)),

                          )
                    ],
                      // labelStyle: GoogleFonts.prompt(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w400),
                      // unselectedLabelStyle: GoogleFonts.prompt(fontSize: 15.sp,color: Color(0xFF7B7B7B),fontWeight: FontWeight.w400),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicator: RectangularIndicator(

                          topLeftRadius: 200,
                          topRightRadius: 200,
                          bottomLeftRadius: 200,
                          bottomRightRadius: 200,
                          color: Colors.white
                      ),
                    ),

                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.h,
            left: 20.w,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 200),

              child: animationStart?Container(
                key: Key("showText"),
                height: 26.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2,),
                    Text('Scan Product',style: TextStyle(fontWeight: FontWeight.w600,color: modeSelect==0?Colors.white:Colors.white24),),
                    Spacer(flex: 3,),

                    Text('Cosmetic Try-on',style: TextStyle(fontWeight: FontWeight.w600,color: modeSelect==1?Colors.white:Colors.white24),),
                    Spacer(),

                  ],
                ),
              ):SizedBox(
                key: Key("hiddenText"),
              )
            ),
          ),
          Positioned(
            bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child:
                        Row(children: [
                          SizedBox(width: 5.w,),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  cosmeticSelect = 1;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 150),
                                height: 5.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: cosmeticSelect==1?Colors.white:Colors.black.withOpacity(0.55)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/eyeshadow.svg',color: cosmeticSelect==1?Color(0xFF4E82FF):Colors.white,),
                                      SizedBox(width: 2.w,),
                                      Text('Eyeshadow',style: TextStyle(color: cosmeticSelect==1?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                      cosmeticSelect==1?SizedBox(width: 7.w,):Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            cosmeticSelect==1?IconButton(
                              padding: EdgeInsets.zero,
                                splashRadius: 0.4,
                                onPressed: (){
                              setState(() {
                                cosmeticSelect=0;
                              });
                            }, icon: Icon(Icons.close,size: 18.sp,)):Container()

                          ],
                        ),
                        SizedBox(width: 2.w,),

                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cosmeticSelect = 2;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: cosmeticSelect==2?Colors.white:Colors.black.withOpacity(0.55)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/brush-on.svg',color: cosmeticSelect==2?Color(0xFF4E82FF):Colors.white,),
                                        SizedBox(width: 2.w,),
                                        Text('Brush on',style: TextStyle(color: cosmeticSelect==2?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                        cosmeticSelect==2?SizedBox(width: 7.w,):Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              cosmeticSelect==2?IconButton(
                                  padding: EdgeInsets.zero,
                                  splashRadius: 0.4,
                                  onPressed: (){
                                    setState(() {
                                      cosmeticSelect=0;
                                    });
                                  }, icon: Icon(Icons.close,size: 18.sp,)):Container()

                            ],
                          ),


                          SizedBox(width: 2.w,),

                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cosmeticSelect = 3;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: cosmeticSelect==3?Colors.white:Colors.black.withOpacity(0.55)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/lipstick.svg',color: cosmeticSelect==3?Color(0xFF4E82FF):Colors.white,),
                                        SizedBox(width: 2.w,),
                                        Text('Lipstick',style: TextStyle(color: cosmeticSelect==3?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                        cosmeticSelect==3?SizedBox(width: 7.w,):Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              cosmeticSelect==3?IconButton(
                                  padding: EdgeInsets.zero,
                                  splashRadius: 0.4,
                                  onPressed: (){
                                    setState(() {
                                      cosmeticSelect=0;
                                    });
                                  }, icon: Icon(Icons.close,size: 18.sp,)):Container()

                            ],
                          ),




                        ],
          ),
                      ),
                      SizedBox(height: 1.5.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                                height: cosmeticSelect!=0?30.h:0.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                      color: Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                        child: cosmeticSelect!=0?Padding(
                          padding: EdgeInsets.symmetric(vertical:1.h),
                          child: Column(
                            children: [
                              Container(
                                width: 20.w,
                                height: .6.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF717171),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              ),

                              SizedBox(height: 1.h,),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 2.h),itemCount: 4,itemBuilder: (context, index){
                                  return Padding(
                                    padding: EdgeInsets.only(right: 4.w,top: 2.w,bottom: 2.w),
                                    child: AnimatedContainer(
                                      width: 32.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.01),
                                            blurRadius: 6,
                                            spreadRadius: 2
                                          )
                                        ]
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                                            child: Column(
                                              children: [
                                                Container(width: 30.w,height: 30.w,child: Image.network('https://static.beautytocare.com/media/catalog/product/cache/global/image/1300x1300/85e4522595efc69f496374d01ef2bf13/m/a/makeup-revolution-reloaded-eyeshadow-palette-newtrals-3-1-1g-x15.jpg')),
                                                Text('Nars Summer Unrated',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                                Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                      itemCount: 3,
                                                      itemBuilder: (context,index){
                                                    CircleAvatar(
                                                      backgroundColor: Colors.cyan,
                                                    );
                                                  }),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      duration: Duration(milliseconds: 300),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ):SizedBox()
                        ),
                      )
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                      //   child: AnimatedSwitcher(duration: Duration(milliseconds: 50),
                      //     reverseDuration: Duration(milliseconds: 50),
                      //     child: cosmeticSelect!=0?Container(
                      //       key: Key('showCos'),
                      //       height: 32.h,
                      //       decoration: BoxDecoration(
                      //           color: Color(0xFFF9F9F9),
                      //           borderRadius: BorderRadius.circular(12)
                      //       ),
                      //     ):Container(
                      //       key: Key('hideCos'),
                      //     )
                      //   ),
                      // )
                    ],
                  ),
                ),
              ))

        ],
      ),
    );
  }

}
