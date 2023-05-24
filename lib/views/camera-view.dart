import 'package:camera/camera.dart';
import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/widget/colorExtension.dart';
import 'dart:io';
import '../services/config.dart';
import '../widget/dragModal.dart';

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

  var lipSelect = '';
  var lipIndex = -1;
  var blushSelect = '';
  var blushIndex = -1;
  var eyeSelect = '';
  var eyeIndex = -1;
  var onCustomize = false;
  var customizeIndex = 0;

  var cosmeticList = Get.find<userController>().cosmetic.value;
  var searchList = Get.find<userController>().cosmetic.value;
  var searchWord = '';

  selectFilter(){
    var filterFinal = 'assets/deepar/'+lipSelect + blushSelect + eyeSelect +'.deepar';
    print(filterFinal);
    if(lipSelect.isEmpty && blushSelect.isEmpty && eyeSelect.isEmpty){
      deepArController.switchEffect('assets/deepar/default.deepar');
    }else{
      deepArController.switchEffect(filterFinal);

    }


  }

  late final DeepArController deepArController;
  String _platformVersion = 'Unknown';
  bool isRecording = false;
  // CameraMode cameraMode = config.cameraMode;
  // DisplayMode displayMode = config.displayMode;

  // CameraController? deepController;
  // CameraDeepArController? cameraDeepArController;
  late List<CameraDescription> _cameras;
  bool cameraReady = false;

  // CameraController? controller;
  File? import;
  XFile? pictureFile;
  bool flash = false;
  late AnimationController pageController;

  // Future takePhoto(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //
  //     final imageTemporary = File(image.path);
  //     setState(() {
  //       this.import = imageTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image $e');
  //   }
  // }
  var mySystemTheme= SystemUiOverlayStyle.dark
      .copyWith(systemNavigationBarColor: Colors.red);

  late TabController _tabController;
  @override
  void initState() {

    deepArController = DeepArController();
    deepArController.initialize(androidLicenseKey: 'a08dcc7e27c80ee1daaeab600bc7d28892388050a29e4f1327369489f6ef025d8dec7635ac0dcf29', iosLicenseKey: '7fd8276127f7729ab29b0b3ba765eacc4f62b06d7dcba40c2709e8f29edaa206214e4e717157ff14',resolution: Resolution.veryHigh).then((value) => print(''));

    // cameraInit();
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    pageController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));


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


    // CameraDeepArController.checkPermissions();
    // deepArController.setEventHandler(
    //     DeepArEventHandler(
    //         onCameraReady: (v) {
    //   _platformVersion = "onCameraReady $v";
    //   setState(() {});
    // }, onSnapPhotoCompleted: (v) {
    //   _platformVersion = "onSnapPhotoCompleted $v";
    //   setState(() {});
    // }, onVideoRecordingComplete: (v) {
    //   _platformVersion = "onVideoRecordingComplete $v";
    //   setState(() {});
    // }, onSwitchEffect: (v) {
    //   _platformVersion = "onSwitchEffect $v";
    //   setState(() {});
    // }));

  }


  // cameraInit() async {
  //   _cameras = await availableCameras();
  //
  //   controller = CameraController(
  //     _cameras[0],
  //     ResolutionPreset.max,
  //     imageFormatGroup: ImageFormatGroup.yuv420,
  //   );
  //   controller!.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   });
  //   //
  //   // deepController = CameraController(_cameras[0], ResolutionPreset.max);
  //   // deepController.initialize().then((_) {
  //   //   if (!mounted) {
  //   //     return;
  //   //   }
  //   //   setState(() {
  //   //     cameraReady = true;
  //   //   });
  //   // }).catchError((Object e) {
  //   //   if (e is CameraException) {
  //   //     switch (e.code) {
  //   //       case 'CameraAccessDenied':
  //   //       // Handle access errors here.
  //   //         break;
  //   //       default:
  //   //       // Handle other errors here.
  //   //         break;
  //   //     }
  //   //   }
  //   // });
  // }

  @override
  void dispose() {
    // controller!.dispose();
    deepArController.destroy();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // if (controller==null) {
    //   return const SizedBox(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DraggableBottomSheet(
        duration: Duration(milliseconds: 50),
        minExtent: 50.h,
          useSafeArea: false,maxExtent: 90.h, previewWidget: _previewWidget(pageController), backgroundWidget: _backgroundWidget(), expandedWidget: _expandedWidget(), onDragging: (res){}, controller: pageController,)
          // :
          // Center(child: CircularProgressIndicator())

    );
  }


  Widget _backgroundWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        Container(
          height: 100.h,
          width: 100.w,
          color: Colors.black,
          child:DeepArPreview(deepArController,key: Key('Camera')),
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
                        deepArController.switchEffect('');
                        setState(() {
                          cosmeticSelect = 0;

                           lipSelect = '';
                           lipIndex = -1;
                           blushSelect = '';
                           blushIndex = -1;

                           eyeSelect = '';
                           eyeIndex = -1;

                           onCustomize = false;
                           customizeIndex = 0;

                        });
                        // deepArController.switchEffect(CameraMode.effect, 'assets/deepar/b_fenty_straeberrydip.deepar');
                        // controller!.resumePreview();

                        // deepController!.pausePreview();


                      }else{

                        // deepArController.switchEffect(CameraMode.filter, 'assets/deepar/B0.deepar');

                        // controller!.pausePreview();
                        // deepController!.resumePreview();

                      }
                      HapticFeedback.selectionClick();

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
        modeSelect==0?Positioned(bottom: 8.h,child: GestureDetector(
          onTap: (){
            HapticFeedback.selectionClick();
            dynamic file = deepArController.takeScreenshot();
            print(file.runtimeType);
          },
            child: SvgPicture.asset('assets/icons/capture.svg',width: 22.w,))
        ):Container(),
        modeSelect==0?Positioned(
          right: 10.w,
          bottom: 8.h,
          child:    Padding(
          padding: EdgeInsets.only(right: 5.w,bottom: 4.w),
          child: GestureDetector(
              onTap: () {
            deepArController.flipCamera();
            HapticFeedback.selectionClick();
          }, child: CircleAvatar(radius: 7.w,
              backgroundColor: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.all(1.0.w),
                child: SvgPicture.asset('assets/icons/flip.svg',),
              ))),
        ),):Container()

      ],
    );
  }

  Widget _previewWidget(AnimationController controller) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, 1.5),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticIn)),
      child: modeSelect==0?Container():Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 5.w,bottom: 4.w),
            child: GestureDetector(onTap: () {
              deepArController.flipCamera();
              HapticFeedback.selectionClick();

            }, child: CircleAvatar(radius: 7.w,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Padding(
              padding: EdgeInsets.all(1.0.w),
              child: SvgPicture.asset('assets/icons/flip.svg',),
            ))),
          ),
          SafeArea(
            top: false,
            left: false,
            right: false,
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

                            if(cosmeticSelect==1){
                              setState(() {
                                cosmeticSelect = 0;
                                onCustomize = false;
                              });
                            }else{
                              setState(() {
                                cosmeticSelect = 1;
                                onCustomize = false;

                              });
                            }

                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            height: 5.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: cosmeticSelect==1||eyeSelect.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/eyeshadow.svg',color: cosmeticSelect==1||eyeSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                  SizedBox(width: 2.w,),
                                  Text('Eyeshadow',style: TextStyle(color: cosmeticSelect==1||eyeSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                  eyeSelect.isNotEmpty?SizedBox(width: 5.w,):Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                        eyeSelect.isNotEmpty?Positioned(
                          right: 2.w,
                          child: GestureDetector(
                              onTap: (){

                            setState(() {
                              eyeSelect='';
                              eyeIndex =-1;
                            });
                            selectFilter();

                              }, child: Icon(Icons.close,size: 18.sp,)),
                        ):Container()

                      ],
                    ),
                    SizedBox(width: 2.w,),

                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          GestureDetector(
                            onTap: (){

                              if(cosmeticSelect==2){
                                setState(() {
                                  cosmeticSelect = 0;
                                  onCustomize = false;

                                });
                              }else{
                                setState(() {
                                  cosmeticSelect = 2;
                                  onCustomize = false;

                                });
                              }

                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              height: 5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: cosmeticSelect==2||blushSelect.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/brush-on.svg',color: cosmeticSelect==2||blushSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                    SizedBox(width: 2.w,),
                                    Text('Blush on',style: TextStyle(color: cosmeticSelect==2||blushSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                    blushSelect.isNotEmpty?SizedBox(width: 5.w,):Container()
                                  ],
                                ),
                              ),
                            ),
                          ),

                          blushSelect.isNotEmpty?Positioned(
                            right: 2.w,
                            child: GestureDetector(
                                // padding: EdgeInsets.zero,
                                // splashRadius: 0.4,
                                onTap: (){
                                  setState(() {
                                    blushSelect='';
                                    blushIndex =-1;
                                  });
                                  selectFilter();

                                }, child: Icon(Icons.close,size: 18.sp,)),
                          ):Container(),

                        ],
                      ),


                      SizedBox(width: 2.w,),

                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(cosmeticSelect==3){
                                setState(() {
                                  cosmeticSelect = 0;
                                  onCustomize = false;

                                });
                              }else{
                                setState(() {
                                  cosmeticSelect = 3;
                                  onCustomize = false;

                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              height: 5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: cosmeticSelect==3||lipSelect.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/lipstick.svg',color: cosmeticSelect==3||lipSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                    SizedBox(width: 2.w,),
                                    Text('Lipstick',style: TextStyle(color: cosmeticSelect==3||lipSelect.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                    lipSelect.isNotEmpty?SizedBox(width: 5.w,):Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          lipSelect.isNotEmpty?Positioned(
                            right: 2.w,
                            child: GestureDetector(

                                onTap: (){
                                  setState(() {
                                    lipSelect='';
                                    lipIndex =-1;
                                  });
                                  selectFilter();
                                }, child: Icon(Icons.close,size: 18.sp,)),
                          ):Container()

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
                            child: !onCustomize?ListView.builder(
                                key: Key('falseCustomize'),
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 2.h),itemCount: cosmeticSelect==1?Get.find<userController>().eyeshadow.value.length:cosmeticSelect==2?Get.find<userController>().blush_on.value.length:cosmeticSelect==3?Get.find<userController>().lipstick.value.length:0,itemBuilder: (context, index){
                              return Padding(
                                padding: EdgeInsets.only(right: 4.w,top: 2.w,bottom: 2.w),
                                child: GestureDetector(
                                  onTap: (){
                                    // print(cosmeticSelect);
                                    // print(index);
                                    if(cosmeticSelect==1){
                                      // print(Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]);
                                      if(eyeSelect == Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]){
                                        setState(() {
                                          eyeSelect = '';
                                          eyeIndex = -1;

                                        });
                                      }else{
                                        setState(() {
                                          eyeSelect = Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0];
                                          eyeIndex = index;

                                        });
                                      }
                                      selectFilter();

                                    }else if(cosmeticSelect==2){
                                      // print(Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0]);
                                      if(blushSelect == Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0]){
                                        setState(() {
                                          blushSelect = '';
                                          blushIndex = -1;

                                        });
                                      }else{
                                        setState(() {
                                          blushSelect = Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0];
                                          blushIndex = index;

                                        });
                                      }
                                      selectFilter();
                                    }else if(cosmeticSelect==3){
                                      // print(Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]);
                                      if(lipSelect == Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]){
                                        setState(() {
                                          lipSelect = '';
                                          lipIndex = -1;

                                        });
                                      }else{
                                        setState(() {
                                          lipSelect = Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0];
                                          lipIndex = index;

                                        });
                                      }
                                      selectFilter();
                                    }

                                  },
                                  child: AnimatedContainer(
                                    height: 6.h,
                                    width: (cosmeticSelect==1&&eyeIndex==index)||(cosmeticSelect==2&&blushIndex==index)||(cosmeticSelect==3&&lipIndex==index)?60.w:34.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: (cosmeticSelect==1&&eyeIndex==index)||(cosmeticSelect==2&&blushIndex==index)||(cosmeticSelect==3&&lipIndex==index)?Border.all(color: Color(0xFF4E82FF),width: 3,strokeAlign: BorderSide.strokeAlignInside):null,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.01),
                                              blurRadius: 6,
                                              spreadRadius: 2
                                          )
                                        ]
                                    ),
                                    duration: Duration(milliseconds: 50),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                                          child: Stack(
                                            children: [
                                              (cosmeticSelect==1&&eyeIndex==index)||(cosmeticSelect==2&&blushIndex==index)||(cosmeticSelect==3&&lipIndex==index)?
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:6,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 2.h),
                                                        child: Center(child: Image.network(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_img[0]:cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_img[0]:Get.find<userController>().lipstick.value[index].cos_img[0])),
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        Expanded(flex: 2,child: Text(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_name.value  :cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_name.value:Get.find<userController>().lipstick.value[index].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),)),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 1.w),
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemCount: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value.length:cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[index].cos_tryon_name.value.length,
                                                                itemBuilder: (context,colorIndex){
                                                                  return
                                                                    Padding(
                                                                      padding: EdgeInsets.only(right: 1.w),
                                                                      child: CircleAvatar(
                                                                          radius: 2.5.w,
                                                                          backgroundColor: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_color.value[colorIndex].toString().toColor():cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[index].cos_tryon_color.value[colorIndex].toString().toColor()
                                                                      ),
                                                                    );
                                                                }),
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(bottom: 2.h),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            onCustomize = !onCustomize;
                                                            customizeIndex = index;
                                                          });
                                                        },
                                                        child: Container(
                                                          // height: 3.h,
                                                          // width: 100.w,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF4E82FF),
                                                              borderRadius: BorderRadius.circular(40)
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              SvgPicture.asset('assets/icons/star2.svg',color: Colors.white,width: 4.w,),
                                                              SizedBox(width: 2.w,),
                                                              Text('Customize',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15.sp),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(height: 2.h,)
                                                ],
                                              ):

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:5,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 2.h),
                                                        child: Center(child: Image.network(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_img[0]:cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_img[0]:Get.find<userController>().lipstick.value[index].cos_img[0])),
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(top: 1.h),
                                                        child: Text(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_name.value  :cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_name.value:Get.find<userController>().lipstick.value[index].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(bottom: 2.h),
                                                      child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value.length:cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[index].cos_tryon_name.value.length,
                                                          itemBuilder: (context,colorIndex){
                                                            return
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 1.w),
                                                                child: CircleAvatar(
                                                                    radius: 2.5.w,
                                                                    backgroundColor: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_color.value[colorIndex].toString().toColor():cosmeticSelect==2?Get.find<userController>().blush_on.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[index].cos_tryon_color.value[colorIndex].toString().toColor()
                                                                ),
                                                              );
                                                          }),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              (cosmeticSelect==1&&eyeIndex==index)||(cosmeticSelect==2&&blushIndex==index)||(cosmeticSelect==3&&lipIndex==index)?Positioned(
                                                top: 10,
                                                right: 0,
                                                child: CircleAvatar(
                                                  radius: 3.w,
                                                  backgroundColor: Color(0xFF4E82FF),
                                                  child: Icon(Icons.done,color: Colors.white,size: 15.sp,),
                                                ),
                                              ):Container()
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                                :Padding(
                                  key: Key('trueCustomize'),
                                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.h),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                        ),child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(onTap: (){
                                              setState(() {
                                                onCustomize = !onCustomize;
                                              });

                                            }, child: Padding(
                                              padding: EdgeInsets.all(2.h),
                                              child: Icon(Icons.arrow_back_ios_new,size: 17.sp,),
                                            )),
                                            Padding(
                                              padding: EdgeInsets.only(top: 1.h,bottom: 1.h),
                                              child: Center(child: Image.network(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_img[0]:cosmeticSelect==2?Get.find<userController>().blush_on.value[customizeIndex].cos_img[0]:Get.find<userController>().lipstick.value[customizeIndex].cos_img[0])),
                                            ),

                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 1.w,top: 2.h,bottom: 2.h,right: 2.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(cosmeticSelect==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_name.value  :cosmeticSelect==2?Get.find<userController>().blush_on.value[customizeIndex].cos_name.value:Get.find<userController>().lipstick.value[customizeIndex].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                                    Spacer(),
                                                    Expanded(
                                                      flex: 2,
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                          });
                                                        },
                                                        child: Container(
                                                          // height: 3.h,
                                                          // width: 100.w,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF4E82FF),
                                                              borderRadius: BorderRadius.circular(40)
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [

                                                              Text('See more',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15.sp),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 2.h),
                                              child: Text('Color Palettes',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Color(0xFF576580)),),
                                            ),

                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 1.w),
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    // physics: NeverScrollableScrollPhysics(),
                                                    itemCount: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value.length:cosmeticSelect==2?Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value.length,
                                                    itemBuilder: (context,colorIndex){
                                                      return
                                                        Padding(
                                                          padding: EdgeInsets.only(right: 3.w),
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              // print(colorIndex);
                                                              // print(cosmeticSelect);
                                                              // print(index);
                                                              if(cosmeticSelect==1){
                                                                // print(Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]);
                                                                if(eyeSelect == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                  setState(() {
                                                                    eyeSelect = '';
                                                                    eyeIndex = -1;

                                                                  });
                                                                }else{
                                                                  setState(() {
                                                                    eyeSelect = Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                    eyeIndex = customizeIndex;

                                                                  });
                                                                }
                                                                selectFilter();

                                                              }else if(cosmeticSelect==2){
                                                                // print(Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0]);
                                                                if(blushSelect == Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                  setState(() {
                                                                    blushSelect = '';
                                                                    blushIndex = -1;

                                                                  });
                                                                }else{
                                                                  setState(() {
                                                                    blushSelect = Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                    blushIndex = customizeIndex;

                                                                  });
                                                                }
                                                                selectFilter();
                                                              }else if(cosmeticSelect==3){
                                                                // print(Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]);
                                                                if(lipSelect == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                  setState(() {
                                                                    lipSelect = '';
                                                                    lipIndex = -1;

                                                                  });
                                                                }else{
                                                                  setState(() {
                                                                    lipSelect = Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                    lipIndex = customizeIndex;

                                                                  });
                                                                }
                                                                selectFilter();
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 6.6.w,
                                                              backgroundColor: (cosmeticSelect==1&&eyeSelect == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex])||(cosmeticSelect==2&&blushSelect == Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value[colorIndex])||(cosmeticSelect==3&&lipSelect == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex])?Color(0xFF1E439B):Colors.white,
                                                              // backgroundColor: eyeSelect == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex]||blushSelect == Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value[colorIndex]||lipSelect == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex]?Color(0xFF1E439B):Colors.white,
                                                              child: CircleAvatar(
                                                                  radius: 6.w,
                                                                  backgroundColor: cosmeticSelect==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor():cosmeticSelect==2?Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor()
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                          ),

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
          ),
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 4.w,right: 4.w,bottom: 4.h),

      child: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.all(
              Radius.circular(20)
            ),
          ),
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
              SizedBox(height: 2.h,),
              TextFormField(
                textInputAction: TextInputAction.search,
                onChanged: (value){
                  var suggest = cosmeticList;
                  // print(suggest);
                  var result = suggest.where((item){
                    // print(item.cos_name.value);
                    // print(item['coupon']['title']);
                    // print(item['coupon']['title'].toString().toLowerCase().contains(value));
                    return item.cos_name.value.toString().toLowerCase().contains(value.toLowerCase())||item.cos_brand.value.toString().toLowerCase().contains(value.toLowerCase())||item.cos_cate.value.toString().toLowerCase().contains(value.toLowerCase());
                  }).toList();
                  // print(suggest.runtimeType);
                  // print(result);
                  setState(() {
                    searchList = result;
                    searchWord = value;
                  });
                },
                cursorHeight: 16.sp,
                // keyboardType: keyboadType,
                cursorColor: Color(0xFF858585),
                style: GoogleFonts.inter(color: Color(0xFF858585),fontSize: 16.sp),
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
                  labelStyle: GoogleFonts.inter(color: Color(0xFF858585),fontSize: 16.sp),
                  filled: true,

                  // hoverColor: Color(0xff1B1E64),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),

              searchWord.isNotEmpty?Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  children: [
                    Text('Showing ${searchList.where((element) => element.cos_istryon.value==true).toList().length} result${searchList.where((element) => element.cos_istryon.value==true).toList().length>1?'s':''} of ',style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    Text('"${searchWord}"',style: GoogleFonts.inter(fontWeight: FontWeight.w600,color: Color(0xFF4E82FF)),),
                  ],
                ),
              ):Container(),
              Expanded(
                child: ListView.builder(padding: EdgeInsets.only(top: 2.h),itemCount: searchList.where((element) => element.cos_istryon.value==true).toList().length ,itemBuilder: (context,index){
                  return searchList[index].cos_istryon.value==true?
                  GestureDetector(
                    onTap: (){
                      if(searchList[index].cos_cate.value=='Eyeshadows'){
                        var thisEyes =  Get.find<userController>().eyeshadow.value;

                        for(var i = 0 ; i<thisEyes.length; i++){
                          if(thisEyes[i].id.value == searchList[index].id.value){
                            print(thisEyes[i].cos_tryon_name.value[0]);
                            print(searchList[index].cos_tryon_name.value[0]);

                            setState(() {
                              eyeSelect = searchList[index].cos_tryon_name.value[0];
                              eyeIndex = i;
                              cosmeticSelect = 1;
                              onCustomize = false;
                              Get.find<userController>().currentExtent.value = 50.h;
                              // Get.find<userController>().onCompleteSearch.value = true;
                            });
                            print(eyeSelect);
                            selectFilter();

                          }

                        }
                        // Get.find<userController>().onCompleteSearch.value = false;


                      }
                      else if (searchList[index].cos_cate.value=='Blush on'){
                        var thisBlush =  Get.find<userController>().blush_on.value;

                        for(var i = 0 ; i<thisBlush.length; i++){
                          if(thisBlush[i].id.value == searchList[index].id.value){
                            setState(() {
                              blushSelect = searchList[index].cos_tryon_name.value[0];
                              blushIndex = i;
                              cosmeticSelect = 2;
                              onCustomize = false;
                              Get.find<userController>().currentExtent.value = 50.h;

                            });
                            selectFilter();

                          }
                        }
                      }
                      else if (searchList[index].cos_cate.value=='Lipstick'){
                        var thisLip =  Get.find<userController>().lipstick.value;


                        for(var i = 0 ; i< thisLip.length; i++){
                          if(thisLip[i].id.value == searchList[index].id.value){
                            setState(() {
                              lipSelect = searchList[index].cos_tryon_name.value[0];
                              lipIndex = i;
                              cosmeticSelect = 3;
                              onCustomize = false;
                              Get.find<userController>().currentExtent.value = 50.h;

                            });
                            selectFilter();

                          }
                        }

                      }

                      // Get.back();

                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.h,left: 1.w,right: 1.w),
                      child: Container(
                        height: 22.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 4,
                              spreadRadius: 1
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 2,
                                        child: Image.network(searchList[index].cos_img.value[0],)),
                                    Expanded(
                                      flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: .5.h),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(searchList[index].cos_brand.value+" : "+searchList[index].cos_name.value,maxLines: 2,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontWeight: FontWeight.w700),),
                                              Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF4E82FF),
                                                  borderRadius: BorderRadius.circular(200)
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.w
                                                  ),
                                                  child: Text(searchList[index].cos_cate.value,style: GoogleFonts.inter(color: Colors.white,fontWeight: FontWeight.w500),),
                                                ),

                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(flex: 2,
                                        child: Text(searchList[index].cos_desc.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF9FA2A8).withOpacity(0.75),fontWeight: FontWeight.w500,fontSize: 14.sp))),

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(

                                  children: [
                                  Text('Color',overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF576580),fontWeight: FontWeight.w700,fontSize: 15.sp)),
                                    SizedBox(width: 2.w,),
                                    Expanded(flex: 4,
                                        child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: searchList[index].cos_tryon_color.value.length ,itemBuilder: (context,colorIndex){
                                          return Padding(
                                            padding: EdgeInsets.only(right: 1.w),
                                            child: CircleAvatar(
                                                radius: 3.w,
                                                backgroundColor: searchList[index].cos_tryon_color.value[colorIndex].toString().toColor()
                                            ),
                                          );
                                        }),),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ):Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }


}

