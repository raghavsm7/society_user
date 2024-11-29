import 'package:fl_sevengen_society_user_app/screens/addComplaint/binding/add_complaint_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/page/add_complaint_page.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/enter_mobile_number/binding/enter_mobile_number_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/enter_mobile_number/page/enter_mobile_number_page.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/login/binding/login_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/login/page/login_page.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/binding/register_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/page/register_page.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/verify_otp/binding/verify_otp_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/verify_otp/page/verify_otp_page.dart';
import 'package:fl_sevengen_society_user_app/screens/bottombar/binding/bottom_bar_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/bottombar/page/bottom_bar.dart';
import 'package:fl_sevengen_society_user_app/screens/noticeBoard/binding/notice_board_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/noticeBoard/page/notice_board_page.dart';
import 'package:fl_sevengen_society_user_app/screens/onboarding/binding/on_boarding_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/onboarding/page/on_boarding_page.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/binding/post_listing_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/page/post_listing_page.dart';
import 'package:fl_sevengen_society_user_app/screens/splash/binding/splash_binding.dart';
import 'package:fl_sevengen_society_user_app/screens/splash/page/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.initial,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.enterMobileNumber,
        page: () => EnterMobileNumberPage(),
        binding: EnterMobileNumberBinding()),
    GetPage(
        name: Routes.onBoarding,
        page: () => const OnBoardingPage(),
        binding: OnBoardingBinding()),
    GetPage(
        name: Routes.verifyOTP,
        page: () => VerifyOtpPage(),
        binding: VerifyOTPBinding()),
    GetPage(
        name: Routes.register,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: Routes.addComplaint,
        page: () => AddComplaintPage(),
        binding: AddComplaintBinding()),

    GetPage(
        name: Routes.postListing,
        page: () => PostListingPage(),
        binding: PostListingBinding()),
    GetPage(
        name: Routes.noticeListing,
        page: () => NoticeBoardPage(),
        binding: NoticeBoardBinding()),
    GetPage(
        name: Routes.login, page: () => LogInPage(), binding: LogInBinding()),
    GetPage(
        name: Routes.bottomBar, page: () => BottomBarPage(), binding: BottomBarBinding()),
  ];
}
