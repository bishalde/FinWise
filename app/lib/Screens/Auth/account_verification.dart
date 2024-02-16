import 'package:finwise/Screens/Auth/auth_controller.dart';
import 'package:finwise/Screens/Auth/account_created_page.dart';
import 'package:finwise/Screens/Auth/legal_page.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/finease_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Utilities/app_bar_widget.dart';
import '../../Utilities/custom_sizebox.dart';
import '../../Utilities/text_field.dart';
import 'package:pinput/pinput.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  final controller = Get.find<AuthController>();
  @override
  void initState() {
    controller.setLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regSteps = 3;
    return Scaffold(
      appBar: fineaseAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizeBox(20, 0),
                  Hero(
                    tag: 'steps',
                    child: CircularStepProgressIndicator(
                      totalSteps: 3,
                      currentStep: regSteps,
                      stepSize: 2,
                      unselectedStepSize: 5,
                      selectedColor: Get.theme.colorPrimaryDark,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 100,
                      height: 100,
                      selectedStepSize: 6,
                      roundedCap: (_, __) => true,
                      child: Center(
                        child: Text(
                          regSteps.toString(),
                          style: Get.theme.kMedTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                  sizeBox(5, 0),
                  Text(
                    'Account Verification',
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
                            key: controller.accVerificationFormKey,
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Account\nVerification',
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
                                          onPressed: () => {
                                                if (controller
                                                    .accVerificationFormKey
                                                    .currentState!
                                                    .validate())
                                                  {
                                                    controller.signUp()
                                                    // Get.off(() =>
                                                    // AccountCreatedPage())
                                                  }
                                              },
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
