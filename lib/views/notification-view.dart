import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: const [
                          // A SlidableAction can have an icon and/or a label.

                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: null,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 7.5.w,
                              backgroundColor: Colors.grey.withOpacity(0.3),
                            ),
                            SizedBox(width: 2.w,),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('แพ็กเกจเอาใจสายเกาจาก The Face Shop 💥💋',overflow:TextOverflow.ellipsis,maxLines: 1,style: GoogleFonts.notoSansThai(fontSize: 14.sp,fontWeight: FontWeight.w700),),
                                  Text('ลดสูงสุด 30% 🤩 เมื่อซื้อผ่าน Shopee Mall',overflow:TextOverflow.ellipsis,maxLines: 1,style: GoogleFonts.notoSansThai(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Color(0xFF606060)),)

                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Today',overflow:TextOverflow.ellipsis,maxLines: 1,style: GoogleFonts.notoSansThai(fontSize: 14.sp,fontWeight: FontWeight.w700),),
                                  Text('',overflow:TextOverflow.ellipsis,maxLines: 1,style: GoogleFonts.notoSansThai(fontSize: 14.sp,fontWeight: FontWeight.w700),),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    // Slidable(
                    //   // Specify a key if the Slidable is dismissible.
                    //   key: const ValueKey(1),
                    //
                    //   // The start action pane is the one at the left or the top side.
                    //   startActionPane: const ActionPane(
                    //     // A motion is a widget used to control how the pane animates.
                    //     motion: ScrollMotion(),
                    //
                    //     // All actions are defined in the children parameter.
                    //     children: [
                    //       // A SlidableAction can have an icon and/or a label.
                    //       SlidableAction(
                    //         onPressed: null,
                    //         backgroundColor: Color(0xFFFE4A49),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.delete,
                    //         label: 'Delete',
                    //       ),
                    //       SlidableAction(
                    //         onPressed: null,
                    //         backgroundColor: Color(0xFF21B7CA),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.share,
                    //         label: 'Share',
                    //       ),
                    //     ],
                    //   ),
                    //
                    //   // The end action pane is the one at the right or the bottom side.
                    //   endActionPane: ActionPane(
                    //     motion: const ScrollMotion(),
                    //     dismissible: DismissiblePane(onDismissed: () {}),
                    //     children: const [
                    //       SlidableAction(
                    //         // An action can be bigger than the others.
                    //         flex: 2,
                    //         onPressed: null,
                    //         backgroundColor: Color(0xFF7BC043),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.archive,
                    //         label: 'Archive',
                    //       ),
                    //       SlidableAction(
                    //         onPressed: null,
                    //         backgroundColor: Color(0xFF0392CF),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.save,
                    //         label: 'Save',
                    //       ),
                    //     ],
                    //   ),
                    //
                    //   // The child of the Slidable is what the user sees when the
                    //   // component is not dragged.
                    //   child: const ListTile(title: Text('Slide me')),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              height: 14.h,
              decoration: BoxDecoration(
                  color: Colors.white,
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
