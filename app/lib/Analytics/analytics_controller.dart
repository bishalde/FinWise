


import 'package:dio/dio.dart';
import 'package:finwise/Models/analytics/analytic_model.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AnalyticsController extends GetxController{

    var loadAnalytics = true.obs;

  void toggleAnalytics() {
      loadAnalytics.value = !loadAnalytics.value;
      loadAnalytics.value = !loadAnalytics.value;
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

}