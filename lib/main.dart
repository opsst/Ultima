import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultima/provider/auth-service.dart';
import 'package:ultima/services/user-controller.dart';
import 'package:ultima/views/navigation-view.dart';
import 'package:ultima/views/splash-view.dart';
import 'package:ultima/views/welcome-view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'dart:ui' as ui;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    flutterLocalNotificationsPlugin.show(
      message.notification!.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          '232312312',
          'asdkasdkaosp',
        ),
        // iOS: IOSNotificationDetails()
      ),
    );
    print('Message also contained a notification: ${message.notification!.title}');
    print('Message also contained a notification: ${message.notification!.body}');

  }
}

void main() async {
  // var initializationSettingsAndroid = AndroidInitializationSettings('launcher_icon'); // <- default icon name is @mipmap/ic_launcher
  // var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  // flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(userController(),permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "Ultima",
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // if(Platform.isAndroid){
  //   var token = await messaging.getToken();
  //   print(token);
  // }


  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);


  runApp(UltimaApp());
}

class UltimaApp extends StatefulWidget {
  const UltimaApp({super.key});

  @override
  State<UltimaApp> createState() => _UltimaAppState();
}

class _UltimaAppState extends State<UltimaApp> {
  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    );
  }

  notification() async {

    super.initState(); const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'mychannel',
      'title',
      description: 'description',
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          android:
          AndroidInitializationSettings('@mipmap/launcher_icon'),
          // iOS: IOSInitializationSettings()),
        ));

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        flutterLocalNotificationsPlugin.show(
          message.notification!.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/launcher_icon',
              importance: Importance.max,
              channelDescription: channel.description,
            ),
            // iOS: IOSNotificationDetails()
          ),
        );
        print('Message also contained a notification: ${message.notification!
            .title}');
        print('Message also contained a notification: ${message.notification!
            .body}');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if(Platform.isAndroid){
      notification();
    }

  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(

      builder: (context, orientation, screenType){
        return  AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GetMaterialApp(
              title: "Ultima",
              theme: _buildTheme(Brightness.light),
              debugShowCheckedModeBanner: false,
              home: SplashView(),
              builder: (context, child) {
                return MediaQuery(
                  child: child!,
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                );
              },
              // home: AuthService().handleAuthState()
              // home: NavigationBarView(),
          ),
        );
      },
    );
  }
}

