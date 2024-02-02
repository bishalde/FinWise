

import 'package:dio/dio.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BalanceController extends GetxController{
  var balance = 0.obs;

   Future<int> getBalance() async {
    const url = Globals.APIURL + "/balance";
    final dio = Dio();
    try {
      final response = await dio.get(url, queryParameters: {
        "uid": GetStorage().read("userId"),
      });

      if (response.statusCode == 200) {
        final amt = response.data["balance"];
        balance.value = amt;
        return amt;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}