import 'package:finwise/common/balance_controller.dart';
import 'package:finwise/main_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<BalanceController>(BalanceController());
  }
}
