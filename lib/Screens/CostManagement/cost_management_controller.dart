import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:finwise/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CostManagementController extends GetxController {
  var file = Rx<File?>(null);

  var loading = false.obs;
  final queryText = TextEditingController();
  var queryResponse = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickFile() async {
    final status = await Permission.manageExternalStorage.request();
    if (status == PermissionStatus.granted) {
      // Permission granted, proceed to pick a file
      try {
        final pickedFile = await FilePicker.platform.pickFiles();
        if (pickedFile == null) {
          setSnackBar('Error: selected none', 'Please upload the file',
              icon: const Icon(Icons.warning_amber_rounded));
          return;
        }
        file.value = File(pickedFile.files.single.path!);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      // Permission denied, show an error message
      setSnackBar(
        'Error: permission denied',
        'We need your storage access to upload the document',
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }
  }

  Future<void> uploadFile() async {
    await pickFile();
    if (file.value == null) {
      setSnackBar('Error: selected none', 'Please upload the file',
          icon: const Icon(Icons.warning_amber_rounded));
      return;
    }

    loading.value = true;

    final url = Globals.DOCSCANNERURL + "/upload";

    try {
      final dio.Dio dioInstance = dio.Dio();
      final formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(file.value!.path),
        "api_key": "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"
      });
      final response = await dioInstance.post(url,
          data: formData,
          options: dio.Options(contentType: 'multipart/form-data'));

      final data = response.data;
      setSnackBar("SUCCESS:", "File uploaded successfully",
          icon: const Icon(Icons.check_circle_rounded));

      // Handle the response here
      print('Response: ${response.data}');
    } catch (error) {
      print('Error uploading file: $error');
      // Handle the error here
    } finally {
      loading.value = false;
    }
  }

  Future<String> askQuestions(String query) async {
    const url = Globals.DOCSCANNERURL + "/ask";

    final dio.Dio dioInstance = dio.Dio();
    loading.value = true;
    try {
      final response = await dioInstance.post(url, data: {
        "question": query,
      });

      final data = response.data;
      debugPrint(data.toString());
      queryResponse.value = data["response"];
      debugPrint(data["response"] + "helelelelelele");
    loading.value = false;
      return data["response"];
    } catch (e) {
      debugPrint(e.toString());
    }
    loading.value = false;
    return "Hello";
  }
}
