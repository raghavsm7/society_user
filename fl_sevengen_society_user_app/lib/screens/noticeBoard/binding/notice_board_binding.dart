import 'package:fl_sevengen_society_user_app/screens/noticeBoard/controller/notice_board_controller.dart';
import 'package:get/get.dart';

class NoticeBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeBoardController>(
          () => NoticeBoardController(),
    );
  }
}