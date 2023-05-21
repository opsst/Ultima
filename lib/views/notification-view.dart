import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  WebViewController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }
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
          WebViewWidget(
          controller: controller!,
           ),
            Padding(
              padding: EdgeInsets.only(top: 11.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h,),

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
                        Text('Notification',style: GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 22.sp,letterSpacing: 0.3,color: Color(0xFF0B1F4F)),),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(FeatherIcons.trash2,size: 20.sp,))

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
