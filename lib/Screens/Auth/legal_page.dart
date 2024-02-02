import 'package:finwise/Screens/Auth/biometric_verification_screen.dart';
import 'package:finwise/Screens/Auth/auth_controller.dart';
import 'package:finwise/Screens/Auth/residential_page.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/app_bar_widget.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:finwise/Utilities/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities/finease_logo.dart';

class LegalPageScreen extends GetView<AuthController> {
  const LegalPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put<AuthController>(AuthController());
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
                      totalSteps: 4,
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
                    'Legal Documents',
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
                            key: controller.govtFormKey,
                            child: Column(
                              children: [
                                Obx(() => controller.govtIdImage.value != null
                                    ? Image.file(controller.govtIdImage.value!)
                                    : SvgPicture.asset(
                                        'assets/images/card_placeholder.svg',
                                        height: 200,
                                      )),
                                primaryButton(
                                    label: 'Upload your Govt. ID',
                                    icon: Icons.upload,
                                    onTap: () => {controller.pickImage()}),
                                textField(
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return 'Please enter this field';
                                      }
                                    },
                                    controller: controller.govtID,
                                    icon: Icons.payment_outlined,
                                    label: 'Govt. ID Number'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Biometric\nVerification',
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
                                          onPressed: () {
                                            if (controller
                                                .govtFormKey.currentState!
                                                .validate()) {
                                              if (controller
                                                      .govtIdImage.value !=
                                                  null) {
                                                Get.to(() =>
                                                    const BiometricVerificationScreen());
                                              } else {
                                                setSnackBar('Error:',
                                                    'Please upload the document image',
                                                    icon: const Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      color: Colors.red,
                                                    ));
                                              }
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
