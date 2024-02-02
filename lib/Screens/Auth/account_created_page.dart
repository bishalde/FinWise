import 'package:finwise/Screens/Home/home_page.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:finwise/Utilities/app_bar_widget.dart';
import 'package:finwise/Utilities/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AccountCreatedPage extends StatelessWidget {
  const AccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
            Container(
              height: 400,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SvgPicture.asset(
                      'assets/images/center_left_deco.svg',
                      width: 50,
                    ),
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/center_deco.svg',
                          width: 320,
                        ),
                        Container(
                          child: Lottie.asset('assets/images/finease.json',
                              width: 150, repeat: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Easy Ways to Manage your Finances',
                style: Get.theme.kBigTextStyle.copyWith(fontSize: 28),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                  onPressed: () {
                    Get.to(() => HomePageScreen());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Get.theme.colorAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: Text(
                    "Get Started",
                    style:
                        Get.theme.kTitleTextStyle.copyWith(color: Colors.black),
                  )),
            ),
            sizeBox(30, 0),
          ],
        ),
      ),
    ));
  }
}
