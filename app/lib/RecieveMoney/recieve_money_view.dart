import 'package:finwise/RecieveMoney/recieve_money_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RecieveMoneyView extends StatelessWidget {
  const RecieveMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<RecieveMoneyController>(RecieveMoneyController());
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeBox(20, 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    'assets/images/left_deco.svg',
                    width: 100,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    'assets/images/right_deco.svg',
                    width: 100,
                  ),
                ),
              ],
            ),
            sizeBox(20, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recieve Money",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(
                "Scan the QR code to recieve money",
                style: Get.theme.kSmallTextStyle,
              ),
            ),
            sizeBox(20, 0),
            Center(
              child: QrImageView(
                data:
                    '{"name":"${controller.homeController.user.value.firstName} ${controller.homeController.user.value.lastName}","upi":"${controller.homeController.user.value.upi}","email":"${controller.homeController.user.value.email}"}',
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.white,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Color.fromARGB(255, 225, 185, 251),
                ),
                size: 280.0,
              ),
            ),
            sizeBox(20, 0),
            Center(
              child: Text(
                "${controller.homeController.user.value.firstName} ${controller.homeController.user.value.lastName}\n${controller.homeController.user.value.upi}",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )),
    );
  }
}
