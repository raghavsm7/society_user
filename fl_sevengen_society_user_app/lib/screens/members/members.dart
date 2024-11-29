import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final memberList = [
    {
      "image": "assets/members/member1.png",
      "name": "Cameron Williamson",
      "homeNumber": "Block A-420",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member2.png",
      "name": "Brooklyn Simmons",
      "homeNumber": "Block A-421",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member3.png",
      "name": "Savannah Nguyen",
      "homeNumber": "Block A-422",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member4.png",
      "name": "Bessie Cooper",
      "homeNumber": "Block A-423",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member5.png",
      "name": "Darlene Robertson",
      "homeNumber": "Block A-420",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member6.png",
      "name": "Darrell Steward",
      "homeNumber": "Block A-422",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member7.png",
      "name": "Courtney Henry",
      "homeNumber": "Block A-423",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member8.png",
      "name": "Kathryn Murphy",
      "homeNumber": "Block A-424",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member9.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-421",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member10.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-422",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member11.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-423",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member12.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-424",
      "societyName": "SevenGen society",
    },
  ];

  final adminList = [
    {
      "image": "assets/members/member1.png",
      "name": "Cameron Williamson",
      "homeNumber": "Block A-420",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member7.png",
      "name": "Courtney Henry",
      "homeNumber": "Block A-426",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member8.png",
      "name": "Kathryn Murphy",
      "homeNumber": "Block A-427",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member2.png",
      "name": "Brooklyn Simmons",
      "homeNumber": "Block A-421",
      "societyName": "SevenGen society",
    },
  ];

  final committeeList = [
    {
      "image": "assets/members/member1.png",
      "name": "Cameron Williamson",
      "homeNumber": "Block A-420",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member7.png",
      "name": "Courtney Henry",
      "homeNumber": "Block A-426",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member2.png",
      "name": "Brooklyn Simmons",
      "homeNumber": "Block A-421",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member3.png",
      "name": "Savannah Nguyen",
      "homeNumber": "Block A-422",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member9.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-421",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member11.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-423",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member13.png",
      "name": "Bessie Cooper",
      "homeNumber": "Block A-423",
      "societyName": "SevenGen society",
    },
    {
      "image": "assets/members/member12.png",
      "name": "Marvin McKinney",
      "homeNumber": "Block A-424",
      "societyName": "SevenGen society",
    },
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        toolbarHeight: 50.0,
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
          getTranslate(context, 'members.members'),
          style: semibold18Black33,
        ),
      ),
      body: Column(
        children: [
          tabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                memberListContent(size),
                adminListContent(size),
                committeeListContent(size),
              ],
            ),
          ),
        ],
      ),
    );
  }

  committeeListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: committeeList.length,
      itemBuilder: (context, index) {
        return listContent(
            index,
            committeeList[index]['image'].toString(),
            committeeList[index]['name'].toString(),
            committeeList[index]['homeNumber'].toString(),
            committeeList[index]['societyName'].toString(),
            size);
      },
    );
  }

  adminListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: adminList.length,
      itemBuilder: (context, index) {
        return listContent(
            index,
            adminList[index]['image'].toString(),
            adminList[index]['name'].toString(),
            adminList[index]['homeNumber'].toString(),
            adminList[index]['societyName'].toString(),
            size);
      },
    );
  }

  memberListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: memberList.length,
      itemBuilder: (context, index) {
        return listContent(
            index,
            memberList[index]['image'].toString(),
            memberList[index]['name'].toString(),
            memberList[index]['homeNumber'].toString(),
            memberList[index]['societyName'].toString(),
            size);
      },
    );
  }

  listContent(int index, String image, String name, String homeNumber,
      String society, Size size) {
    return GestureDetector(
      onTap: () {
        memberDetailDialog(size);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: fixPadding, horizontal: fixPadding * 2.0),
        padding: const EdgeInsets.all(fixPadding * 0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 58.0,
              width: 58.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: AssetImage(
                    image,
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
                    name,
                    style: semibold16Black33,
                    overflow: TextOverflow.ellipsis,
                  ),
                  height5Space,
                  Text(
                    "$homeNumber | $society",
                    style: medium14Grey,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  memberDetailDialog(Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: fixPadding * 2.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: fixPadding,
                      left: fixPadding,
                      top: fixPadding,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: greyColor,
                        size: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.082,
                        width: size.height * 0.082,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: const DecorationImage(
                            image: AssetImage("assets/members/member1.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    heightSpace,
                    const Text(
                      "Cameron Williamson",
                      style: semibold16Black33,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    height5Space,
                    const Text(
                      "+91 1234567890",
                      style: medium14Grey,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        detailWidget(
                            Ionicons.business_outline, "SevenGen", "society"),
                        verticalDivider(),
                        detailWidget(
                            Icons.home_outlined,
                            "${getTranslate(context, 'members.flat_no')} :",
                            "521"),
                        verticalDivider(),
                        detailWidget(
                            Icons.home_work_outlined,
                            "${getTranslate(context, 'members.block_no:')}:",
                            "A"),
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        buttonWidget(size, blueColor, Icons.call_outlined,
                            getTranslate(context, 'members.call'), () {
                          Navigator.popAndPushNamed(context, '/call',
                              arguments: {"id": 1});
                        }),
                        widthSpace,
                        widthSpace,
                        buttonWidget(
                            size,
                            greenColor,
                            CupertinoIcons.ellipses_bubble,
                            getTranslate(context, 'members.chat'), () {
                          Navigator.popAndPushNamed(context, '/message');
                        })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  buttonWidget(
      Size size, Color color, IconData icon, String title, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: whiteColor,
              ),
              widthSpace,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * 0.2),
                child: Text(
                  title,
                  style: semibold18White,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  verticalDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
      height: 60.0,
      width: 1,
      color: greyColor,
    );
  }

  detailWidget(IconData icon, String title, String detail) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 35.0,
            width: 35.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: d9EAF4Color,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 20.0,
            ),
          ),
          heightSpace,
          Text(
            title,
            style: medium14Black33,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            detail,
            style: medium14Black33,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  tabBar() {
    return Stack(
      children: [
        Container(
          height: 35,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFD9D9D9),
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: TabBar(
            controller: tabController,
            labelStyle: semibold16Primary.copyWith(fontFamily: 'Inter'),
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            unselectedLabelColor: greyColor,
            tabs: [
              Tab(text: getTranslate(context, 'members.member')),
              Tab(text: getTranslate(context, 'members.admin')),
              Tab(text: getTranslate(context, 'members.committee')),
            ],
          ),
        )
      ],
    );
  }
}
