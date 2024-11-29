import 'package:fl_sevengen_society_user_app/screens/auth/verify_otp/controller/verify_otp_controller.dart';
import 'package:get/get.dart';

class VerifyOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOTPController>(
      () => VerifyOTPController(),
    );
  }
}
