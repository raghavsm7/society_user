import 'package:fl_sevengen_society_user_app/constants/dimens.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/screens/addComplaint/controller/add_complaint_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/image_utils.dart';
import 'package:fl_sevengen_society_user_app/widgets/async_call_parent_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/base_widget.dart';
import 'package:fl_sevengen_society_user_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../enums/app_enums.dart';

class AddComplaintPage extends BaseWidget {
  final tabs = [
    {"name": translate('add_complaint.personal'), "icon": Icons.person_outline},
    {
      "name": translate('add_complaint.community'),
      "icon": Icons.home_work_outlined
    }
  ];

  int selectedTab = 0;

  AddComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddComplaintController>(
        builder: (AddComplaintController controller) {
      final size = MediaQuery.of(context).size;
      return WillPopScope(
        onWillPop: () async {
          Get.back();
          return false;
        },
        child: ModalProgressHUD(
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
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: black33Color,
                ),
              ),
              title: Text(
                getTranslate(context, 'Add Post'),
                style: semibold18Black33,
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.only(
                  top: fixPadding, bottom: fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                addImage(size, context, controller),
                heightSpace,
                heightSpace,
                height5Space,
                // tabBar(size),
                // heightSpace,
                heightSpace,
                height5Space,
                //complaintTypeField(context, controller),
                heightSpace,
                heightSpace,
                briefComplaintField(size, context, controller),
              ],
            ),
            bottomNavigationBar:
                submitComplaintButton(context, size, controller),
          ),
        ),
      );
    });
  }

  submitComplaintButton(
      BuildContext context, Size size, AddComplaintController controller) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
        onTap: () {
          controller.submitPost(context);
          // complaintRaisedDialog(context, size);
        },
        child: Container(
          margin: const EdgeInsets.all(fixPadding * 2.0),
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.1),
                blurRadius: 12.0,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Text(
            getTranslate(context, 'Submit Post'),
            style: semibold18White,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  complaintRaisedDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(fixPadding * 2.0),
            children: [
              Text(
                getTranslate(context, 'add_complaint.complaint_raised'),
                style: semibold16Black33,
                textAlign: TextAlign.center,
              ),
              heightSpace,
              Text(
                getTranslate(context, 'add_complaint.text'),
                style: semibold14Grey,
                textAlign: TextAlign.center,
              ),
              heightSpace,
              heightSpace,
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/bottomBar');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 4.5, vertical: fixPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: 12.0,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      getTranslate(context, 'add_complaint.okay'),
                      style: semibold16White,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  briefComplaintField(
      Size size, BuildContext context, AddComplaintController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'Brief your post'),
            style: medium16Black33,
          ),
          height5Space,
          height5Space,
          height5Space,
          Container(
            height: size.height * 0.16,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: TextField(
              style: semibold15Black33,
              cursorColor: primaryColor,
              controller: controller.postEditingController,
              expands: true,
              maxLines: null,
              minLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'Brief your post'),
                hintStyle: medium15Grey,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.5, vertical: fixPadding * 1.4),
              ),
            ),
          )
        ],
      ),
    );
  }

  complaintTypeField(BuildContext context, AddComplaintController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'Post Title'),
            style: medium16Black33,
          ),
          height5Space,
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: TextField(
              style: semibold15Black33,
              cursorColor: primaryColor,
              controller: controller.titleEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'Enter post title'),
                hintStyle: medium15Grey,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
              ),
            ),
          )
        ],
      ),
    );
  }

  addImage(Size size, BuildContext context, AddComplaintController controller) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              addImageDialog(context, controller);
            },
            child: (GetUtils.isNullOrBlank(
                        controller.uploadImageResponseModel.data?.imagePath) ==
                    false)
                ? ImageUtils.imageUtilsInstance.showCacheNetworkImage(
                    imageURL: controller
                            .uploadImageResponseModel.data?.imagePath ??
                        "",
                    showProgressBarInPlaceHolder: true,
                    shape: BoxShape.rectangle,
                    showDefaultErrorWidget: true,
                    height: AppUtils.appUtilsInstance
                        .getPercentageSize(percentage: size_16),
                    width: AppUtils.appUtilsInstance
                        .getPercentageSize(percentage: size_16))
                : Container(
                    height: size.height * 0.13,
                    width: size.height * 0.13,
                    margin: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: f2Color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: primaryColor,
                      size: 28.0,
                    ),
                  ),
            /*Container(
              height: size.height * 0.13,
              width: size.height * 0.13,
              margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              decoration: BoxDecoration(
                color: f2Color,
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: primaryColor,
                size: 28.0,
              ),
            )*/
          ),
        ),
        heightSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            getTranslate(context, 'add_complaint.attach_photo'),
            style: semibold16Black33,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  addImageDialog(BuildContext context, AddComplaintController controller) {
    /*  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(fixPadding * 2.0),
          children: [
            Text(
              getTranslate(context, 'add_complaint.add_image'),
              style: semibold18Black33,
            ),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.camera_alt, const Color(0xFF1E4799),
                getTranslate(context, 'add_complaint.camera')),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.photo, const Color(0xFF1E996D),
                getTranslate(context, 'add_complaint.gallery')),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.delete, const Color(0xFFEF1717),
                getTranslate(context, 'add_complaint.remove')),
          ],
        );
      },
    );*/
    return getCustomDialogWidget(
        child: Column(
      children: [
        InkWell(
            onTap: () {
              Get.back();
              controller.onImageOptionSelect(ImageSelectionEnum.camera);
            },
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: textWidget("Take Image"))),
        const Divider(thickness: size_1),
        InkWell(
            onTap: () {
              Get.back();
              controller.onImageOptionSelect(ImageSelectionEnum.gallery);
            },
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: textWidget("Upload Image"))),
        /*   const Divider(thickness: size_1),
        InkWell(
            onTap: () {
              Get.back();
              controller.onImageOptionSelect(ImageSelectionEnum.remove);
            },
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: textWidget("Remove Image"))),*/
      ],
    ));
  }

  optionWidget(BuildContext context, IconData icon, Color color, String title) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.2),
                  blurRadius: 5.0,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: color,
            ),
          ),
          widthSpace,
          width5Space,
          Expanded(
            child: Text(
              title,
              style: medium16Black33,
            ),
          )
        ],
      ),
    );
  }

  tabBar(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                /*  setState(() {
                  selectedTab = index;
                });*/
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                padding: const EdgeInsets.symmetric(vertical: fixPadding * 1.3),
                decoration: BoxDecoration(
                  color: selectedTab == index ? primaryColor : whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: (selectedTab == index ? primaryColor : shadowColor)
                          .withOpacity(0.25),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index]['icon'] as IconData,
                      color: selectedTab == index ? whiteColor : black33Color,
                    ),
                    width5Space,
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width * 0.3),
                      child: Text(
                        tabs[index]['name'].toString(),
                        style: selectedTab == index
                            ? semibold16White
                            : semibold16Black33,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
