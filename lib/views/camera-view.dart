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
import 'package:tflite/tflite.dart';
// import 'package:tflite/tflite.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/widget/colorExtension.dart';
import 'dart:io';
import '../services/config.dart';
import '../widget/dragModal.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraView({this.cameras,Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with TickerProviderStateMixin{

  // var Get.find<userController>().modeSelect.value = 0;
  var animationStart = false;

  QRViewController? controller;

  // var Get.find<userController>().cosmeticSelect.value = 0;

  // var Get.find<userController>().lipSelect.value = '';
  // var Get.find<userController>().lipIndex.value = -1;
  // var Get.find<userController>().blushSelect.value = '';
  // var Get.find<userController>().blushIndex.value = -1;
  // var Get.find<userController>().eyeSelect.value = '';
  // var Get.find<userController>().eyeIndex.value = -1;
  // var Get.find<userController>().onCustomize.value = false;
  var customizeIndex = 0;

  String _name = "";


  var cosmeticList = Get.find<userController>().t_cosmetic.value;
  var searchList = Get.find<userController>().t_cosmetic.value;
  var searchWord = '';


  Map<String, int>? classification;

  selectFilter(){
    var filterFinal = 'assets/deepar/'+Get.find<userController>().lipSelect.value + Get.find<userController>().blushSelect.value + Get.find<userController>().eyeSelect.value +'.deepar';
    print(filterFinal);
    if(Get.find<userController>().lipSelect.value.isEmpty && Get.find<userController>().blushSelect.value.isEmpty && Get.find<userController>().eyeSelect.value.isEmpty){
      deepArController.switchEffect('assets/deepar/default.deepar');
    }else{
      deepArController.switchEffect(filterFinal);

    }


  }

  loadModel() async{

    var resultant = await Tflite.loadModel(
        labels: 'assets/model/labels.txt',
        model: 'assets/model/model_unquant.tflite'
    );
    print("Result : $resultant");
  }
  Future<String> applyModelOnImage(String file) async {
    var res = await Tflite.runModelOnImage(
        path: file,
        numResults: 1,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );
    print(res);
    if(res?.length==0){
      return '';
    }
    else if(res![0]['confidence']>0.7){
      print(res![0]['label'].toString().split(' ')[1]);
      return res![0]['label'].toString().split(' ')[1];

    }
    return '';





    // setState(() {
    //   var _result = res!;
    //   // print(_result);
    //   String str = _result[0]["label"];
    //
    //   _name = str.substring(2);
    //   print(_name);
    //   // _confident = _result != null ? (_result[0]['confidence'] * 100.0).toString().substring(0,2) + "%" : "";
    //   // findProduct();
    // });
    // ModalScanProduct.Dialog_Settings(context, _name);
    // int i = 0;
    // List listresult = [];
    // for(i; i<res!.length; i++){
    //   print(res[i]["label"].toString().substring(2));
    //
    //   print(i);
    //   listresult.add(await networkHandler.get("/product/" + res[i]["label"].toString().substring(2)));
    //   print(listresult);
    //
    // }
    // var x = await networkHandler.get("/product/" + res![i]["label"].toString().substring(2));
    // ModalViewProduct.Dialog_Settings(context, json.decode(x));
    // print(x);
    // String y = x.toString();
    // listresult.add(y);
    // print(json.decode(y));
    // print(listresult.add(x));
    // Future.delayed(Duration(seconds: 1),(){
    // print(listresult);
    // ModalViewProduct.Dialog_Settings(context ,listresult);
    // });

    // print(_name+" with "+_confident);
    // print(_result.length);
    // print(_result[1]);


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
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
      setState(() {
        // result = scanData;
      });
    });
  }

  checkState() {

      if(Get.find<userController>().modeSelect.value==1){
        if(deepArController.cameraDirection.toString() == "CameraDirection.rear"){
          deepArController.flipCamera();
        }
        _tabController.animateTo(1);
        setState(() {
          Get.find<userController>().modeSelect.value = Get.find<userController>().modeSelect.value;
          animationStart = true;
        });
        //
        Future.delayed(Duration(milliseconds: 1200)).then((value){
          setState(() {
            animationStart = false;
          });
        });
      }else{
        print(deepArController.cameraDirection.toString());
        if(deepArController.cameraDirection.toString() == "CameraDirection.front"){
          Future.delayed(Duration(milliseconds: 100)).then((value) => deepArController.flipCamera());

        }

        // print(res);
        setState(() {
          Get.find<userController>().modeSelect.value= Get.find<userController>().modeSelect.value;
          animationStart = true;

        });
        Future.delayed(Duration(milliseconds: 1200)).then((value){
          setState(() {
            animationStart = false;
          });

        });

      }

  }

  var mySystemTheme= SystemUiOverlayStyle.dark
      .copyWith(systemNavigationBarColor: Colors.red);

  late TabController _tabController;
  @override
  void initState() {
    loadModel();

    deepArController = DeepArController();
    deepArController.initialize(
        androidLicenseKey: 'a08dcc7e27c80ee1daaeab600bc7d28892388050a29e4f1327369489f6ef025d8dec7635ac0dcf29',
        iosLicenseKey: '7fd8276127f7729ab29b0b3ba765eacc4f62b06d7dcba40c2709e8f29edaa206214e4e717157ff14',
        resolution: Resolution.veryHigh).then((value) => checkState());

    // cameraInit();
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    pageController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    // controller!.dispose();
    deepArController.destroy();

    super.dispose();
    Get.find<userController>().lipSelect.value = '';
    Get.find<userController>().lipIndex.value = -1;
    Get.find<userController>().blushSelect.value = '';
    Get.find<userController>().blushIndex.value = -1;
    Get.find<userController>().eyeSelect.value = '';
    Get.find<userController>().eyeIndex.value = -1;
    Get.find<userController>().onCustomize.value = false;
    Get.find<userController>().customizeIndex.value = 0;
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
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Platform.isAndroid? 85.h : 100.h,
              child: DraggableBottomSheet(
                duration: Duration(milliseconds: 50),
                minExtent: 50.h,
                  useSafeArea: false,maxExtent: Platform.isAndroid? 70.h:80.h, previewWidget: _previewWidget(pageController), backgroundWidget: _backgroundWidget(), expandedWidget: _expandedWidget(), onDragging: (res){}, controller: pageController,),
            ),
          ],
        )
            // :
            // Center(child: CircularProgressIndicator())

      ),
    );
  }


  Widget _backgroundWidget() {
    return Stack(

      alignment: Alignment.bottomCenter,
      children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Platform.isAndroid? 85.h: 100.h,
              // width: 100.w,
              color: Colors.black,
              child:DeepArPreview(deepArController,key: Key('Camera')),
              // cameraReady?
              // CameraPreview(
              //   controller!,
              // ):Container()
            ),
          ],
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
          top: Platform.isAndroid? 32.h:40.h,
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
                      print(index);
                      //   if(_tabController.indexIsChanging){
                      if(index==0){
                        deepArController.switchEffect('assets/deepar/default.deepar');
                        if(deepArController.cameraDirection.toString() == "CameraDirection.front"){

                          deepArController.flipCamera();
                        }
                        setState(() {
                          Get.find<userController>().cosmeticSelect.value = 0;

                           Get.find<userController>().lipSelect.value = '';
                           Get.find<userController>().lipIndex.value = -1;
                           Get.find<userController>().blushSelect.value = '';
                           Get.find<userController>().blushIndex.value = -1;

                           Get.find<userController>().eyeSelect.value = '';
                           Get.find<userController>().eyeIndex.value = -1;

                           Get.find<userController>().onCustomize.value = false;
                           customizeIndex = 0;

                        });

                        // deepArController.switchEffect(CameraMode.effect, 'assets/deepar/b_fenty_straeberrydip.deepar');
                        // controller!.resumePreview();

                        // deepController!.pausePreview();


                      }else{

                        // print(deepArController.cameraDirection);
                        if(deepArController.cameraDirection.toString() == "CameraDirection.rear"){
                          deepArController.flipCamera();
                        }

                        // deepArController.switchEffect(CameraMode.filter, 'assets/deepar/B0.deepar');

                        // controller!.pausePreview();
                        // deepController!.resumePreview();

                      }
                      HapticFeedback.selectionClick();

                      setState(() {
                        Get.find<userController>().modeSelect.value = index;
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
                        child: SvgPicture.asset('assets/icons/barcode.svg',width: 4.w,color: Get.find<userController>().modeSelect.value==0?Colors.black:Colors.white,),
                      ),
                      Tab(
                        child: RotatedBox(quarterTurns:2,child: SvgPicture.asset('assets/icons/star.svg',width: 5.w,color: Get.find<userController>().modeSelect.value==1?Colors.black:Colors.white,)),

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
          top: Platform.isAndroid?30.h:40.h,
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
                    Text('Scan Product',style: TextStyle(fontWeight: FontWeight.w600,color: Get.find<userController>().modeSelect.value==0?Colors.white:Colors.white24),),
                    Spacer(flex: 3,),

                    Text('Cosmetic Try-on',style: TextStyle(fontWeight: FontWeight.w600,color: Get.find<userController>().modeSelect.value==1?Colors.white:Colors.white24),),
                    Spacer(),

                  ],
                ),
              ):SizedBox(
                key: Key("hiddenText"),
              )
          ),
        ),
        Get.find<userController>().modeSelect.value==0?Positioned(bottom:Platform.isAndroid?4.h: 8.h,child: GestureDetector(
          onTap: () async {
            HapticFeedback.selectionClick();
             deepArController.takeScreenshot().then((file) {
               print(file.path);
               applyModelOnImage(file.path).then((result) {
                 for(var i = 0; i< Get.find<userController>().cosmetic.value.length; i++){
                   if(Get.find<userController>().cosmetic.value[i].id.value==result){
                     showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context){
                       return Column(
                         children: [
                           Spacer(flex: 5,),
                           Padding(
                             padding: EdgeInsets.only(right: 5.w),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Container(
                                   // width: 25.w,
                                   height: 4.h,
                                   decoration: BoxDecoration(
                                       color: Color(0xFF4E82FF),
                                       borderRadius: BorderRadius.circular(18)
                                   ),
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal:5.w),
                                     child: Row(
                                       children: [
                                         SvgPicture.asset('assets/icons/brush-on.svg'),
                                         SizedBox(width: 1.w,),
                                         Text('Try-on',style: GoogleFonts.inter(fontSize: 15.sp,fontWeight: FontWeight.w700,color: Colors.white),)
                                       ],
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.symmetric(vertical: 5.w),
                             child: Container(
                               height: 18.h,
                               width: 90.w,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Stack(
                                 alignment: Alignment.topRight,
                                 children: [
                                   Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 3.h),

                                     child: Row(
                                       children: [
                                         Expanded(
                                             flex:3,
                                             child: Center(child: Image.network(Get.find<userController>().cosmetic.value[i].cos_img.value[0]))),
                                         SizedBox(width: 3.w,),
                                         Expanded(
                                             flex:5,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 SizedBox(height: 1.h,),
                                                 Text(Get.find<userController>().cosmetic.value[i].cos_brand.value+" : "+Get.find<userController>().cosmetic.value[i].cos_name.value,maxLines: 3,style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                                                 Spacer(),
                                                 Row(
                                                   children: [
                                                     Text('Tap to see more',style: GoogleFonts.inter(fontSize: 13.sp,color: Color(0xFF717171)),),
                                                     Icon(Icons.arrow_forward_ios_rounded,size: 12.sp,color: Color(0xFF717171),)
                                                   ],
                                                 ),
                                                 SizedBox(height: 1.h,),


                                               ],
                                             )),
                                         Spacer()

                                       ],
                                     ),
                                   ),
                                   Positioned(top: 1.h,right: 1.w,child: IconButton(onPressed: (){
                                     Get.back();
                                   }, icon: Icon(Icons.close,color: Colors.black,size: 20.sp,)))
                                 ],
                               ),
                             ),
                           ),
                           Spacer(),

                         ],
                       );
                     });

                   }
                 }
                 for(var j= 0; j< Get.find<userController>().skincare.value.length;j++ ){
                   if(Get.find<userController>().skincare.value[j].id.value==result){
                     showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context){
                       return Column(
                         children: [
                           Spacer(flex: 5,),
                           Padding(
                             padding: EdgeInsets.symmetric(vertical: 5.w),
                             child: Container(
                               height: 18.h,
                               width: 90.w,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Stack(
                                 alignment: Alignment.topRight,
                                 children: [
                                   Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 3.h),

                                     child: Row(
                                       children: [
                                         Expanded(
                                             flex:3,
                                             child: Center(child: Image.network(Get.find<userController>().skincare.value[j].p_img.value))),
                                         SizedBox(width: 3.w,),
                                         Expanded(
                                             flex:5,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 SizedBox(height: 1.h,),
                                                 Text(Get.find<userController>().skincare.value[j].p_brand.value+" : "+Get.find<userController>().skincare.value[j].p_name.value,maxLines: 3,style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 16.sp),),
                                                 Spacer(),
                                                 Row(
                                                   children: [
                                                     Text('Tap to see more',style: GoogleFonts.inter(fontSize: 13.sp,color: Color(0xFF717171)),),
                                                     Icon(Icons.arrow_forward_ios_rounded,size: 12.sp,color: Color(0xFF717171),)
                                                   ],
                                                 ),
                                                 SizedBox(height: 1.h,),


                                               ],
                                             )),
                                         Spacer()

                                       ],
                                     ),
                                   ),
                                   Positioned(top: 1.h,right: 1.w,child: IconButton(onPressed: (){
                                     Get.back();
                                   }, icon: Icon(Icons.close,color: Colors.black,size: 20.sp,)))
                                 ],
                               ),
                             ),
                           ),
                           Spacer(),

                         ],
                       );
                     });

                   }
                 }
               });
             });
          },
            child: SvgPicture.asset('assets/icons/capture.svg',width: 22.w,))
        ):Container(),
        Get.find<userController>().modeSelect.value==0?Positioned(
          right: 10.w,
          bottom: Platform.isAndroid?4.h:8.h,
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
        ),):Container(),
      ],
    );
  }

  Widget _previewWidget(AnimationController controller) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, 1.5),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticIn)),
      child: Get.find<userController>().modeSelect.value==0?Container():
      Stack(
        children: [
          Flex(
            direction: Axis.horizontal,
            children:[
              Expanded(child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: GestureDetector(
                  onTap: (){
                    Get.find<userController>().cosmeticSelect.value = 0;
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              )),
            ]
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:[
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

                                if(Get.find<userController>().cosmeticSelect.value==1){
                                  setState(() {
                                    Get.find<userController>().cosmeticSelect.value = 0;
                                    Get.find<userController>().onCustomize.value = false;
                                  });
                                }else{
                                  setState(() {
                                    Get.find<userController>().cosmeticSelect.value = 1;
                                    Get.find<userController>().onCustomize.value = false;

                                  });
                                }

                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 150),
                                height: 5.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Get.find<userController>().cosmeticSelect.value==1||Get.find<userController>().eyeSelect.value.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/eyeshadow.svg',color: Get.find<userController>().cosmeticSelect.value==1||Get.find<userController>().eyeSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                      SizedBox(width: 2.w,),
                                      Text('Eyeshadow',style: TextStyle(color: Get.find<userController>().cosmeticSelect.value==1||Get.find<userController>().eyeSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                      Get.find<userController>().eyeSelect.value.isNotEmpty?SizedBox(width: 5.w,):Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Get.find<userController>().eyeSelect.value.isNotEmpty?Positioned(
                              right: 2.w,
                              child: GestureDetector(
                                  onTap: (){

                                setState(() {
                                  Get.find<userController>().eyeSelect.value='';
                                  Get.find<userController>().eyeIndex.value =-1;
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

                                  if(Get.find<userController>().cosmeticSelect.value==2){
                                    setState(() {
                                      Get.find<userController>().cosmeticSelect.value = 0;
                                      Get.find<userController>().onCustomize.value = false;

                                    });
                                  }else{
                                    setState(() {
                                      Get.find<userController>().cosmeticSelect.value = 2;
                                      Get.find<userController>().onCustomize.value = false;

                                    });
                                  }

                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Get.find<userController>().cosmeticSelect.value==2||Get.find<userController>().blushSelect.value.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/brush-on.svg',color: Get.find<userController>().cosmeticSelect.value==2||Get.find<userController>().blushSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                        SizedBox(width: 2.w,),
                                        Text('Blush on',style: TextStyle(color: Get.find<userController>().cosmeticSelect.value==2||Get.find<userController>().blushSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                        Get.find<userController>().blushSelect.value.isNotEmpty?SizedBox(width: 5.w,):Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Get.find<userController>().blushSelect.value.isNotEmpty?Positioned(
                                right: 2.w,
                                child: GestureDetector(
                                    // padding: EdgeInsets.zero,
                                    // splashRadius: 0.4,
                                    onTap: (){
                                      setState(() {
                                        Get.find<userController>().blushSelect.value='';
                                        Get.find<userController>().blushIndex.value =-1;
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
                                  if(Get.find<userController>().cosmeticSelect.value==3){
                                    setState(() {
                                      Get.find<userController>().cosmeticSelect.value = 0;
                                      Get.find<userController>().onCustomize.value = false;

                                    });
                                  }else{
                                    setState(() {
                                      Get.find<userController>().cosmeticSelect.value = 3;
                                      Get.find<userController>().onCustomize.value = false;

                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Get.find<userController>().cosmeticSelect.value==3||Get.find<userController>().lipSelect.value.isNotEmpty?Colors.white:Colors.black.withOpacity(0.55)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/lipstick.svg',color: Get.find<userController>().cosmeticSelect.value==3||Get.find<userController>().lipSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,),
                                        SizedBox(width: 2.w,),
                                        Text('Lipstick',style: TextStyle(color: Get.find<userController>().cosmeticSelect.value==3||Get.find<userController>().lipSelect.value.isNotEmpty?Color(0xFF4E82FF):Colors.white,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                                        Get.find<userController>().lipSelect.value.isNotEmpty?SizedBox(width: 5.w,):Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Get.find<userController>().lipSelect.value.isNotEmpty?Positioned(
                                right: 2.w,
                                child: GestureDetector(

                                    onTap: (){
                                      setState(() {
                                        Get.find<userController>().lipSelect.value='';
                                        Get.find<userController>().lipIndex.value =-1;
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
                                height: Get.find<userController>().cosmeticSelect.value!=0?30.h:0.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                      color: Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                        child: Get.find<userController>().cosmeticSelect.value!=0?Padding(
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
                              SizedBox(height: .5.h,),

                              Text('Swipe up to see more',style: TextStyle(fontSize: 13.sp),),

                              SizedBox(height: .5.h,),
                              Expanded(
                                child: !Get.find<userController>().onCustomize.value?ListView.builder(
                                    key: Key('falseCustomize'),
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 2.h),itemCount: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value.length:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value.length:Get.find<userController>().cosmeticSelect.value==3?Get.find<userController>().lipstick.value.length:0,itemBuilder: (context, index){
                                  return Padding(
                                    padding: EdgeInsets.only(right: 4.w,top: 2.w,bottom: 2.w),
                                    child: GestureDetector(
                                      onTap: (){
                                        // print(Get.find<userController>().cosmeticSelect.value);
                                        // print(index);
                                        if(Get.find<userController>().cosmeticSelect.value==1){
                                          // print(Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]);
                                          if(Get.find<userController>().eyeSelect.value == Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]){
                                            setState(() {
                                              Get.find<userController>().eyeSelect.value = '';
                                              Get.find<userController>().eyeIndex.value = -1;

                                            });
                                          }else{
                                            setState(() {
                                              Get.find<userController>().eyeSelect.value = Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0];
                                              Get.find<userController>().eyeIndex.value = index;

                                            });
                                          }
                                          selectFilter();

                                        }else if(Get.find<userController>().cosmeticSelect.value==2){
                                          // print(Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0]);
                                          if(Get.find<userController>().blushSelect.value == Get.find<userController>().blushOn.value[index].cos_tryon_name.value[0]){
                                            setState(() {
                                              Get.find<userController>().blushSelect.value = '';
                                              Get.find<userController>().blushIndex.value = -1;

                                            });
                                          }else{
                                            setState(() {
                                              Get.find<userController>().blushSelect.value = Get.find<userController>().blushOn.value[index].cos_tryon_name.value[0];
                                              Get.find<userController>().blushIndex.value = index;

                                            });
                                          }
                                          selectFilter();
                                        }else if(Get.find<userController>().cosmeticSelect.value==3){
                                          // print(Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]);
                                          if(Get.find<userController>().lipSelect.value == Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]){
                                            setState(() {
                                              Get.find<userController>().lipSelect.value = '';
                                              Get.find<userController>().lipIndex.value = -1;

                                            });
                                          }else{
                                            setState(() {
                                              Get.find<userController>().lipSelect.value = Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0];
                                              Get.find<userController>().lipIndex.value = index;

                                            });
                                          }
                                          selectFilter();
                                        }

                                      },
                                      child: AnimatedContainer(
                                        height: 6.h,
                                        width: (Get.find<userController>().cosmeticSelect.value==1&&Get.find<userController>().eyeIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==2&&Get.find<userController>().blushIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==3&&Get.find<userController>().lipIndex.value==index)?60.w:34.w,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: (Get.find<userController>().cosmeticSelect.value==1&&Get.find<userController>().eyeIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==2&&Get.find<userController>().blushIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==3&&Get.find<userController>().lipIndex.value==index)?Border.all(color: Color(0xFF4E82FF),width: 3,strokeAlign: BorderSide.strokeAlignInside):null,
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
                                                  (Get.find<userController>().cosmeticSelect.value==1&&Get.find<userController>().eyeIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==2&&Get.find<userController>().blushIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==3&&Get.find<userController>().lipIndex.value==index)?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex:6,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 2.h),
                                                            child: Center(child: Image.network(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_img[0]:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_img[0]:Get.find<userController>().lipstick.value[index].cos_img[0])),
                                                          )),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          children: [
                                                            Expanded(flex: 2,child: Text(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_name.value  :Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_name.value:Get.find<userController>().lipstick.value[index].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),)),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(left: 1.w),
                                                                child: ListView.builder(
                                                                    scrollDirection: Axis.horizontal,
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    itemCount: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value.length:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[index].cos_tryon_name.value.length,
                                                                    itemBuilder: (context,colorIndex){
                                                                      return
                                                                        Padding(
                                                                          padding: EdgeInsets.only(right: 1.w),
                                                                          child: CircleAvatar(
                                                                              radius: 2.5.w,
                                                                              backgroundColor: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[index].cos_tryon_color.value[colorIndex].toString().toColor()
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
                                                                Get.find<userController>().onCustomize.value = !Get.find<userController>().onCustomize.value;
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
                                                            child: Center(child: Image.network(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_img[0]:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_img[0]:Get.find<userController>().lipstick.value[index].cos_img[0])),
                                                          )),
                                                      Expanded(
                                                        flex: 3,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 1.h),
                                                            child: Text(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_name.value  :Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_name.value:Get.find<userController>().lipstick.value[index].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                                          )),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(bottom: 2.h),
                                                          child: ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value.length:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[index].cos_tryon_name.value.length,
                                                              itemBuilder: (context,colorIndex){
                                                                return
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 1.w),
                                                                    child: CircleAvatar(
                                                                        radius: 2.5.w,
                                                                        backgroundColor: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[index].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[index].cos_tryon_color.value[colorIndex].toString().toColor()
                                                                    ),
                                                                  );
                                                              }),
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  (Get.find<userController>().cosmeticSelect.value==1&&Get.find<userController>().eyeIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==2&&Get.find<userController>().blushIndex.value==index)||(Get.find<userController>().cosmeticSelect.value==3&&Get.find<userController>().lipIndex.value==index)?Positioned(
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
                                                    Get.find<userController>().onCustomize.value = !Get.find<userController>().onCustomize.value;
                                                  });

                                                }, child: Padding(
                                                  padding: EdgeInsets.only(left: 2.h,top: 2.h),
                                                  child: Icon(Icons.arrow_back_ios_new,size: 17.sp,),
                                                )),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 1.h,bottom: 1.h,left: 1.w),
                                                  child: Center(child: Image.network(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_img[0]:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[customizeIndex].cos_img[0]:Get.find<userController>().lipstick.value[customizeIndex].cos_img[0])),
                                                ),

                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 2.h,top: 2.h,bottom: 2.h,right: 2.h),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_name.value  :Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[customizeIndex].cos_name.value:Get.find<userController>().lipstick.value[customizeIndex].cos_name.value,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.inter(color: Color(0xFF0B1F4F),fontSize: 16.sp,fontWeight: FontWeight.w700),),
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
                                                        itemCount: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value.length:Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[customizeIndex].cos_tryon_name.value.length:Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value.length,
                                                        itemBuilder: (context,colorIndex){
                                                          return
                                                            Padding(
                                                              padding: EdgeInsets.only(right: 3.w),
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  // print(colorIndex);
                                                                  // print(Get.find<userController>().cosmeticSelect.value);
                                                                  // print(index);
                                                                  if(Get.find<userController>().cosmeticSelect.value==1){
                                                                    // print(Get.find<userController>().eyeshadow.value[index].cos_tryon_name.value[0]);
                                                                    if(Get.find<userController>().eyeSelect.value == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                      setState(() {
                                                                        Get.find<userController>().eyeSelect.value = '';
                                                                        Get.find<userController>().eyeIndex.value = -1;

                                                                      });
                                                                    }else{
                                                                      setState(() {
                                                                        Get.find<userController>().eyeSelect.value = Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                        Get.find<userController>().eyeIndex.value = customizeIndex;

                                                                      });
                                                                    }
                                                                    selectFilter();

                                                                  }else if(Get.find<userController>().cosmeticSelect.value==2){
                                                                    // print(Get.find<userController>().blush_on.value[index].cos_tryon_name.value[0]);
                                                                    if(Get.find<userController>().blushSelect.value == Get.find<userController>().blushOn.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                      setState(() {
                                                                        Get.find<userController>().blushSelect.value = '';
                                                                        Get.find<userController>().blushIndex.value = -1;

                                                                      });
                                                                    }else{
                                                                      setState(() {
                                                                        Get.find<userController>().blushSelect.value = Get.find<userController>().blushOn.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                        Get.find<userController>().blushIndex.value = customizeIndex;

                                                                      });
                                                                    }
                                                                    selectFilter();
                                                                  }else if(Get.find<userController>().cosmeticSelect.value==3){
                                                                    // print(Get.find<userController>().lipstick.value[index].cos_tryon_name.value[0]);
                                                                    if(Get.find<userController>().lipSelect.value == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex]){
                                                                      setState(() {
                                                                        Get.find<userController>().lipSelect.value = '';
                                                                        Get.find<userController>().lipIndex.value = -1;

                                                                      });
                                                                    }else{
                                                                      setState(() {
                                                                        Get.find<userController>().lipSelect.value = Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex];
                                                                        Get.find<userController>().lipIndex.value = customizeIndex;

                                                                      });
                                                                    }
                                                                    selectFilter();
                                                                  }
                                                                },
                                                                child: CircleAvatar(
                                                                  radius: 6.6.w,
                                                                  backgroundColor: (Get.find<userController>().cosmeticSelect.value==1&&Get.find<userController>().eyeSelect.value == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex])||(Get.find<userController>().cosmeticSelect.value==2&&Get.find<userController>().blushSelect.value == Get.find<userController>().blushOn.value[customizeIndex].cos_tryon_name.value[colorIndex])||(Get.find<userController>().cosmeticSelect.value==3&&Get.find<userController>().lipSelect.value == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex])?Color(0xFF1E439B):Colors.white,
                                                                  // backgroundColor: Get.find<userController>().eyeSelect.value == Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_name.value[colorIndex]||Get.find<userController>().blushSelect.value == Get.find<userController>().blush_on.value[customizeIndex].cos_tryon_name.value[colorIndex]||Get.find<userController>().lipSelect.value == Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_name.value[colorIndex]?Color(0xFF1E439B):Colors.white,
                                                                  child: CircleAvatar(
                                                                      radius: 6.w,
                                                                      backgroundColor: Get.find<userController>().cosmeticSelect.value==1?Get.find<userController>().eyeshadow.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().cosmeticSelect.value==2?Get.find<userController>().blushOn.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor():Get.find<userController>().lipstick.value[customizeIndex].cos_tryon_color.value[colorIndex].toString().toColor()
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
                      //     child: Get.find<userController>().cosmeticSelect.value!=0?Container(
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
                              Get.find<userController>().eyeSelect.value = searchList[index].cos_tryon_name.value[0];
                              Get.find<userController>().eyeIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 1;
                              Get.find<userController>().onCustomize.value = false;
                              Get.find<userController>().currentExtent.value = 50.h;
                              // Get.find<userController>().onCompleteSearch.value = true;
                            });
                            print(Get.find<userController>().eyeSelect.value);
                            selectFilter();

                          }

                        }
                        // Get.find<userController>().onCompleteSearch.value = false;


                      }
                      else if (searchList[index].cos_cate.value=='Blush on'){
                        var thisBlush =  Get.find<userController>().blushOn.value;

                        for(var i = 0 ; i<thisBlush.length; i++){
                          if(thisBlush[i].id.value == searchList[index].id.value){
                            setState(() {
                              Get.find<userController>().blushSelect.value = searchList[index].cos_tryon_name.value[0];
                              Get.find<userController>().blushIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 2;
                              Get.find<userController>().onCustomize.value = false;
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
                              Get.find<userController>().lipSelect.value = searchList[index].cos_tryon_name.value[0];
                              Get.find<userController>().lipIndex.value = i;
                              Get.find<userController>().cosmeticSelect.value = 3;
                              Get.find<userController>().onCustomize.value = false;
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


