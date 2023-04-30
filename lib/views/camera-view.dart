import 'package:camera/camera.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/config.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {


  final deepArController = CameraDeepArController(config);
  String _platformVersion = 'Unknown';
  bool isRecording = false;
  CameraMode cameraMode = config.cameraMode;
  DisplayMode displayMode = config.displayMode;

  late CameraController controller;
  late CameraDeepArController cameraDeepArController;
  late List<CameraDescription> _cameras;
  bool cameraReady = false;

  var mySystemTheme= SystemUiOverlayStyle.dark
      .copyWith(systemNavigationBarColor: Colors.red);

  @override
  void initState() {
    // cameraInit();
    super.initState();
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
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraReady = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    deepArController?.dispose();
    // controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          Container(
            height: 100.h,
            width: 100.w,
            child: DeepArPreview(deepArController),
            // cameraReady?
            // CameraPreview(
            //   controller!,
            // ):Container()
          ),
          SafeArea(
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    deepArController.switchEffect(CameraMode.filter, 'assets/images/test.deepar');
                  },
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    color: Colors.red,
                    child: Text('test'),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    deepArController.switchEffect(CameraMode.filter, 'assets/images/MakeupLook.deepar');
                  },
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    color: Colors.green,
                    child: Text('test2'),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}
