import 'package:finwise/AddFunds/add_funds_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/TransferMoney/transfer_money_controller.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:finwise/Utilities/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put<TransferMoneyController>(TransferMoneyController());
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
            Obx(() => controller.paymentStatus.value == "success"
                ? Column(
                    children: [
                      LottieBuilder.asset("assets/images/success.json"),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "₹${controller.amountController.text} transferred successfully",
                          style: Get.theme.kBigTextStyle
                              .copyWith(color: Colors.white, fontSize: 40),
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
                          LottieBuilder.asset("assets/images/failed.json"),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "₹${controller.amountController.text} transferred failed",
                              style: Get.theme.kBigTextStyle
                                  .copyWith(color: Colors.white, fontSize: 40),
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Obx(() => Text(
                                  "₹${controller.balanceController.balance.value}",
                                  style: Get.theme.kBigTextStyle.copyWith(
                                      color: Colors.amber, fontSize: 40),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Transfer Money",
                              style: Get.theme.kTitleTextStyle,
                            ),
                          ),
                          // QrImageView(data: controller.homeController.user.value.upi??"", size: 200,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Select the amount you want to transfer",
                              style: Get.theme.kSubTitleTextStyle,
                            ),
                          ),
                          // show a input to add balance
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: controller.amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Enter Amount",
                              ),
                              onChanged: (value) {
                                controller.amount.value = int.parse(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: controller.upiIdController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
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
                          //  secondaryButton(label: "Scan QR Code", icon: Icons.qr_code_scanner_rounded, onTap: ()=>{}),

                          primaryButton(
                              label: "Transfer Money",
                              icon: Icons.currency_rupee_rounded,
                              onTap: () async {
                                await controller.transferMoney();
                              })
                        ],
                      )),
          ],
        ),
      )),
    );
  }
}
