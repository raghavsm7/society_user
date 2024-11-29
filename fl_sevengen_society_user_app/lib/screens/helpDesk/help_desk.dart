import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  final tabs = [
    translate('help_desk.personal'),
    translate('help_desk.community')
  ];

  int selectedTab = 0;

  final personalList = [
    {
      "type": "Electricity",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Power fluctuates sometime",
      "person": "George Haydon",
      "status": "Resolved",
    },
    {
      "type": "Plumbing",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Valve is not working",
      "person": "Raghuvir pate",
      "status": "Pending",
    },
    {
      "type": "Electricity",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Power fluctuates sometime",
      "person": "George Haydon",
      "status": "Resolved",
    },
  ];

  final communityList = [
    {
      "image": "assets/helpDesk/member1.png",
      "type": "Parking",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Water leakage in parking area",
      "person": "Raghuveer Patel",
      "status": "Pending",
    },
    {
      "image": "assets/helpDesk/member2.png",
      "type": "Plumbing",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Valve is not working",
      "person": "Natasha jain",
      "status": "Pending",
    },
    {
      "image": "assets/helpDesk/member3.png",
      "type": "Electricity",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Power fluctuates sometime",
      "person": "George Haydon",
      "status": "Resolved",
    },
    {
      "image": "assets/helpDesk/member1.png",
      "type": "Parking",
      "dateTime": "22 Aug, 03:30 pm",
      "complaint": "Water leakage in parking area",
      "person": "Mihir sharma",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
          getTranslate(context, 'help_desk.help_desk'),
          style: semibold18Black33,
        ),
      ),
      body: Column(
        children: [
          tabBar(),
          if (selectedTab == 0) personalHelpListContent(size),
          if (selectedTab == 1) communityHelpListContent(size),
        ],
      ),
      bottomNavigationBar: raisedNewComplaintButton(),
    );
  }

  raisedNewComplaintButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/addComplaint');
      },
      child: Container(
        margin: const EdgeInsets.all(fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
        width: double.maxFinite,
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
          getTranslate(context, 'help_desk.raise_new_complaint'),
          style: semibold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  communityHelpListContent(Size size) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: fixPadding),
        itemCount: communityList.length,
        itemBuilder: (context, index) {
          return listContent(
              size,
              index,
              communityList[index]['image'].toString(),
              communityList[index]['type'].toString(),
              communityList[index]['dateTime'].toString(),
              communityList[index]['complaint'].toString(),
              communityList[index]['status'].toString(),
              communityList[index]['person'].toString(), () {
            Navigator.pushNamed(context, '/complaintDetail',
                arguments: communityList[index]);
          });
        },
      ),
    );
  }

  personalHelpListContent(Size size) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: fixPadding),
        itemCount: personalList.length,
        itemBuilder: (context, index) {
          return listContent(
              size,
              index,
              "assets/helpDesk/member1.png",
              personalList[index]['type'].toString(),
              personalList[index]['dateTime'].toString(),
              personalList[index]['complaint'].toString(),
              personalList[index]['status'].toString(),
              personalList[index]['person'].toString(), () {
            Navigator.pushNamed(context, '/complaintDetail',
                arguments: personalList[index]);
          });
        },
      ),
    );
  }

  listContent(Size size, int index, String image, String type, String dateTime,
      String complaint, String status, String person, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: fixPadding, horizontal: fixPadding * 2.0),
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
                        image: AssetImage(image),
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
                          type,
                          style: semibold16Black33,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text(
                          dateTime,
                          style: medium14Grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text(
                          complaint,
                          style: medium14Grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text.rich(
                          TextSpan(
                            text: status == "Resolved"
                                ? "${getTranslate(context, 'help_desk.resolved_by')} :"
                                : "${getTranslate(context, 'help_desk.raised_by')} : ",
                            style: medium14Grey,
                            children: [
                              TextSpan(
                                text: person,
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
                color: status == "Resolved" ? green3EColor : lightRedColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding, vertical: fixPadding / 3),
                child: Text(
                  status,
                  style: semibold16White,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
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
                child: Text(
                  tabs[index],
                  style:
                      selectedTab == index ? semibold16White : semibold16Grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
