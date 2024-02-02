import 'dart:convert';

import 'package:finwise/Screens/Home/home_controller.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:dart_openai/dart_openai.dart';

class AdvisorController extends GetxController {
  var loading = false.obs;
  final queryText = TextEditingController();
  var queryResponse = "".obs;

  HomeController homeController = Get.find();

  Future<String> getAdvice(String query) async {
    // Send an post req to https://c0kjnsio42.execute-api.ap-south-1.amazonaws.com/default/Datakon-AI-Advisor and body is prompt=query
    // and return the response

    debugPrint("Sending data");
    loading.value = true;
    try {
      const url = Globals.APIURL + "/financial-advisor";
      final response = await post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"question": query}));
      debugPrint("Sending data");
      final data = jsonDecode(response.body);
      debugPrint(data["answer"]);
      loading.value = false;
      return data["answer"].toString();
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Hello";
  }

  Future<String> getFInanceAdvice() async {
    // Send an post req to https://c0kjnsio42.execute-api.ap-south-1.amazonaws.com/default/Datakon-AI-Advisor and body is prompt=query
    // and return the response

    debugPrint("Sending data");
    loading.value = true;
    try {
      const url = Globals.APIURL + "/financial-advisor";
      final response = await post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "question": homeController.transactions.value.toString() +
                "\n" +
                "Go through the transactions and give me a financial advice based on my spending and saving habits. and categorize the transactions into different categories like food, travel, shopping, etc. Give me a summary of my spending and saving habits. Make the answer concise."
          }));
      debugPrint("Sending data");
      final data = jsonDecode(response.body);
      debugPrint(data["answer"]);
      loading.value = false;
      queryResponse.value = data["answer"].toString();
      return data["answer"].toString();
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Hello";
  }

  @override
  void onClose() {
    queryText.dispose();
    super.onClose();
  }
}
