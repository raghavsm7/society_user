import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:ionicons/ionicons.dart';

import '../../theme/theme.dart';
import '../../widget/column_builder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String relationName = '';
  int selectedRelation = 0;

  final relationList = [
    translate('profile.father'),
    translate('profile.mother'),
    translate('profile.son'),
    translate('profile.daughter'),
    translate('profile.wife')
  ];
  String helpName = '';
  int selectedHelp = 0;

  final helpList = ["Made", "Laundryman", "Gardner", "Cook", "Milkman"];

  final familyList = [
    {
      "image": "assets/profile/familyMember1.png",
      "title": "Robert Fox",
      "relation": "Father"
    },
    {
      "image": "assets/profile/familyMember2.png",
      "title": "Guy Hawkins",
      "relation": "Mother"
    },
    {
      "image": "assets/profile/familyMember3.png",
      "title": "Floyd Miles",
      "relation": "wife"
    },
    {
      "image": "assets/profile/familyMember4.png",
      "title": "Jenny Wilson",
      "relation": "Son"
    },
    {
      "image": "assets/profile/familyMember5.png",
      "title": "Wade Warren",
      "relation": "Daughter"
    },
  ];

  final dailyHelpersList = [
    {
      "image": "assets/profile/dailyHelp1.png",
      "title": "Robert Fox",
      "type": "Maid"
    },
    {
      "image": "assets/profile/dailyHelp2.png",
      "title": "Guy Hawkins",
      "type": "Laundry"
    },
    {
      "image": "assets/profile/dailyHelp3.png",
      "title": "Wade Warren",
      "type": "Milkman"
    },
  ];

  final vehiclesList = [
    {
      "image": "assets/profile/vehicle1.png",
      "number": "GJ-5 0125",
      "type": "Audi (black)"
    },
    {
      "image": "assets/profile/vehicle2.png",
      "number": "GJ-5 1245",
      "type": "Activa (white)"
    },
  ];

  final frequentEntriesList = [
    {
      "image": "assets/profile/person1.png",
      "name": "Cody Fisher",
      "relation": "Friend"
    },
    {
      "image": "assets/profile/person2.png",
      "name": "Devon Lane",
      "relation": "Friend"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 20.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          getTranslate(context, 'profile.profile'),
          style: semibold22Black33,
        ),
        actions: [
          IconButton(
            onPressed: () {
             // Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              CupertinoIcons.gear,
              color: black33Color,
            ),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: fixPadding * 9.0),
        children: [
          userDetail(context, size),
          householdTitle(),
          heightSpace,
          heightSpace,
          title(getTranslate(context, 'profile.my_family'),
              getTranslate(context, 'profile.add_family_member'), () {
            addFamilyMemberDialog(context, size);
          }),
          height5Space,
          familyListContent(size),
          heightSpace,
          dottedDivider(),
          heightSpace,
          heightSpace,
          title(getTranslate(context, 'profile.daily_help'),
              getTranslate(context, 'profile.add_helper_text'), () {
            addDailyHelpDialog(context, size);
          }),
          height5Space,
          dailyHelperListContent(size),
          heightSpace,
          dottedDivider(),
          heightSpace,
          heightSpace,
          title(getTranslate(context, 'profile.my_vehicles'),
              getTranslate(context, 'profile.add_vehicles_text'), () {
            addVehiclesDialog(context, size);
          }),
          height5Space,
          vehiclesListContent(size),
          heightSpace,
          dottedDivider(),
          heightSpace,
          heightSpace,
          title(getTranslate(context, 'profile.frequent_entries'),
              getTranslate(context, 'profile.add_frequent_entries_text'), () {
            addFrequentEntriesDialog(context, size);
          }),
          height5Space,
          frequentEntriesListContent(size),
        ],
      ),
    );
  }

  frequentEntriesListContent(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 1.25),
      child: Row(
        children: List.generate(
          frequentEntriesList.length,
          (index) => listContent(
              size,
              index,
              frequentEntriesList[index]['image'].toString(),
              frequentEntriesList[index]['name'].toString(),
              frequentEntriesList[index]['relation'].toString()),
        ),
      ),
    );
  }

  vehiclesListContent(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 1.25),
      child: Row(
        children: List.generate(
          vehiclesList.length,
          (index) => listContent(
              size,
              index,
              vehiclesList[index]['image'].toString(),
              vehiclesList[index]['number'].toString(),
              vehiclesList[index]['type'].toString()),
        ),
      ),
    );
  }

  dailyHelperListContent(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 1.25),
      child: Row(
        children: List.generate(
          dailyHelpersList.length,
          (index) => listContent(
              size,
              index,
              dailyHelpersList[index]['image'].toString(),
              dailyHelpersList[index]['title'].toString(),
              dailyHelpersList[index]['type'].toString()),
        ),
      ),
    );
  }

  dottedDivider() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      color: greyColor,
      dashPattern: const [2.5, 4.5],
      child: Container(
        width: double.maxFinite,
      ),
    );
  }

  familyListContent(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 1.25),
      child: Row(
        children: List.generate(
          familyList.length,
          (index) => listContent(
              size,
              index,
              familyList[index]['image'].toString(),
              familyList[index]['title'].toString(),
              familyList[index]['relation'].toString()),
        ),
      ),
    );
  }

  listContent(Size size, int index, String image, String title, String text) {
    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 0.75),
      padding: const EdgeInsets.all(fixPadding),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 48.0,
                width: 48.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  gatePassDialog(context, size);
                },
                child: const Iconify(
                  Carbon.qr_code,
                  color: greyColor,
                  size: 26,
                ),
              )
            ],
          ),
          heightBox(fixPadding * 0.8),
          Text(
            title,
            style: semibold15Black33,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            text,
            style: medium14Grey,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  title(String title, String detail, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: semibold16Black33,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Text(
                  detail,
                  style: medium14Grey,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding, vertical: fixPadding / 2),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.1),
                    blurRadius: 12.0,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 20.0,
                  ),
                  Text(
                    getTranslate(context, 'profile.add'),
                    style: semibold15White,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  householdTitle() {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.2),
      width: double.maxFinite,
      color: f6f3Color,
      alignment: Alignment.center,
      child: Text(
        getTranslate(context, 'profile.household'),
        style: semibold16Primary,
      ),
    );
  }

  userDetail(BuildContext context, Size size) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding * 2.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F8),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: d2E3EFColor,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          border: Border.all(color: whiteColor, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor.withOpacity(0.2),
                              blurRadius: 6.0,
                            )
                          ],
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/profile/profile-image.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jacob Jones",
                              style: semibold18Primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                            height5Space,
                            Text(
                              getTranslate(context, 'profile.view_profile'),
                              style: medium14Grey,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    gatePassDialog(context, size);
                  },
                  child: const Iconify(
                    Carbon.qr_code,
                    size: 40,
                    color: greyColor,
                  ),
                )
              ],
            ),
          ),
          DottedBorder(
            padding: EdgeInsets.zero,
            color: greyB4Color,
            dashPattern: const [2.5, 4.5],
            child: Container(
              width: double.maxFinite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      detailWidget(
                          Ionicons.business_outline, "SevenGen", "society"),
                      verticalDivider(),
                      detailWidget(
                          Icons.home_outlined,
                          "${getTranslate(context, 'profile.flat_no')} :",
                          "521"),
                      verticalDivider(),
                      detailWidget(Icons.home_work_outlined,
                          "${getTranslate(context, 'profile.block_no')}:", "A"),
                    ],
                  ),
                ),
                widthSpace,
                widthSpace,
                const Icon(
                  Icons.share_outlined,
                  color: primaryColor,
                )
              ],
            ),
          )
        ],
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
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: f6f3Color,
              border: Border.all(
                color: greyB4Color.withOpacity(0.5),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 18.0,
              color: primaryColor,
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

  gatePassDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          shadowColor: Colors.transparent,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                     // Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              heightSpace,
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.25),
                      blurRadius: 6.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(fixPadding * 1.2),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        getTranslate(context, 'profile.gate_pass'),
                        style: semibold18WhiteF3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(fixPadding * 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 55.0,
                            width: 55.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: d5DEE3Color,
                              border: Border.all(color: whiteColor, width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColor.withOpacity(0.25),
                                  blurRadius: 6.0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/visitor/guests.png",
                              height: 33,
                              width: 33,
                            ),
                          ),
                          width5Space,
                          widthSpace,
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Krishna shah',
                                  style: semibold16Black33,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                heightBox(3.0),
                                Text(
                                  "${getTranslate(context, 'profile.guest_at')}  B-524",
                                  style: medium16Grey,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    DottedBorder(
                      padding: EdgeInsets.zero,
                      color: greyColor,
                      dashPattern: const [2.5, 4],
                      child: Container(
                        width: double.maxFinite,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(fixPadding * 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightSpace,
                          const Center(
                            child: Iconify(
                              Bi.qr_code_scan,
                              size: 110,
                              color: black33Color,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Text(
                            getTranslate(context, 'profile.entry_code'),
                            style: semibold16Black33,
                          ),
                          heightSpace,
                          Container(
                            padding: const EdgeInsets.all(fixPadding * 1.4),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor.withOpacity(0.25),
                                    blurRadius: 6.0)
                              ],
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "5412245",
                                    style: medium16Grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                widthSpace,
                                Icon(Icons.copy, size: 20.0, color: greyColor)
                              ],
                            ),
                          ),
                          height5Space,
                          Text(
                            getTranslate(context, 'profile.show_qr_code'),
                            style: medium14Primary,
                          ),
                          heightSpace,
                          heightSpace,
                          height5Space,
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                   // Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: fixPadding,
                                        vertical: fixPadding * 1.4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadowColor.withOpacity(0.25),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      getTranslate(context, 'profile.share'),
                                      style: semibold18Black33,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              widthSpace,
                              widthSpace,
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    //Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: fixPadding,
                                        vertical: fixPadding * 1.4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: primaryColor,
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
                                      getTranslate(context, 'profile.download'),
                                      style: semibold18White,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  addFrequentEntriesDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        bool sendgatePass = true;
        return StatefulBuilder(builder: (context, state) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.25),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(
                                  context, 'profile.add_frequent_entries'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          dialogTitle(getTranslate(context, 'profile.name')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.name,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText:
                                    getTranslate(context, 'profile.enter_name'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          height5Space,
                          dialogTitle(
                              getTranslate(context, 'profile.phone_number')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              style: semibold14Black33,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_phone_number'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          height5Space,
                          heightSpace,
                          dialogTitle(
                              getTranslate(context, 'profile.relations')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_relations'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          sendGatePassCheckBox(sendgatePass, () {
                            state(() {
                              setState(() {
                                sendgatePass = !sendgatePass;
                              });
                            });
                          }),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context, size, () {
                           // Navigator.pop(context);
                          }),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      closeButton(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  addVehiclesDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        bool sendgatePass = true;
        return StatefulBuilder(builder: (context, state) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.25),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(context, 'profile.add_daily_help'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          dialogTitle(
                              getTranslate(context, 'profile.vehicle_number')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.visiblePassword,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_vehicle_number'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          height5Space,
                          dialogTitle(
                              getTranslate(context, 'profile.vehicle_model')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_vehicle_model'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          height5Space,
                          heightSpace,
                          dialogTitle(
                              getTranslate(context, 'profile.vehicle_colour')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_vehicle_colour'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          sendGatePassCheckBox(sendgatePass, () {
                            state(() {
                              setState(() {
                                sendgatePass = !sendgatePass;
                              });
                            });
                          }),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context, size, () {
                           // Navigator.pop(context);
                          }),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      closeButton(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  addDailyHelpDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        bool sendgatePass = true;
        return StatefulBuilder(builder: (context, state) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.25),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(context, 'profile.add_daily_help'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          dialogTitle(getTranslate(context, 'profile.name')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.name,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText:
                                    getTranslate(context, 'profile.enter_name'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          height5Space,
                          dialogTitle(
                              getTranslate(context, 'profile.phone_number')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.phone,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_phone_number'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          height5Space,
                          heightSpace,
                          dialogTitle(
                              getTranslate(context, 'profile.help_type')),
                          height5Space,
                          GestureDetector(
                            onTap: () {
                              helpNameDialog(context, state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: helpName.isEmpty
                                        ? Text(
                                            getTranslate(context,
                                                'profile.select_help_type'),
                                            style: medium14Grey,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            helpName,
                                            style: semibold14Black33,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                  width5Space,
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: black33Color,
                                  )
                                ],
                              ),
                            ),
                          ),
                          heightSpace,
                          sendGatePassCheckBox(sendgatePass, () {
                            state(() {
                              setState(() {
                                sendgatePass = !sendgatePass;
                              });
                            });
                          }),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context, size, () {
                       //     Navigator.pop(context);
                            setState(() {
                              helpName = "";
                              selectedHelp = 0;
                            });
                          }),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      closeButton(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  addFamilyMemberDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        bool sendgatePass = true;
        return StatefulBuilder(builder: (context, state) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.25),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(context, 'profile.add_member'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          dialogTitle(getTranslate(context, 'profile.name')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.name,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText:
                                    getTranslate(context, 'profile.enter_name'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          heightSpace,
                          height5Space,
                          dialogTitle(
                              getTranslate(context, 'profile.phone_number')),
                          height5Space,
                          Container(
                            decoration: boxDecoration(),
                            child: TextField(
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.phone,
                              style: semibold14Black33,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: getTranslate(
                                    context, 'profile.enter_phone_number'),
                                hintStyle: medium14Grey,
                              ),
                            ),
                          ),
                          height5Space,
                          heightSpace,
                          dialogTitle(
                              getTranslate(context, 'profile.relations')),
                          height5Space,
                          GestureDetector(
                            onTap: () {
                              relationNameDialog(context, state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: relationName.isEmpty
                                        ? Text(
                                            getTranslate(context,
                                                'profile.select_relations'),
                                            style: medium14Grey,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            relationName,
                                            style: semibold14Black33,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                  width5Space,
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: black33Color,
                                  )
                                ],
                              ),
                            ),
                          ),
                          heightSpace,
                          sendGatePassCheckBox(sendgatePass, () {
                            state(() {
                              setState(() {
                                sendgatePass = !sendgatePass;
                              });
                            });
                          }),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context, size, () {
                            //Navigator.pop(context);
                            setState(() {
                              relationName = "";
                              selectedRelation = 0;
                            });
                          }),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      closeButton(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  sendGatePassCheckBox(bool sendgatePass, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 16.0,
            width: 16.0,
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(2.0),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.1),
                  blurRadius: 12.0,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            alignment: Alignment.center,
            child: sendgatePass == true
                ? const Icon(
                    Icons.done,
                    color: primaryColor,
                    size: 13.0,
                  )
                : const SizedBox(),
          ),
          widthSpace,
          Expanded(
            child: Text(
              getTranslate(context, 'profile.send_gate_pass_guest'),
              style: medium14Grey,
            ),
          )
        ],
      ),
    );
  }

  helpNameDialog(BuildContext context, StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedHelp;

        return StatefulBuilder(builder: (context, states) {
          return Dialog(
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 1.6),
                  child: Text(
                    getTranslate(context, 'profile.help_type'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selected, helpList[index], () {
                      states(() {
                        setState(() {
                          selected = index;
                        });
                      });
                    });
                  },
                  itemCount: helpList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(
                          context, getTranslate(context, 'profile.cancel'), () {
                       // Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(
                          context, getTranslate(context, 'profile.okay'), () {
                        state(() {
                          setState(() {
                            helpName = helpList[selected];
                            selectedHelp = selected;
                          });
                         // Navigator.pop(context);
                        });
                      })
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  relationNameDialog(BuildContext context, StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedRelation;

        return StatefulBuilder(builder: (context, states) {
          return Dialog(
            insetPadding: const EdgeInsets.all(fixPadding * 2.0),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 1.6),
                  child: Text(
                    getTranslate(context, 'profile.relation'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selected, relationList[index], () {
                      states(() {
                        setState(() {
                          selected = index;
                        });
                      });
                    });
                  },
                  itemCount: relationList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(
                          context, getTranslate(context, 'profile.cancel'), () {
                       // Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(
                          context, getTranslate(context, 'profile.okay'), () {
                        state(() {
                          setState(() {
                            relationName = relationList[selected];
                            selectedRelation = selected;
                          });
                         // Navigator.pop(context);
                        });
                      })
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  selectOptionListContent(int index, selected, String text, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                border: selected == index
                    ? Border.all(color: primaryColor, width: 7.5)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.25),
                    blurRadius: 6.0,
                  )
                ],
              ),
            ),
            widthSpace,
            Expanded(
              child: Text(
                text,
                style: medium16Black33,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context, String name, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
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
            name,
            style: semibold18White,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  whiteButton(BuildContext context, String name, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding, vertical: fixPadding * 1.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.25),
                blurRadius: 6.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            name,
            style: semibold18Black33,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  submitButton(BuildContext context, Size size, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'profile.submit'),
          style: semibold18White,
        ),
      ),
    );
  }

  boxDecoration() {
    return BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.25),
          blurRadius: 6.0,
        )
      ],
    );
  }

  dialogTitle(String title) {
    return Text(
      title,
      style: medium16Black33,
    );
  }

  closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(fixPadding),
      child: InkWell(
        onTap: () {
        //  Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          color: greyColor,
          size: 22,
        ),
      ),
    );
  }

  dialogTopImage(Size size) {
    return Positioned(
      top: 0,
      left: 30,
      right: 30,
      child: GestureDetector(
        onTap: () {
          addImageDialog();
        },
        child: Container(
          height: size.height * 0.11,
          width: size.height * 0.11,
          padding: const EdgeInsets.all(fixPadding * 1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d5DEE3Color,
            border: Border.all(color: whiteColor, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.25),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: blackColor,
            size: 28.0,
          ),
        ),
      ),
    );
  }

  addImageDialog() {
    return showModalBottomSheet(
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
              getTranslate(context, 'profile.add_image'),
              style: semibold18Black33,
            ),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.camera_alt, const Color(0xFF1E4799),
                getTranslate(context, 'profile.camera')),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.photo, const Color(0xFF1E996D),
                getTranslate(context, 'profile.gallery')),
            heightSpace,
            heightSpace,
            optionWidget(context, Icons.delete, const Color(0xFFEF1717),
                getTranslate(context, 'profile.remove')),
          ],
        );
      },
    );
  }

  optionWidget(BuildContext context, IconData icon, Color color, String title) {
    return InkWell(
      onTap: () {
       // Navigator.pop(context);
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
}
