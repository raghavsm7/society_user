import 'package:fl_sevengen_society_user_app/screens/onboarding/controller/on_boarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(
          () => OnBoardingController(),
    );
  }
}