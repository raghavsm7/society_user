import 'package:fl_sevengen_society_user_app/screens/auth/enter_mobile_number/controller/enter_mobile_number_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class EnterMobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterMobileNumberController>(
          () => EnterMobileNumberController(),
    );
  }
}