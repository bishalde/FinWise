import 'dart:math';

import 'package:dio/dio.dart';
import 'package:finwise/Models/transaction_model.dart';
import 'package:finwise/Models/user_data.dart';
import 'package:finwise/common/balance_controller.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  String r = Random().nextInt(999999).toString().padLeft(4, '0');
  var user = Rx<UserData>(UserData());
  var transactions = <TransactionModel>[].obs;
  BalanceController balanceController = Get.find();

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchData() async {
    await getUserData();
    await balanceController.getBalance();
    await getTransactions();
  }

  Future<void> getUserData() async {
    const url = "${Globals.APIURL}/userdata";
    final dio = Dio();
    try {
      final response = await dio.get(url, queryParameters: {
        "uid": GetStorage().read("userId"),
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString());
        user.value = UserData.fromMap(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


Future<void> getTransactions() async {
    const url = "${Globals.APIURL}/transactions";
    final dio = Dio();
    try {
      final response = await dio.get(url, queryParameters: {
        "uid": GetStorage().read("userId"),
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString());
        transactions.value = List<TransactionModel>.from(data.map((x) => TransactionModel.fromMap(x)));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
