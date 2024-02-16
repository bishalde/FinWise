import 'package:carousel_slider/carousel_slider.dart';
import 'package:finwise/AddFunds/add_funds_screen.dart';
import 'package:finwise/Analytics/analytics_screen.dart';
import 'package:finwise/Device/radar_screen.dart';
import 'package:finwise/Models/analytics/analytic_model.dart';
import 'package:finwise/Models/analytics/pie_chart_model.dart';
import 'package:finwise/RecieveMoney/recieve_money_view.dart';
import 'package:finwise/Screens/Advisor/advisor_screen.dart';
import 'package:finwise/Screens/CostManagement/cost_management_view.dart';
import 'package:finwise/Screens/Home/home_controller.dart';
import 'package:finwise/StockAnalyser/stock_analyser.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/TransferMoney/transfer_money_screen.dart';
import 'package:finwise/Utilities/bottom_sheet.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/finease_logo.dart';
import 'package:finwise/Utilities/format_date.dart';
import 'package:finwise/Utilities/loading.dart';
import 'package:finwise/Utilities/number_formatter.dart';
import 'package:finwise/Utilities/primary_button.dart';
import 'package:finwise/Utilities/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slide_action/slide_action.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
        controller.toggleAnalytics();
      },
      child: ListView(
        children: [
          sizeBox(20, 0),
          Row(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Obx(
                    () => CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      foregroundImage: AssetImage(
                          'assets/images/${controller.user.value.avatarId}.png'),
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Hi, ${controller.user.value.firstName} ${controller.user.value.lastName}',
                      style: Get.theme.kMedTitleTextStyle,
                    ),
                  ),
                  Obx(() => Text('${controller.user.value.upi}',
                      style: Get.theme.kSmallTextStyle)),
                ],
              ),
            ],
          ),
          sizeBox(20, 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Your balance",
              style: Get.theme.kTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Obx(() => Text(
                  "₹ ${controller.balanceController.balance.value.toString().formatNumber()}",
                  style: Get.theme.kBigTextStyle.copyWith(color: Colors.amber),
                )),
          ),
          sizeBox(15, 0),
          // Send, Add, receive money buttons
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Gap(20),
                OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => AiAdvisorScreen());
                    },
                    icon: Icon(Icons.hub_rounded),
                    label: Text(
                      "Ai Advisor",
                      style: Get.theme.kSmallTextStyle,
                    )),
                const Gap(10),
                OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => const CostManagementScreen());
                    },
                    icon: Icon(Icons.account_balance_wallet_rounded),
                    label: Text(
                      "FinScan",
                      style: Get.theme.kSmallTextStyle,
                    )),
                const Gap(10),
                OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => const AnalyticsScreen());
                    },
                    icon: Icon(Icons.analytics_outlined),
                    label: Text(
                      "Analytics",
                      style: Get.theme.kSmallTextStyle,
                    )),
                const Gap(20),
                OutlinedButton.icon(
                    onPressed: () {
                      Get.to(() => const StockAnalyserView());
                    },
                    icon: const Icon(Icons.candlestick_chart_outlined),
                    label: Text(
                      "Finstock",
                      style: Get.theme.kSmallTextStyle,
                    )),
                const Gap(20),
              ],
            ),
          ),
          sizeBox(30, 0),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const TransferMoneyScreen());
                  },
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                      sizeBox(10, 0),
                      Text(
                        'Send',
                        style: Get.theme.kSmallTextStyle,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AddFundsScreen());
                  },
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                        ),
                      ),
                      sizeBox(10, 0),
                      Text(
                        'Add',
                        style: Get.theme.kSmallTextStyle,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RecieveMoneyView());
                  },
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                        ),
                      ),
                      sizeBox(10, 0),
                      Text(
                        'Receive',
                        style: Get.theme.kSmallTextStyle,
                      ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     bottomSheetWidget(Column(
                //       children: [
                //         // paste sms content
                //         Padding(
                //           padding: const EdgeInsets.all(15.0),
                //           child: TextField(
                //             controller: controller.smsContentController,
                //             maxLines: 5,
                //             decoration: InputDecoration(
                //                 labelText: "Paste SMS Content",
                //                 border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10))),
                //           ),
                //         ),
                //         Obx(() => controller.smsLoading.value
                //             ? Loader()
                //             : primaryButton(
                //                 label: "Process SMS",
                //                 icon: Icons.done_outline_rounded,
                //                 onTap: () async {
                //                   await controller
                //                       .processSms()
                //                       .then((value) async {
                //                     if (value) {
                //                       await controller.fetchData();
                //                       controller.toggleAnalytics();
                //                     }
                //                   });
                //                 }))
                //       ],
                //     ));
                //   },
                //   child: Column(
                //     children: [
                //       const CircleAvatar(
                //         radius: 30,
                //         backgroundColor: Colors.pink,
                //         child: Icon(
                //           Icons.sms_rounded,
                //           color: Colors.white,
                //         ),
                //       ),
                //       sizeBox(10, 0),
                //       Text(
                //         'SMS',
                //         style: Get.theme.kSmallTextStyle,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          sizeBox(20, 0),
          Obx(() => controller.loadAnalytics.value
              ? FutureBuilder(
                  future: controller.getAnalytics(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.data!.debits.categoryWithPercentages.isEmpty) {
                      return Container();
                    }
                    final data = snapshot.data?.debits.categoryWithPercentages
                        .map((e) => PieChartModel(
                              title: e.category,
                              value: e.percentage,
                            ))
                        .toList();
                    return SfCircularChart(
                        enableMultiSelection: true,
                        title: ChartTitle(
                            text: 'Expense Analysis',
                            textStyle: Get.theme.kSmallTextStyle),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CircularSeries<PieChartModel, String>>[
                          DoughnutSeries<PieChartModel, String>(
                              dataSource: data,
                              explodeAll: true,
                              startAngle: 90,
                              endAngle: 90,
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  labelPosition:
                                      ChartDataLabelPosition.outside),
                              xValueMapper: (PieChartModel data, _) =>
                                  data.title,
                              yValueMapper: (PieChartModel data, _) =>
                                  data.value.round(),
                              name: 'Expense Analysis'),
                        ]);
                  })
              : Container()),
          sizeBox(20, 0),
          Obx(() => controller.loadAnalytics.value
              ? FutureBuilder(
                  future: controller.provideSuggestion(),
                  builder: (contrxt, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue, // Color of the border
                            width: 2.0, // Width of the border
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "${snapshot.data}",
                        style: Get.theme.kSmallTextStyle,
                      ),
                    );
                  })
              : Container()),
          sizeBox(20, 0),
          primaryButton(
              label: "Add your own expenses",
              icon: Icons.edit_rounded,
              onTap: () {
                bottomSheetWidget(Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Add your own expenses",
                        style: Get.theme.kMedTitleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: controller.expenseDescriptionController,
                        decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: controller.expenseAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Amount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          controller.transType.value = value.toString();
                        },
                        items: controller.transTypeList
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: "Transaction Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          controller.selectedCategory.value = value.toString();
                        },
                        items: controller.categories
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: "Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: primaryButton(
                          icon: Icons.add_rounded,
                          label: "Add",
                          onTap: () async {
                            await controller.addExpense();
                          }),
                    ),
                  ],
                ));
              }),

          // Cibil score

          sizeBox(20, 0),

          Obx(
            () => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Cibil Score: ${controller.cibilscore.value}",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
          ),

          Obx(
            () => SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 3000,
              axes: <RadialAxis>[
                RadialAxis(
                    showLabels: false,
                    showAxisLine: true,
                    showTicks: true,
                    canScaleToFit: true,
                    canRotateLabels: true,
                    minimum: 300,
                    maximum: 900,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 300,
                          endValue: 550,
                          color: Color.fromARGB(255, 200, 9, 9),
                          label: 'Poor',
                          sizeUnit: GaugeSizeUnit.factor,
                          labelStyle: const GaugeTextStyle(
                              fontFamily: 'Times', fontSize: 10),
                          startWidth: 0.45,
                          endWidth: 0.45),
                      GaugeRange(
                        startValue: 551,
                        endValue: 650,
                        color: Color.fromARGB(255, 228, 198, 0),
                        label: 'Average',
                        labelStyle: const GaugeTextStyle(
                            fontFamily: 'Times', fontSize: 10),
                        startWidth: 0.45,
                        endWidth: 0.45,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 651,
                        endValue: 750,
                        color: Color.fromARGB(255, 185, 229, 8),
                        label: 'Good',
                        labelStyle: const GaugeTextStyle(
                            fontFamily: 'Times', fontSize: 10),
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.45,
                        endWidth: 0.45,
                      ),
                      GaugeRange(
                        startValue: 751,
                        endValue: 900,
                        color: Color.fromARGB(255, 12, 229, 8),
                        label: 'Excellent',
                        labelStyle: const GaugeTextStyle(
                            fontFamily: 'Times', fontSize: 10),
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.45,
                        endWidth: 0.45,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: controller.cibilscore.value)
                    ])
              ],
            ),
          ),

          // Show expenses card
          Obx(() => controller.transactions.value.length > 0
              ? Row(
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
                )
              : SizedBox()),
          Obx(() => ListView.builder(
              itemCount: controller.transactions.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(
                            padding: EdgeInsets.zero,
                            label: Text(
                              controller.transactions[index].category ?? "",
                              style: Get.theme.kVerySmallTextStyle
                                  .copyWith(fontSize: 10),
                            )),
                        Text(
                          controller.transactions[index].description ?? '',
                          style: Get.theme.kVerySmallTextStyle
                              .copyWith(fontSize: 10),
                        ),
                      ],
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
