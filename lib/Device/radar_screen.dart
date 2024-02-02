import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/app_bar_widget.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fineaseAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Get.theme.curveBG,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sizeBox(50, 0),
                      Center(
                          child: Text(
                        'Hmmm....',
                        style: Get.theme.kTitleTextStyle,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Lottie.asset(
                        'assets/images/75259-radar.json',
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'We’ve noticed another login on Android01',
                          style: Get.theme.kTitleTextStyle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Approve Device',
                              style: Get.theme.kMedTitleTextStyle,
                            ),
                          ),
                          Container(
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Get.theme.colorAccent),
                            child: IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Get.theme.btnTextCol,
                                  size: 20,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
