import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widget/column_builder.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final serviceList = [
    {"image": "assets/services/cleaning.png", "name": "Home cleaning"},
    {"image": "assets/services/mechanic.png", "name": "Applicances repair"},
    {"image": "assets/services/carpenter.png", "name": "Carpenters service"},
    {"image": "assets/services/painter.png", "name": "Home painting"},
    {"image": "assets/services/technician.png", "name": "Pulmbing service"},
    {"image": "assets/services/shipping.png", "name": "Packer & Movers"},
    {"image": "assets/services/disinfection.png", "name": "Home sanitize"},
    {"image": "assets/services/hair-salon.png", "name": "Hair & beauty"},
    {"image": "assets/services/plumber.png", "name": "Plumbing services"},
    {"image": "assets/services/ironing.png", "name": "Loundry services"},
    {"image": "assets/services/pruning-shears.png", "name": "Gardening"},
    {"image": "assets/services/cooking.png", "name": "Cooking"},
  ];

  final serviceNameList = [
    "AC repair",
    "Tv repair",
    "Mixer grinder repair",
    "Door bell repair",
    "Fan repair"
  ];

  String serviceName = "";
  int selectedIndex = 0;

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
          getTranslate(context, 'service.service'),
          style: semibold22Black33,
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: fixPadding, bottom: fixPadding * 9.0),
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslate(context, 'service.your_booking'),
                  style: semibold16Black33,
                ),
                heightSpace,
                bookServiceBox(),
                heightSpace,
                heightSpace,
                Text(
                  getTranslate(context, 'service.nearby_service'),
                  style: semibold16Black33,
                ),
                heightSpace,
                heightSpace,
              ],
            ),
          ),
          nearByServiceListContent(size),
        ],
      ),
    );
  }

  bookServiceBox() {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      padding: languageValue == 4
          ? const EdgeInsets.only(right: 6.0)
          : const EdgeInsets.only(left: 6.0),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: d2E3EFColor,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 12.0,
              offset: const Offset(0, 6),
            )
          ]),
      child: Container(
        width: double.maxFinite,
        color: const Color(0xFFE8F2F9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Home painting",
                      style: semibold16Primary,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height5Space,
                    Text(
                      "Paint my home. Need service.",
                      style: medium14Grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height5Space,
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          size: 16.0,
                          color: greyColor,
                        ),
                        width5Space,
                        Expanded(
                          child: Text(
                            "20 Aug 2022 | 03:30pm",
                            style: medium12Black33,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Image.asset(
              "assets/services/painter.png",
              height: 80.0,
              width: 80.0,
            )
          ],
        ),
      ),
    );
  }

  nearByServiceListContent(Size size) {
    return Container(
      color: f6f3Color,
      width: double.maxFinite,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: fixPadding * 2.0,
          crossAxisSpacing: fixPadding * 2.0,
          childAspectRatio: 1.7,
        ),
        itemCount: serviceList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              bookServiceDialog(context, size);
            },
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.1),
                    blurRadius: 12.0,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    serviceList[index]['image'].toString(),
                    height: 35.0,
                    width: 35.0,
                  ),
                  heightSpace,
                  Text(
                    serviceList[index]['name'].toString(),
                    style: medium15Primary,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bookServiceDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
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
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(
                                  context, 'service.book_service_text'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Text(
                            getTranslate(context, 'service.select_service'),
                            style: semibold16Black33,
                          ),
                          heightSpace,
                          GestureDetector(
                            onTap: () {
                              selectServiceDialog(state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: serviceName.isEmpty
                                        ? Text(
                                            getTranslate(context,
                                                'service.select_service'),
                                            style: medium14Grey,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            serviceName,
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
                          heightSpace,
                          Text(
                            getTranslate(context, 'service.book_visit_on'),
                            style: semibold16Black33,
                          ),
                          heightSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: boxDecoration(),
                                  child: TextField(
                                    onTap: () async {
                                      final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 3650),
                                          ),
                                          builder: (context, child) => Theme(
                                              data: Theme.of(context).copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                          primary:
                                                              primaryColor)),
                                              child: child!));
                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('dd MMMM yyyy')
                                                .format(pickedDate);
                                        setState(() {
                                          dateController.text = formattedDate;
                                        });
                                      }
                                    },
                                    readOnly: true,
                                    controller: dateController,
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.phone,
                                    style: semibold14Black33,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: fixPadding * 1.5,
                                              vertical: fixPadding * 1.4),
                                      hintText: getTranslate(
                                          context, 'service.select_date'),
                                      hintStyle: medium14Grey,
                                      suffixIcon: const Icon(
                                        Icons.date_range_outlined,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              widthSpace,
                              width5Space,
                              Expanded(
                                child: Container(
                                  decoration: boxDecoration(),
                                  child: TextField(
                                    onTap: () async {
                                      final pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (context, child) => Theme(
                                            data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                        primary: primaryColor)),
                                            child: child!),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          timeController.text =
                                              pickedTime.format(context);
                                        });
                                      }
                                    },
                                    readOnly: true,
                                    controller: timeController,
                                    cursorColor: primaryColor,
                                    keyboardType: TextInputType.phone,
                                    style: semibold14Black33,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: fixPadding * 1.5,
                                              vertical: fixPadding * 1.4),
                                      hintText: getTranslate(
                                          context, 'service.select_time'),
                                      hintStyle: medium14Grey,
                                      suffixIcon: const Icon(
                                        Icons.access_time,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          heightSpace,
                          heightSpace,
                          Text(
                            getTranslate(context, 'service.brief_your_problem'),
                            style: medium16Black33,
                          ),
                          heightSpace,
                          Container(
                            height: size.height * 0.12,
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
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: getTranslate(
                                    context, 'service.write_your_problem'),
                                hintStyle: medium15Grey,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding),
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 30,
                  right: 30,
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
                    child: Image.asset(
                      "assets/services/mechanic.png",
                    ),
                  ),
                ),
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

  selectServiceDialog(StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedIndex;

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
                    getTranslate(context, 'service.company_name'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                DottedBorder(
                  padding: EdgeInsets.zero,
                  color: greyColor,
                  dashPattern: const [2.5, 4.5],
                  child: Container(
                    width: double.maxFinite,
                  ),
                ),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding * 2.0, vertical: fixPadding),
                      child: InkWell(
                        onTap: () {
                          states(() {
                            setState(() {
                              selected = index;
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                shape: BoxShape.circle,
                                border: selected == index
                                    ? Border.all(
                                        color: primaryColor, width: 7.5)
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
                                serviceNameList[index],
                                style: medium16Black33,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: serviceNameList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
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
                              getTranslate(context, 'service.cancel'),
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
                            state(() {
                              setState(() {
                                serviceName = serviceNameList[selected];
                                selectedIndex = selected;
                              });
                              //Navigator.pop(context);
                            });
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
                              getTranslate(context, 'service.okay'),
                              style: semibold18White,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
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

  submitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
      //  Navigator.pop(context);
        setState(() {
          serviceName = "";
          selectedIndex = 0;
          dateController.clear();
          timeController.clear();
        });
      },
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
          getTranslate(context, 'service.submit'),
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

  closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(fixPadding),
      child: InkWell(
        onTap: () {
         // Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          color: greyColor,
          size: 22,
        ),
      ),
    );
  }
}
