import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ComplaintDetailScreen extends StatefulWidget {
  const ComplaintDetailScreen({super.key});

  @override
  State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  TextEditingController commentController = TextEditingController();

  final complaintImages = [
    "assets/complaintDetail/image1.png",
    "assets/complaintDetail/image2.png"
  ];

  final commentList = [
    {
      "image": "assets/complaintDetail/comment1.png",
      "name": "Esther Howard",
      "flatNo": "A-252",
      "time": "2min",
      "comment":
          "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. "
    },
    {
      "image": "assets/complaintDetail/comment2.png",
      "name": "Leslie Alexander",
      "flatNo": "A-252",
      "time": "2min",
      "comment":
          "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. "
    },
    {
      "image": "assets/complaintDetail/comment3.png",
      "name": "Cameron Williamson",
      "flatNo": "A-252",
      "time": "2min",
      "comment":
          "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. "
    },
    {
      "image": "assets/complaintDetail/comment4.png",
      "name": "Kristin Watson",
      "flatNo": "A-252",
      "time": "2min",
      "comment":
          "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. "
    },
    {
      "image": "assets/complaintDetail/comment5.png",
      "name": "Bessie Cooper",
      "flatNo": "A-252",
      "time": "2min",
      "comment":
          "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. "
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   // final data = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
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
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslate(context, 'complaint_detail.community_complaint'),
                  style: semibold16Black33,
                ),
                heightSpace,
              //  complaintByDetail(size, data),
                heightSpace,
                heightSpace,
                //button(data),
                heightSpace,
                heightSpace,
                Text(
                  getTranslate(context, 'complaint_detail.complaint_image'),
                  style: semibold16Black33,
                ),
              ],
            ),
          ),
          images(size),
          detailText(),
          heightSpace,
          heightSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Text(
              getTranslate(context, 'complaint_detail.recent_comments'),
              style: semibold16Black33,
            ),
          ),
          commentListContent()
        ],
      ),
      bottomNavigationBar: writeCommentField(context),
    );
  }

  writeCommentField(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              cursorColor: whiteColor,
              style: semibold14White,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.8, vertical: fixPadding * 1.6),
                hintText: getTranslate(
                    context, 'complaint_detail.write_your_comment'),
                hintStyle: medium14White,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (commentController.text.isNotEmpty) {
                setState(() {
                  commentList.add({
                    "image": "assets/helpDesk/member1.png",
                    "name": "Jacob Jones",
                    "flatNo": "A-252",
                    "time": "2min",
                    "comment": commentController.text,
                  });
                  commentController.clear();
                  commentList;
                });
              }
            },
            child: Container(
              height: 37,
              width: 37,
              margin: const EdgeInsets.symmetric(
                  vertical: fixPadding, horizontal: fixPadding * 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
                border: Border.all(color: primaryColor),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.25),
                    blurRadius: 5.0,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.send,
                color: primaryColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  commentListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 47.0,
                        width: 47.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              commentList[index]['image'].toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commentList[index]['name'].toString(),
                              style: medium16Black33,
                              overflow: TextOverflow.ellipsis,
                            ),
                            height5Space,
                            Text(
                              commentList[index]['flatNo'].toString(),
                              style: medium14Grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${commentList[index]['time']} ${getTranslate(context, 'complaint_detail.ago')}",
                        style: medium14Grey,
                      )
                    ],
                  ),
                  heightSpace,
                  Text(
                    commentList[index]['comment'].toString(),
                    style: medium14Grey,
                  )
                ],
              ),
            ),
            commentList.length == index + 1
                ? const SizedBox()
                : Container(
                    width: double.maxFinite,
                    height: 1.0,
                    color: greyD4Color,
                    margin: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                  )
          ],
        );
      },
      itemCount: commentList.length,
    );
  }

  images(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(fixPadding),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          complaintImages.length,
          (index) => Container(
            height: 110,
            width: (size.width / 2) - 30,
            margin: const EdgeInsets.symmetric(horizontal: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(
                  complaintImages[index],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  detailText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: ReadMoreText(
        "Lorem ipsum dolor sit amet consectetur. Faciliametnibh nibh amet dignissim sed vitae habitant. Nisl ut sodamet sapien. Libero aliquet nunc tellus orci sodales ath duxis fames mi. In hac posuere quisque vulputate non aliquet placerat eget sit. Commodo nullam pellentesque et.",
        style: medium14Grey,
        lessStyle: medium14Primary,
        moreStyle: medium14Primary,
      ),
    );
  }

  button(data) {
    return Container(
      width: double.maxFinite,
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
      alignment: Alignment.center,
      child: Text(
        data['status'] == "Resolved"
            ? getTranslate(context, 'complaint_detail.reopen')
            : getTranslate(context, 'complaint_detail.mark_as_resolved'),
        style: semibold18White,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  complaintByDetail(Size size, Map<String, String> data) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(fixPadding * 1.5),
            child: Row(
              children: [
                Container(
                  height: size.width * 0.2,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: AssetImage(
                          data['image'] ?? "assets/helpDesk/member1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['type'].toString(),
                        style: semibold16Black33,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5Space,
                      Text(
                        data['dateTime'].toString(),
                        style: medium14Grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5Space,
                      Text(
                        data['complaint'].toString(),
                        style: medium14Grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5Space,
                      Text.rich(
                        TextSpan(
                          text: data['status'] == "Resolved"
                              ? "${getTranslate(context, 'complaint_detail.resolved_by')} :"
                              : "${getTranslate(context, 'complaint_detail.raised_by')} : ",
                          style: medium14Grey,
                          children: [
                            TextSpan(
                              text: data['person'],
                              style: medium14Black33,
                            )
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment:
                languageValue == 4 ? Alignment.topLeft : Alignment.topRight,
            child: Container(
              color:
                  data['status'] == "Resolved" ? green3EColor : lightRedColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding, vertical: fixPadding / 3),
              child: Text(
                data['status'].toString(),
                style: semibold16White,
              ),
            ),
          )
        ],
      ),
    );
  }
}
