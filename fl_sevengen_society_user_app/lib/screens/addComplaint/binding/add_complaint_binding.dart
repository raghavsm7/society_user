import 'package:fl_sevengen_society_user_app/screens/addComplaint/controller/add_complaint_controller.dart';
import 'package:get/get.dart';

class AddComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddComplaintController>(
          () => AddComplaintController(),
    );
  }
}