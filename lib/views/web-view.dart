import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/views/navigated-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;
  @override
  void initState() {

    print(Get.arguments);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent('Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {

          },
          onWebResourceError: (WebResourceError error) {},
          onUrlChange: (UrlChange){
            if(UrlChange.url!=Get.arguments){
              launchUrl(Uri.parse(Get.arguments),
                  mode: LaunchMode.externalApplication,
              );
              print(UrlChange.url);
              Get.off(
                  () => NavigatedView(),
                arguments: UrlChange.url
              );
            }

          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            // if(request.url==(Get.arguments)){
              return NavigationDecision.navigate;

            // }else{
            //   return NavigationDecision.prevent;
            // }
          },
        ),
      )
      ..loadRequest(Uri.parse(Get.arguments));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(height:100.h,child: SafeArea(top: false,child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: WebViewWidget(controller: controller),
          ))),

          Container(
            height: 12.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight:Radius.circular(0)),
                boxShadow: [
                  BoxShadow(blurRadius: 24,spreadRadius: 1,color: Colors.black.withOpacity(0.20),offset: Offset(13,-13))
                ]

            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(EvaIcons.arrowBack,color: Color(0xFF4E82FF),))
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
