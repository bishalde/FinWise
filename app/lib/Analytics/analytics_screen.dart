import 'package:finwise/Analytics/analytics_controller.dart';
import 'package:finwise/Models/analytics/pie_chart_model.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AnalyticsController>(AnalyticsController());
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
                "Analytics",
                style: Get.theme.kTitleTextStyle,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text(
                "View your analytics here",
                style: Get.theme.kSmallTextStyle,
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
                      final expenseData =
                          snapshot.data?.debits.categoryWithPercentages
                              .map((e) => PieChartModel(
                                    title: e.category,
                                    value: e.percentage,
                                  ))
                              .toList();

                      final creditData =
                          snapshot.data?.credits.categoryWithPercentages
                              .map((e) => PieChartModel(
                                    title: e.category,
                                    value: e.percentage,
                                  ))
                              .toList();
                      return Column(
                        children: [
                          SfCircularChart(
                              enableMultiSelection: true,
                              title: ChartTitle(
                                  text: 'Credit Analysis',
                                  textStyle: Get.theme.kSmallTextStyle),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries<PieChartModel, String>>[
                                DoughnutSeries<PieChartModel, String>(
                                    dataSource: creditData,
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
                                    name: 'Credit Analysis'),
                              ]),
                          sizeBox(20, 0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Total Amount Credited: ${snapshot.data?.credits.total}",
                              style: Get.theme.kSubTitleTextStyle,
                            ),
                          ),
                          sizeBox(20, 0),
                          SfCircularChart(
                              enableMultiSelection: true,
                              title: ChartTitle(
                                  text: 'Expense Analysis',
                                  textStyle: Get.theme.kSmallTextStyle),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries<PieChartModel, String>>[
                                DoughnutSeries<PieChartModel, String>(
                                    dataSource: expenseData,
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
                              ]),
                          sizeBox(20, 0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Total Expenses: ${snapshot.data?.debits.total}",
                              style: Get.theme.kSubTitleTextStyle,
                            ),
                          ),
                          sizeBox(30, 0),
                        ],
                      );
                    })
                : Container()),
          ],
        ),
      )),
    );
  }
}
