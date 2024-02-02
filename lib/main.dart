import 'dart:async';

import 'package:finwise/Screens/Auth/account_created_page.dart';
import 'package:finwise/Screens/Auth/registeration_page.dart';
import 'package:finwise/Screens/Home/home_page.dart';
import 'package:finwise/Screens/OnBoarding/onboarding_screen.dart';
import 'package:finwise/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Themes/theme_service.dart';
import 'Themes/themes.dart';
import 'getx_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await GetStorage.init();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug
  );
    // AwesomeNotifications().initialize(null, [
    //   NotificationChannel(
    //     channelKey: 'edu_notification',
    //     channelName: 'Edu notifications',
    //     channelDescription: 'Education related notifications',
    //     defaultColor: const Color(0xff66DA40),
    //     ledColor: Colors.green,
    //     importance: NotificationImportance.High,
    //     playSound: true,
    //     enableLights: true,
    //     enableVibration: true,
    //   )
    // ]);

    runApp(MyApp());
  }, (error, stack) => {});
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appdata = GetStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 800),
      // transitionDuration: const Duration(milliseconds: 800),
      initialBinding: ControllerBindings(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,

      debugShowCheckedModeBanner: false,
      // getPages: [
      //   GetPage(name: '/', page: () => WebStrakeApp()),
      //   GetPage(name: '/badge', page: () => BadgeScreen()),
      //   GetPage(name: '/state', page: () => StateSelector()),
      //   GetPage(name: '/browser', page: () => WebStrakeBrowser()),
      // ],
      home: checkUser(),
    );
  }

  Widget checkUser() {
    return GetStorage().read("userId")!=null?HomePageScreen():OnBoardingScreen();
  }
}
