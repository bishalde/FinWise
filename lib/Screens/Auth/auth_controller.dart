import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:finwise/Models/pic_model.dart';
import 'package:finwise/Models/user_data.dart';
import 'package:finwise/Screens/Auth/account_created_page.dart';
import 'package:finwise/Screens/Auth/account_verification.dart';
import 'package:finwise/Screens/Home/home_page.dart';
import 'package:finwise/Utilities/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';
import 'package:finwise/globals.dart';

class AuthController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final emailAddress = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController();

  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final zipcode = TextEditingController();

  final accountno = TextEditingController();
  final mpin = TextEditingController();

  final govtID = TextEditingController();

  final personalFormKey = GlobalKey<FormState>();
  final residentialFormKey = GlobalKey<FormState>();
  final accVerificationFormKey = GlobalKey<FormState>();
  final govtFormKey = GlobalKey<FormState>();
  final accFormKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  var loading = false.obs;
  var biometricVerified = 'none'.obs;

  var govtIdImage = Rx<File?>(null);
  var profileImage = Rx<File?>(null);

  var pinputController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  var loadingResidentialData = false.obs;
  var verificationId = ''.obs;

  Future<bool> requestLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<void> pickImage({bool profile = false}) async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus != PermissionStatus.granted) {
      setSnackBar('Error: permission denied',
          'We need your storage access to upload the document',
          icon: const Icon(Icons.warning_amber_rounded));
      return;
    }

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      setSnackBar('Error: selected none', 'Please upload the image',
          icon: const Icon(Icons.warning_amber_rounded));
      return;
    }

    if (profile) {
      profileImage.value = File(pickedFile.path);
      uploadImage('profile', profileImage.value!);
    } else {
      govtIdImage.value = File(pickedFile.path);
      uploadImage('photoProof', govtIdImage.value!);
    }
  }

  Future<void> setLocation() async {
    loadingResidentialData.value = true;
    if (await requestLocation()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: 'en');

      Placemark placemark = placemarks.first;

      String? stateC = placemark.administrativeArea;
      String? cityC = placemark.locality;
      String? postalCodeC = placemark.postalCode;
      String? countryC = placemark.country;
      String? streetC = placemark.street;

      street.text = streetC!;
      city.text = cityC!;
      state.text = stateC!;
      country.text = countryC!;
      zipcode.text = postalCodeC!;
    } else {
      setSnackBar(
          'Permission denied', 'Please provide us the access to your location');
    }
    loadingResidentialData.value = false;
  }

  Future<String> pickDate(BuildContext context, String format) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(picked);
      return formatted;
    } else {
      return '';
    }
  }

  Future<void> signUp() async {
    try {
      sendData();
    } catch (e) {
      print(e);
      setSnackBar("ERROR:", e.toString());
    }
  }

  Future<void> sendData() async {
    final dio = Dio();
    try {
      final data = UserData(
        firstName: firstName.text,
        lastName: lastName.text,
        dob: dateOfBirth.text,
        email: emailAddress.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        address: street.text,
        city: city.text,
        state: state.text,
        country: country.text,
        zipCode: zipcode.text,
        gender: gender.text,
      );
      final apiUrl = "${Globals.APIURL}/register";
      final response = await dio.post(apiUrl, data: {
        "firstName": data.firstName,
        "lastName": data.lastName,
        "dob": data.dob,
        "email": data.email,
        "password": data.password,
        "phoneNumber": data.phoneNumber,
        "address": data.address,
        "city": data.city,
        "state": data.state,
        "country": data.country,
        "zipCode": data.zipCode,
        "gender": data.gender
      });
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        var responseBody = response.data;
        var userId = responseBody['data']['uid'];

        GetStorage().write('userId', userId);
        debugPrint(responseBody.toString());
        setSnackBar("SUCCESS:", responseBody['message']);
        Get.off(() => const AccountCreatedPage());
      } else {
        setSnackBar("ERROR:", response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> uploadImage(String type, File file) async {
    final bytes = await file.readAsBytesSync();
    String image = base64Encode(bytes);
    print(image);
    try {
      final apiUrl = "${Globals.APIURL}/image/add";
      final response = await post(Uri.parse(apiUrl),
          headers: {
            "content-type": "application/json; charset=utf-8",
          },
          body: jsonEncode(<String, String>{
            "userId": "FirebaseAuth.instance.currentUser!.uid",
            "image": image,
            "photoName": type,
          }));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyBiometric() async {
    try {
      final apiUrl = Globals.BIOURL;
      final user = UserVerify(
        userId: "FirebaseAuth.instance.currentUser!.uid",
      );
      final response = await post(Uri.parse(apiUrl),
          body: jsonEncode(<String, String>{
            "body": "FirebaseAuth.instance.currentUser!.uid",
          }));
      var responseBody = jsonDecode(response.body);
      debugPrint(responseBody.toString());
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        // debugPrint(responseBody.toString());
        bool status = responseBody['Status'];
        debugPrint(status.toString());
        if (status == true) {
          biometricVerified.value = 'success';
          return true;
        } else {
          biometricVerified.value = 'failed';
          setSnackBar('ERROR: ',
              'Invalid match please try again by reuploading the right image');
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String generatePassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(String) onCodeSent,
      Function(String) onVerificationCompleted,
      Function(FirebaseAuthException) onVerificationFailed) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user if verification is successful
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onVerificationFailed(e);
        debugPrint(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
        Get.to(() => const AccountVerificationScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signInWithPhoneAndSMSCode(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => {Get.off(() => AccountCreatedPage())});
    } catch (e) {
      // Handle errors
    }
  }

  Future<void> login() async {
    final dio = Dio();
    try {
      final data = UserData(
        email: emailAddress.text,
        password: password.text,
      );
      final apiUrl = "${Globals.APIURL}/login";
      final response = await dio
          .post(apiUrl, data: {"email": data.email, "password": data.password});
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        var responseBody = response.data;
        var userId = responseBody['data']['uid'];
        GetStorage().write('userId', userId);
        debugPrint(responseBody.toString());
        setSnackBar("SUCCESS:", responseBody['message']);
        Get.off(() => const HomePageScreen());
      } else {
        setSnackBar("ERROR:", response.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
