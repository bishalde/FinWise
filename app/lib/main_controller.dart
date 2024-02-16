import 'package:finwise/Screens/OnBoarding/user_auth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     Get.off(() => UserAuthPage());
    //   } else {
    //     print('User is signed in!');
    //   }
    // });
    super.onInit();
  }
}
