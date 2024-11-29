import 'package:fl_sevengen_society_user_app/screens/auth/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInController>(
          () => LogInController(),
    );
  }
}