import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/constants/text_style_constant.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/screens/noticeBoard/controller/notice_board_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/date_utils.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../constants/dimens.dart';
import '../../../widgets/async_call_parent_widget.dart';

class NoticeBoardPage extends BaseWidget {
  const NoticeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeBoardController>(
        builder: (NoticeBoardController controller) {
          final size = MediaQuery
              .of(context)
              .size;
          return ModalProgressHUD(
              inAsyncCall: controller.loading,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  elevation: 0.0,
                  titleSpacing: 0.0,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: black33Color,
                    ),
                  ),
                  title: Text(
                    getTranslate(context, 'notice_board.notice_board'),
                    style: semibold18Black33,
                  ),
                ),
                body: noticeboardListContent(controller),
              ));
        });
  }

  noticeboardListContent(NoticeBoardController controller) {
    return (controller.adminPostListingResponseModel != null &&
        controller.adminPostListingResponseModel?.data != null)?ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller.noticeScrollController,
      padding: const EdgeInsets.only(bottom: fixPadding),
      itemCount: controller.adminPostListingResponseModel?.data?.posts?.length,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          padding: languageValue == 4
              ? const EdgeInsets.only(right: fixPadding)
              : const EdgeInsets.only(left: fixPadding),
          margin: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0, vertical: fixPadding),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.25),
                blurRadius: 6.0,
              )
            ],
          ),
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: fixPadding * 1.4,
                          right: fixPadding,
                          top: fixPadding,
                        ),
                        child: Text(
                          controller.adminPostListingResponseModel?.data
                              ?.posts![index]?.title ?? "",
                          style: semibold16Black33,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: size_12, right: size_12,top: size_14),
                      child: textWidget(
                          "${CustomDateUtils.dateUtilsInstance.convertStringToDefaultServerDateFormat(dateTime: controller.adminPostListingResponseModel?.data
                              ?.posts![index]?.createdAt)}" ??
                              "N/A",
                          style: textLightGrey(
                              textStyleEnum: TextStyleEnum.semiBold, size: size_12)),
                    )
                    /* noticeList[index]['isNew'] == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: fixPadding * 1.3,
                                vertical: fixPadding / 2),
                            color: primaryColor,
                            alignment: Alignment.center,
                            child: Text(
                              getTranslate(context, 'notice_board.new'),
                              style: semibold12White,
                            ),
                          )
                        : const SizedBox()*/
                  ],
                ),
                height5Space,
                heightSpace,
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
                  child: Text(
                    controller.adminPostListingResponseModel?.data
                        ?.posts![index]?.content ?? "",
                    style: medium14Grey,
                    textAlign: TextAlign.left,
                  ),
                ),
                heightSpace,
                DottedBorder(
                  padding: EdgeInsets.zero,
                  color: greyColor,
                  dashPattern: const [2.5, 4.5],
                  child: Container(
                    width: double.maxFinite,
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.5,
                    vertical: fixPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${getTranslate(context, 'notice_board.post_by')} :${noticeList[index]['postBy']}",
                          style: medium14Black33,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          noticeList[index]['timeAndDate'].toString(),
                          style: medium14Grey,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )*/
              ],
            ),
          ),
        );
      },
    ):const SizedBox();
  }
}
