import 'package:finwise/Screens/Auth/auth_controller.dart';
import 'package:finwise/Screens/Auth/residential_page.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/app_bar_widget.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:finwise/Utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities/finease_logo.dart';
import '../Home/home_page.dart';

class LoginPageScreen extends StatelessWidget {
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AuthController>(AuthController());
    // regSteps = 1;
    return Scaffold(
      appBar: fineaseAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizeBox(20, 0),
                  Text(
                    'Login',
                    style: Get.theme.kMedTitleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 20, left: 20, right: 20),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Get.theme.curveBG,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                            key: controller.loginKey,
                            child: Column(
                              children: [
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter your Email address';
                                      }
                                    },
                                    controller: controller.emailAddress,
                                    icon: Icons.email_outlined,
                                    label: 'Email Address'),
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                    },
                                    controller: controller.password,
                                    obscureText: true,
                                    icon: Icons.key_rounded,
                                    label: 'Password'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Login\nto the app',
                                        style: Get.theme.kMedTitleTextStyle,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Get.theme.colorAccent),
                                      child: IconButton(
                                          onPressed: () => {controller.login()},
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Get.theme.btnTextCol,
                                            size: 20,
                                          )),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
