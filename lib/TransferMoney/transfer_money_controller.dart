import 'package:dio/dio.dart';
import 'package:finwise/Screens/Home/home_controller.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:finwise/common/balance_controller.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TransferMoneyController extends GetxController {
  BalanceController balanceController = Get.find();
  HomeController homeController = Get.find();
  var amount = 0.obs;
  var upiId = "".obs;
  var amountController = TextEditingController();
  var upiIdController = TextEditingController();
  var paymentStatus = "none".obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  Future<void> transferMoney() async {
    const url = Globals.APIURL + "/upipayments";
    final dio = Dio();
    try {
      final response = await dio.post(url, data: {
        "uid": GetStorage().read("userId"),
        "toupi": upiId.value,
        "amount": amount.value,
      });

      if (response.statusCode == 200) {
        final amt = await balanceController.getBalance(); //update balance
        homeController.getTransactions();
        final data = response.data;
        if(data["success"]){
          paymentStatus.value = "success";
        } else {
          paymentStatus.value = "failed";
        }
        Get.snackbar("Success", "Amount transfered",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
      setSnackBar("ERROR:", "Failed to transfer money, please try again later");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    upiIdController.dispose();
    super.onClose();
  }
}
