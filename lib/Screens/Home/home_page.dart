import 'package:carousel_slider/carousel_slider.dart';
import 'package:finwise/AddFunds/add_funds_screen.dart';
import 'package:finwise/Device/radar_screen.dart';
import 'package:finwise/Screens/Advisor/advisor_screen.dart';
import 'package:finwise/Screens/CostManagement/cost_management_view.dart';
import 'package:finwise/Screens/Home/home_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/TransferMoney/transfer_money_screen.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/finease_logo.dart';
import 'package:finwise/Utilities/format_date.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:finwise/Utilities/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slide_action/slide_action.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeController>(HomeController());
    return Scaffold(
        //appBar: fineaseAppBar(),
        body: SafeArea(
            child: RefreshIndicator(
      onRefresh: () async {
        await controller.fetchData();
      },
      child: ListView(
        children: [
          sizeBox(20, 0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Obx(
              () => Text(
                'Hi, ${controller.user.value.firstName} ${controller.user.value.lastName}',
                style: Get.theme.kMedTitleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Obx(
              () => Text(
                'UPI ID: ${controller.user.value.upi}',
                style: Get.theme.kSmallTextStyle,
              ),
            ),
          ),
          sizeBox(30, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AiAdvisorScreen());
                },
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.hub_outlined),
                    ),
                    sizeBox(10, 0),
                    Text(
                      'AI Advisor',
                      style: Get.theme.kSmallTextStyle,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const CostManagementScreen());
                },
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                      ),
                    ),
                    sizeBox(10, 0),
                    Text(
                      'FinScan',
                      style: Get.theme.kSmallTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          sizeBox(30, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Your balance",
              style: Get.theme.kTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Obx(() => Text(
                  "₹${controller.balanceController.balance.value}",
                  style:
                      Get.theme.kTitleTextStyle.copyWith(color: Colors.amber),
                )),
          ),
          secondaryButton(
              label: "Add Funds",
              icon: Icons.add,
              onTap: () {
                Get.to(() => AddFundsScreen());
              }),
          primaryButton(
              label: "Send Money",
              icon: Icons.currency_rupee_rounded,
              onTap: () {
                Get.to(() => TransferMoneyScreen());
              }),
          // Show expenses card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Transactions",
                  style: Get.theme.kMedTitleTextStyle,
                ),
              ),
            ],
          ),
          Obx(() => ListView.builder(
              itemCount: controller.transactions.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        controller.transactions.value[index].type == "credit"
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: controller.transactions.value[index].type ==
                                "credit"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    title: Text(
                      formatDate(DateTime.parse(
                          controller.transactions[index].date ?? '')),
                      style: Get.theme.kSmallTextStyle,
                    ),
                    subtitle: Text(
                      controller.transactions[index].description ?? '',
                      style: Get.theme.kVerySmallTextStyle,
                    ),
                    trailing: Text(
                      '₹ ${controller.transactions[index].amount ?? ''}',
                      style: Get.theme.kSubTitleTextStyle,
                    ),
                  ),
                );
              }))
        ],
      ),
    )));
  }
}
