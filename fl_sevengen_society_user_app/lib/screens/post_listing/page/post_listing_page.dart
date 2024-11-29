import 'package:fl_sevengen_society_user_app/constants/color.dart';
import 'package:fl_sevengen_society_user_app/constants/dimens.dart';
import 'package:fl_sevengen_society_user_app/constants/image_constant.dart';
import 'package:fl_sevengen_society_user_app/constants/text_style_constant.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/controller/post_listing_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/model/post_listing_response_model.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/date_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/image_utils.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/click_to_retry_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListingPage extends BaseWidget {
  PostListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostListingController>(
        builder: (PostListingController controller) {
      return ModalProgressHUD(
        inAsyncCall: controller.loading,
        child: Scaffold(
          backgroundColor: colorLightBlack,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: whiteColor,
            elevation: 0.0,
            titleSpacing: 20.0,
            automaticallyImplyLeading: false,
            title: Text(
              getTranslate(context, 'Post Listing'),
              style: semibold18Black33,
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: size_15),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addComplaint);
                    },
                    child: const Icon(
                      Icons.add,
                      size: size_24,
                      color: primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: adminPostList(controller,
              context) /*Column(
            children: [
             // tabBar(controller, context),
              Expanded(
                child: adminPostList(controller, context)*/ /* TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    adminPostList(controller, context),
                    userPostList(controller, context),
                  ],
                )*/ /*
              )
            ],
          )*/
          ,
        ),
      );
    });
  }

  tabBar(PostListingController controller, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 45,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: greyD9Color, width: 2.0),
            ),
          ),
        ),
        Container(
          height: 45.0,
          width: double.maxFinite,
          color: colorWhite,
          child: TabBar(
            controller: controller.tabController,
            labelStyle: semibold16Black33.copyWith(fontFamily: "Inter"),
            labelColor: primaryColor,
            unselectedLabelColor: greyColor,
            unselectedLabelStyle: semibold16Grey.copyWith(fontFamily: "Inter"),
            tabs: const [
              Tab(text: "Admin Post"),
              Tab(text: "User Post"),
            ],
          ),
        ),
      ],
    );
  }

  adminPostList(PostListingController controller, BuildContext context) {
    return (controller.adminPostListingResponseModel == null)
        ? ClickToRetryWidget(
            visible: controller.loading,
            callback: () {
              controller.callAdminPostListingAPI();
            })
        : RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(microseconds: 500));
              controller.adminPostPage = 1;
              controller.callAdminPostListingAPI();
            },
            child: Container(
              margin: const EdgeInsets.all(size_10),
              child: ListView.separated(
                key: const PageStorageKey("userList"),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller
                        .adminPostListingResponseModel?.data?.posts?.length ??
                    0,
                controller: controller.adminPostScrollController,
                itemBuilder: (context, index) {
                  PostResponseModelDataDataPosts? postObj =
                      // controller.adminPostListingResponseModel?.data![index];
                      controller
                          .adminPostListingResponseModel?.data?.posts![index];
                  return _listItem(postObj, controller, context);
                },
                separatorBuilder: (context, index) {
                  return spacing(size: size_1);
                },
              ),
            ),
          );
  }

/*  userPostList(PostListingController controller, BuildContext context) {
    return (controller.userPostListingResponseModel == null)
        ? ClickToRetryWidget(
            visible: controller.loading,
            callback: () {
              controller.callUserPostListingAPI();
            })
        : RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(microseconds: 500));
              controller.userPostPage = 1;
              controller.callUserPostListingAPI();
            },
            child: Container(
              margin: EdgeInsets.all(size_10),
              child: ListView.separated(
                key: const PageStorageKey("adminList"),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller
                        .userPostListingResponseModel?.data?.posts?.length ??
                    0,
                controller: controller.userPostScrollController,
                itemBuilder: (context, index) {
                  PostListingReponseModelDataPosts? postObj =
                      // controller.adminPostListingResponseModel?.data![index];
                      controller
                          .userPostListingResponseModel?.data?.posts![index];
                  return _listItem(postObj, controller, context);
                },
                separatorBuilder: (context, index) {
                  return spacing(size: size_1);
                },
              ),
            ),
          );
  }*/

  _listItem(PostResponseModelDataDataPosts? postObj,
      PostListingController controller, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: elevation_05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacing(size: size_2),
          _showPostInfo(postObj),
          spacing(size: size_1),
          _showPostContentData(postObj),
          spacing(size: size_2),
          _showPostImage(postObj, controller, context),
          spacing(size: size_2),
          //  _showPostTitle(postObj),
          spacing(size: size_1),
          spacing(size: size_2),
          spacing(size: size_1),
          _showLikeAndComment(
              postObj?.likes, controller, postObj?.id, postObj?.adminNotice),
          spacing(size: size_1),
          /* const Divider(
            color: colorGrey,
            height: size_1,
          ),*/
        ],
      ),
    );
  }

  _showPostTitle(PostResponseModelDataDataPosts? postObj) {
    return Padding(
      padding: const EdgeInsets.only(left: size_12, right: size_12),
      child: textWidget(postObj?.title ?? "",
          style: textBlack(textStyleEnum: TextStyleEnum.bold)),
    );
  }

  _showPostContentData(PostResponseModelDataDataPosts? postObj) {
    return Padding(
      padding: const EdgeInsets.only(left: size_12, right: size_12),
      child: textWidget(postObj?.content ?? "",
          style: textBlack(textStyleEnum: TextStyleEnum.regular)),
    );
  }

  _showPostImage(PostResponseModelDataDataPosts? postObj,
      PostListingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(size_8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(AppUtils.appUtilsInstance.getPercentageSize(
            percentage: size_1_5,
          )),),
        child: SizedBox(
          height: AppUtils.appUtilsInstance.getPercentageSize(percentage: size_24),
          width: AppUtils.appUtilsInstance
              .getPercentageSize(percentage: size_100, ofWidth: true),
          child: (GetUtils.isNullOrBlank(postObj?.media![0]) == false)
              ? GestureDetector(
                  onTap: () {
                    controller.showFullScreenImage(
                        context, postObj?.media![0] ?? "");
                  },
                  child: ImageUtils.imageUtilsInstance.showCacheNetworkImage(
                      imageURL: postObj?.media![0] ?? "",
                      fit: BoxFit.fill,
                      placeHolderImage: placeHolder,
                      showDefaultErrorWidget: true,
                      placeholderColor: colorPrimary,
                      height: AppUtils.appUtilsInstance

                          .getPercentageSize(percentage: size_14),
                      width: AppUtils.appUtilsInstance
                          .getPercentageSize(percentage: size_100, ofWidth: true)),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  _showLikeAndComment(
      int? likes, PostListingController controller, int? id, int? postType) {
    return Row(
      children: [
        Row(
          children: [
            spacing(size: size_5, isForWidth: true),
            InkWell(
              onTap: () {
                controller.callLikeOrDislikePostApi(id, postType!);
              },
              child: Image.asset(
                likeEmptyImage,
                height: size_20,
                width: size_20,
              ),
            ),
            spacing(size: size_2, isForWidth: true),
            textWidget("$likes",
                style: textBlack(textStyleEnum: TextStyleEnum.bold))
          ],
        ),
        spacing(size: size_5, isForWidth: true),
        // Container(width: size_1,height: size_24,color: colorGrey,),
        Row(
          children: [
            spacing(size: size_5, isForWidth: true),
            Image.asset(
              commentImage,
              height: size_20,
              width: size_20,
            ),
            spacing(size: size_2, isForWidth: true),
            textWidget("10",
                style: textBlack(textStyleEnum: TextStyleEnum.bold))
          ],
        ),
      ],
    );
  }

  _showPostInfo(PostResponseModelDataDataPosts? postObj) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: size_12, right: size_12),
          child: textWidget(postObj?.user?.name ?? "N/A",
              style: textBlack(
                  textStyleEnum: TextStyleEnum.semiBold, size: size_16)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: size_12, right: size_12),
          child: textWidget(
              "${CustomDateUtils.dateUtilsInstance.convertStringToDefaultServerDateFormat(dateTime: postObj?.createdAt)}" ??
                  "N/A",
              style: textLightGrey(
                  textStyleEnum: TextStyleEnum.semiBold, size: size_12)),
        )
      ],
    );
  }
}
