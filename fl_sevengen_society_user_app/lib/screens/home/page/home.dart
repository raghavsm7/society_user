import 'package:fl_sevengen_society_user_app/constants/color.dart';
import 'package:fl_sevengen_society_user_app/constants/dimens.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/home/controller/home_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/model/post_listing_response_model.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';


class HomePage extends BaseWidget {
  AuthResponseModel? authResponseModel;
  PostResponseModelData? adminPostListingResponseModel;
  String? latestNoticeToShow = "No Notices to show";

  final commumityList = [
    {
      "image": "assets/home/members.png",
      "name": translate('home.members'),
      "detail": translate('home.connect_member'),
      "route": "/members"
    },
    {
      "image": "assets/home/visitor.png",
      "name": translate('home.visitors'),
      "detail": translate('home.manage_entry'),
      "route": '/visitors'
    },
    {
      "image": "assets/home/noticeBoard.png",
      "name": translate('home.notice_board'),
      "detail": translate("home.society_announcement"),
      "route": '/noticeBoard'
    },
    {
      "image": "assets/home/payment.png",
      "name": translate('home.payment'),
      "detail": translate('home.direct_payment_due'),
      "route": '/payment'
    },
    {
      "image": "assets/home/bookAmenities.png",
      "name": translate('home.book_amenities'),
      "detail": translate('home.pre_book_amenities'),
      "route": '/bookAmenities'
    },
    {
      "image": "assets/home/helpDesk.png",
      "name": translate('home.help_desk'),
      "detail": translate('home.complaint_suggestion'),
      "route": '/helpDesk'
    },
  ];

  HomePage(this.authResponseModel, {super.key});

  // _HomePageState(this.authResponseModel, this.adminPostListingResponseModel);

/*  @override
  void initState() {
    super.initState();
    setDataInNotices(adminPostListingResponseModel);
  }*/

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (HomeController controller) {
      final size = MediaQuery.of(context).size;

      return (authResponseModel?.data?.user?.verified != true)
          ? ModalProgressHUD(
        inAsyncCall: controller.loading,
            child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      colorGrey, // 0 = Colored, 1 = Black & White
                      BlendMode.saturation,
                    ),
                    child: _showView(context,controller),
                  ),
                  Container(
                    padding: const EdgeInsets.all(size_10),
                    height: AppUtils.appUtilsInstance
                        .getPercentageSize(percentage: size_12, ofWidth: false),
                    width: AppUtils.appUtilsInstance
                        .getPercentageSize(percentage: size_100, ofWidth: true),
                    color: primaryColor,
                    child: textWidget(
                        "Please wait!!Admin will approve your request shortly.",
                        style: semibold14White),
                  )
                ],
              ),
          )
          : _showView(context,controller);
    });
  }

  notificationButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/notification');
      },
      icon: Stack(
        children: [
          const Iconify(Carbon.notification),
          Positioned(
            right: 1,
            top: 2,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: redColor,
                border: Border.all(color: whiteColor, width: 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  communityListContent(Size size) {
    return Container(
      color: f6f3Color,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: commumityList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: fixPadding * 2.0,
          crossAxisSpacing: fixPadding * 2.0,
          childAspectRatio: size.width / (size.height / 2.2),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.noticeListing);
              /*  if (commumityList[index]['route'] != null) {
                Navigator.pushNamed(
                    context, commumityList[index]['route'].toString());
              }*/
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: fixPadding, right: fixPadding, top: fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    blurRadius: 12.0,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commumityList[index]['name'].toString(),
                          style: semibold16Black33,
                          overflow: TextOverflow.ellipsis,
                        ),
                        heightBox(2.0),
                        Text(
                          commumityList[index]['detail'].toString(),
                          style: medium12Grey.copyWith(height: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        commumityList[index]['image'].toString(),
                        height: size.width * 0.16,
                        width: size.width * 0.16,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  communityTitle(BuildContext context) {
    return Text(
      getTranslate(context, 'home.community'),
      style: semibold16Primary,
    );
  }

  banner(BuildContext context, HomeController controller) {

    return Container(
      height: 130,
      width: double.maxFinite,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: fixPadding * 2.0, top: fixPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            blurRadius: 12.0,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6.0,
            color: primaryColor,
          ),
          Expanded(
            child: Container(
              color: whiteColor,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF74ABCE),
                        const Color(0xFFADD3EB).withOpacity(0.5),
                      ],
                    ),
                    color: whiteColor),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(fixPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NOTICE",
                              style: semibold14White.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            heightSpace,
                            Text(
                             controller.latestNoticeToShow,
                              style: medium14White,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightSpace,
                            InkWell(
                              onTap: (){
                                Get.toNamed(Routes.noticeListing);
                              },
                              child: const Text(
                                "See more..",
                                style: medium14White,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: fixPadding * 1.3,
                              vertical: fixPadding * 0.4),
                          color: primaryColor,
                          alignment: Alignment.center,
                          child: Text(
                            getTranslate(context, 'home.new'),
                            style: semibold12White,
                          ),
                        ),
                        heightSpace,
                        heightSpace,
                        Image.asset(
                          "assets/home/banner-image.png",
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  header() {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
            border: Border.all(color: whiteColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.2),
                blurRadius: 6.0,
              ),
            ],
            image: const DecorationImage(
              image: AssetImage("assets/home/profile-image.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        widthSpace,
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Jacob Jones",
                style: semibold18Primary,
              ),
              height5Space,
              Text(
                "A-420 | SevenGen society",
                style: medium14Grey,
              )
            ],
          ),
        ),
      ],
    );
  }

  _showView(BuildContext context, HomeController controller) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        titleSpacing: 20.0,
        backgroundColor: whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 65.0,
        title: header(),
        actions: [notificationButton(context)],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: fixPadding * 9.5),
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/calling');
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                  fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
              color: whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  banner(context,controller),
                  communityTitle(context),
                ],
              ),
            ),
          ),
          communityListContent(size),
        ],
      ),
    );
  }


}
