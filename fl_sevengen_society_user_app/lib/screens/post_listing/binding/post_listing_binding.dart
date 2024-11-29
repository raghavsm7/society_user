import 'package:fl_sevengen_society_user_app/screens/post_listing/controller/post_listing_controller.dart';
import 'package:get/get.dart';

class PostListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostListingController>(
          () => PostListingController(),
    );
  }
}