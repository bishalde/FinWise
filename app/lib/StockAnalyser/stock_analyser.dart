import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finwise/StockAnalyser/stock_analyser_controller.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:finwise/Utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StockAnalyserView extends StatelessWidget {
  const StockAnalyserView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<StockAnalyserController>(StockAnalyserController());
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Finstock",
                style: Get.theme.kTitleTextStyle,
              ),
            ),

            sizeBox(20, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Analyse the stock market",
                style: Get.theme.kSmallTextStyle,
              ),
            ),
            sizeBox(20, 0),
             Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          controller.selectedStock.value = value.toString();
                        },
                        items: controller.stocks
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        decoration: InputDecoration(
                            labelText: "Select Stock",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: controller.queryText,
              decoration: InputDecoration(
                labelText: 'Enter your query',
                labelStyle: Get.theme.kSmallTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onFieldSubmitted: (v) async {
                debugPrint("Submitted");
                controller.queryResponse.value = await controller.getStockData(v);
              },
            ),
          ),
                    Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => controller.loading.value
                  ? Loader()
                  : AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          controller.queryResponse.value ?? "Ask me anything!",
                          textStyle: Get.theme.kSubTitleTextStyle,
                          speed: const Duration(milliseconds: 50),
                        ),
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
