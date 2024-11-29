import 'package:fl_sevengen_society_user_app/screens/addComplaint/data/provider/post_provider.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/provider/auth_provider.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/provider/post_listing_provider.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider(), fenix: true);
    Get.lazyPut<PostProvider>(() => PostProvider(), fenix: true);
    Get.lazyPut<PostListingProvider>(() => PostListingProvider(), fenix: true);
  }
}
