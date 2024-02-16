import 'package:finwise/Screens/Auth/registeration_page.dart';
import 'package:finwise/Screens/OnBoarding/user_auth_page.dart';
import 'package:finwise/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../Utilities/finease_logo.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.black,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: SafeArea(
          child: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.grey[900],
              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Get.theme.colorPrimaryDark,
                color: Colors.grey,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              allowImplicitScrolling: true,
              //autoScrollDuration: 3000,
              showNextButton: false,
              done: const Text("Done",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onDone: () => Get.to(() => const UserAuthPage()),
              globalHeader: Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: fineaseLogo(),
                  ),
                ),
              ),
              pages: [
            PageViewModel(
              title: "FinWise",
              body: "The Next Generation of Finance",
              image: Lottie.asset('assets/images/finease.json',
                  width: 200, repeat: false),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "WalletPe",
              body:
                  "Streamline your payments with FinWise WalletPe, saving time and hassle.",
              image: Lottie.asset('assets/images/card.json',
                  animate: true, width: 800, repeat: true),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "AI Advisor",
              body:
                  "AI Advisor that helps you to make better financial decisions.",
              image: Lottie.asset('assets/images/Global_Solutions.json',
                  width: 200),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Budget Analyser",
              body:
                  "Budget Analyser and Recommender that helps you to make better Savings decisions.",
              image: Lottie.asset('assets/images/interest.json', width: 200),
              decoration: pageDecoration,
            ),
          ])),
    );
  }
}
