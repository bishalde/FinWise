import 'dart:math';

import 'package:dio/dio.dart';
import 'package:finwise/Models/analytics/analytic_model.dart';
import 'package:finwise/Models/transaction_model.dart';
import 'package:finwise/Models/user_data.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:finwise/common/balance_controller.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:pinput/pinput.dart';
import 'package:telephony/telephony.dart';

class HomeController extends GetxController {
  String r = Random().nextInt(999999).toString().padLeft(4, '0');
  var user = Rx<UserData>(UserData());
  var transactions = <TransactionModel>[].obs;
  BalanceController balanceController = Get.find();

  var loadAnalytics = true.obs;
  var expenseDescriptionController = TextEditingController();
  var expenseAmountController = TextEditingController();
  var selectedCategory = "".obs;
  final smsLoading = false.obs;
  var cibilscore = 0.0.obs;
  final categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Health",
    "Housing",
    "Utilities",
    "Others"
  ];
  final transTypeList = ["credit", "debit"];
  var transType = "".obs;

  var smsContentController = TextEditingController();

  @override
  void onInit() async {
    await fetchData();

    final bool status = await NotificationListenerService.isPermissionGranted();

    if (!status) {
      await NotificationListenerService.requestPermission();
    }

    NotificationListenerService.notificationsStream.listen((event) async {
      debugPrint("Current notification: $event");
      if (event.title == "Jasu") {
        smsContentController.setText(event.content ?? "");
        await processSms();
        await fetchData();
        // Introduce a delay of 5 seconds after the message is processed
        // Any code placed here will execute after the delay
      }
    });
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

  void toggleAnalytics() {
    loadAnalytics.value = !loadAnalytics.value;
    loadAnalytics.value = !loadAnalytics.value;
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
        debugPrint(data.toString() + "user dataaaaaaaaaaaa");
        user.value = UserData.fromMap(data);
        await fetchCibilscore();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchCibilscore() async {
    const url = "${Globals.AIURL}/calculate_cibil_score";
    final dio = Dio();
    try {
      final response = await dio.post(url);
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString() + "Cibil dataaaaaaaaaaaa");
        cibilscore.value = data["cibil_score"];
        debugPrint("${cibilscore.value} cibil ka data h");
      }
    } catch (e) {
      debugPrint(e.toString() + "cibil error");
    }
  }

  Future<bool> processSms() async {
    final url = "${Globals.AIURL}/sms_read";

    final dio = Dio();

    try {
      smsLoading.value = true;
      final response = await dio.post(url, data: {
        "question":
            "${smsContentController.text} uid: ${GetStorage().read("userId")}",
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString() + "SMS dataaaaaaaaaaaa");
        smsContentController.clear();
        smsLoading.value = false;
        Get.back();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return false;
  }

  Future<String> provideSuggestion() async {
    final url = "${Globals.AIURL}/savings_short";
    final dio = Dio();
    try {
      final response = await dio.post(url, data: {
        "question": transactions.value.toString(),
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString() + "Suggestion dataaaaaaaaaaaa");
        return data["answer"];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Hello Harsh kothari!";
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
        debugPrint(data.toString() + "Transaction dataaaaaaaaaaaa");
        transactions.value = List<TransactionModel>.from(
            data.map((x) => TransactionModel.fromMap(x)));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<AnalyticModel?> getAnalytics() async {
    const url = "${Globals.APIURL}/getGraphs";
    final dio = Dio();
    try {
      final response = await dio.get(url, queryParameters: {
        "uid": GetStorage().read("userId"),
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString() + "Analytic dataaaaaaaaaaaa");
        return AnalyticModel.fromMap(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> addExpense() async {
    final url = "${Globals.APIURL}/manual";
    final dio = Dio();
    final data = {
      "uid": GetStorage().read("userId"),
      "amount": expenseAmountController.text,
      "description": expenseDescriptionController.text,
      "category": selectedCategory.value,
      "type": transType.value,
    };
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        await fetchData();
        toggleAnalytics();
        expenseAmountController.clear();
        expenseDescriptionController.clear();
        selectedCategory.value = "";
        transType.value = "";
        Get.back();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
