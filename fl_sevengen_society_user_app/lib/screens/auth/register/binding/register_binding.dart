import 'package:fl_sevengen_society_user_app/screens/auth/register/controller/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }
}