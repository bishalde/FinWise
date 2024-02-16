import 'package:dio/dio.dart';
import 'package:finwise/Screens/Home/home_controller.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:finwise/common/balance_controller.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddFundsController extends GetxController {
  final _razorpay = Razorpay();
  var amount = 0.obs;
  var loading = false.obs;
  var amountTextController = TextEditingController();
  BalanceController balanceController = Get.find();
  HomeController homeController = Get.find();

  Future<void> makePayment() async {
    final options = {
      'key': 'rzp_test_jJrfuKt3FdxoL7',
      'amount': amount.value * 100,
      'name': 'Finwise',
      'description': 'Finewise',
      'prefill': {'contact': '8888888888', 'email': ''}
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    const url = Globals.APIURL + "/transactions";
    final dio = Dio();
    try {
      final response = await dio.post(url, data: {
        "uid": GetStorage().read("userId"),
        "amount": amount.value,
        "type": "credit",
        "description": "Added funds to wallet"
      });

      if (response.statusCode == 200) {
        final amt = await balanceController.getBalance(); //update balance
        homeController.getTransactions();
        Get.snackbar("Success", "Amount added to wallet",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      setSnackBar("ERROR:", "Failed to add funds, please try again later");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void onClose() {
    _razorpay.clear();
    amountTextController.dispose();
    super.onClose();
  }
}
