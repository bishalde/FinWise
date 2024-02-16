import 'dart:convert';

import 'package:finwise/AddFunds/add_funds_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/TransferMoney/transfer_money_controller.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/number_formatter.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:finwise/Utilities/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slider_button/slider_button.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<TransferMoneyController>(TransferMoneyController());
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? qrController;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Obx(() => controller.qrScanned.value
                ? Column(
                    children: [
                      Obx(
                        () => controller.paymentStatus.value == "success"
                            ? Column(
                                children: [
                                  LottieBuilder.asset(
                                      "assets/images/success.json"),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "₹ ${controller.amountController.text.formatNumber()} transferred successfully",
                                      style: Get.theme.kTitleTextStyle.copyWith(
                                          color: Colors.white, fontSize: 40),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // transaction id
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Transaction Id: ${controller.transId.value}",
                                      style: Get.theme.kSubTitleTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  primaryButton(
                                      label: "Go Back",
                                      icon: Icons.arrow_back_ios_rounded,
                                      onTap: () {
                                        Get.back();
                                      })
                                ],
                              )
                            : controller.paymentStatus.value == "failed"
                                ? Column(
                                    children: [
                                      LottieBuilder.asset(
                                          "assets/images/failed.json"),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "₹${controller.amountController.text} transferred failed",
                                          style: Get.theme.kBigTextStyle
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 40),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      primaryButton(
                                          label: "Go Back",
                                          icon: Icons.arrow_back_ios_rounded,
                                          onTap: () {
                                            Get.back();
                                          })
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "Transfer to ${controller.qrData.value["name"]}\nUPI Id: ${controller.qrData.value["upi"]}",
                                            style: Get.theme.kSubTitleTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextFormField(
                                          controller:
                                              controller.amountController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: "Enter Amount",
                                            prefixIcon: const Icon(
                                                Icons.currency_rupee_rounded),
                                          ),
                                          onChanged: (value) {
                                            controller.amount.value =
                                                int.parse(value);
                                          },
                                        ),
                                      ),
                                      sizeBox(20, 0),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            ...controller.categories.map((e) {
                                              return Obx(() => ActionChip(
                                                  backgroundColor: controller
                                                              .category.value ==
                                                          e
                                                      ? Get.theme.colorSecondary
                                                      : Get.theme.curveBG,
                                                  labelStyle: Get.theme
                                                      .kVerySmallTextStyle!
                                                      .copyWith(
                                                          color: controller
                                                                      .category
                                                                      .value ==
                                                                  e
                                                              ? Colors.black
                                                              : Colors.grey),
                                                  label: Text(e),
                                                  onPressed: () {
                                                    controller.category.value =
                                                        e;
                                                  }));
                                            }),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                      ),
                      sizeBox(100, 0),
                      SliderButton(
                        action: () async {
                          controller.paymentStatus.value = "loading";
                          await controller.transferMoney();
                        },
                        label: Text(
                          "Slide to Transfer",
                          style: Get.theme.kMedTitleTextStyle!
                              .copyWith(color: Colors.green),
                        ),
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                        vibrationFlag: true,
                        backgroundColor: Get.theme.curveBG,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 350,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated:
                                  (QRViewController qrDataController) {
                                qrDataController.scannedDataStream
                                    .listen((event) {
                                  controller.qrData.value =
                                      jsonDecode(event.code ?? "{}");
                                  debugPrint(event.code ?? "{}");
                                  controller.upiId.value =
                                      controller.qrData.value["upi"];
                                  controller.qrScanned.value = true;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      sizeBox(20, 0),
                      Center(
                          child:
                              Text("Or", style: Get.theme.kMedTitleTextStyle)),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: controller.upiIdController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await controller.getUPIData();
                                  controller.qrScanned.value = true;
                                },
                                icon: const Icon(
                                    Icons.arrow_forward_ios_rounded)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Enter UPI Id",
                          ),
                          onChanged: (value) {
                            controller.upiId.value = value;
                          },
                        ),
                      ),
                      sizeBox(20, 0),
                    ],
                  ))
          ],
        ),
      )),
    );
  }
}
