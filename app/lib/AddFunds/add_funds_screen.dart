import 'package:finwise/AddFunds/add_funds_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/number_formatter.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddFundsScreen extends StatelessWidget {
  const AddFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AddFundsController>(AddFundsController());
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => Text(
                    "₹ ${controller.balanceController.balance.value.toString().formatNumber()}",
                    style: Get.theme.kBigTextStyle
                        .copyWith(color: Colors.amber, fontSize: 40),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Add Funds to your wallet",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Select the amount you want to add to your wallet",
                style: Get.theme.kSubTitleTextStyle,
              ),
            ),
            // show a input to add balance
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: controller.amountTextController,
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
            // show price chips to add balance
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "100";
                      controller.amount.value = 100;
                    },
                    child: const Chip(
                      label: Text("₹ 100"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "200";
                      controller.amount.value = 200;
                    },
                    child: const Chip(
                      label: Text("₹ 200"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "500";
                      controller.amount.value = 500;
                    },
                    child: const Chip(
                      label: Text("₹ 500"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "1000";
                      controller.amount.value = 1000;
                    },
                    child: const Chip(
                      label: Text("₹ 1000"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "2000";
                      controller.amount.value = 2000;
                    },
                    child: const Chip(
                      label: Text("₹ 2000"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.amountTextController.text = "5000";
                      controller.amount.value = 5000;
                    },
                    child: const Chip(
                      label: Text("₹ 5000"),
                    ),
                  ),
                ],
              ),
            ),
            // show a button to add balance
            primaryButton(
                label: "Add Funds",
                icon: Icons.currency_rupee_rounded,
                onTap: () async {
                  await controller.makePayment();
                })
          ],
        ),
      )),
    );
  }
}
