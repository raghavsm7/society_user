import 'package:fl_sevengen_society_user_app/screens/addComplaint/controller/add_complaint_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/bottombar/controller/bottom_bar_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/home/controller/home_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/controller/post_listing_controller.dart';
import 'package:get/get.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(
      () => BottomBarController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true
    );
    Get.lazyPut<PostListingController>(
      () => PostListingController(),
      fenix: true
    );
    Get.lazyPut<AddComplaintController>(
          () => AddComplaintController(),
      fenix: true
    );
  }
}
