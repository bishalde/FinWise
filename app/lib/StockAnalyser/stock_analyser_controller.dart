import 'package:dio/dio.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockAnalyserController extends GetxController {
  List<String> stocks = [
    "RELIANCE", // Reliance Industries Ltd.
    "TCS", // Tata Consultancy Services Ltd.
    "HDFCBANK.NS", // HDFC Bank Ltd.
    "INFY", // Infosys Ltd.
    "HINDUNILVR", // Hindustan Unilever Ltd.
    "BAJFINANCE", // Bajaj Finance Ltd.
    "NSE:ICICIBANK", // ICICI Bank Ltd.
    "WIPRO", // Wipro Ltd.
    "LT", // Larsen & Toubro Ltd.
    "AXISBANK", // Axis Bank Ltd.
    // Add more stock codes as needed
  ];

  var selectedStock = "".obs;
  var loading = false.obs;
  var queryResponse = "".obs;
  var queryText = TextEditingController();

  Future<String> getStockData(String v) async {
    final url = "${Globals.AIURL}/stocks";

    loading.value = true;
    final dio = Dio();

    try {
      final response = await dio.post(url, data: {
        "question": v,
        "symbol": selectedStock.value,
      });
      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint(data.toString() + "Stock dataaaaaaaaaaaa");
        loading.value = false;
        return data["answer"];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Hello Harsh kothari!";
  }
}
