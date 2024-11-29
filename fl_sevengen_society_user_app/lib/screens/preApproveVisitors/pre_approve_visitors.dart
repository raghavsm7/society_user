import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

class PreApproveVisitorsScreen extends StatefulWidget {
  const PreApproveVisitorsScreen({super.key});

  @override
  State<PreApproveVisitorsScreen> createState() =>
      _PreApproveVisitorsScreenState();
}

class _PreApproveVisitorsScreenState extends State<PreApproveVisitorsScreen> {
  TextEditingController dateController = TextEditingController();

  bool sendgatePass = true;

  final companyList = ["Uber", "Lyft", "Hailo", "Ola", "Grab Taxi"];

  final deliveryCompanyList = ["FedEX", "UPS", "XPO", "USPS", "Amazon"];

  final dayList = [
    translate('pre_approve_visitor.today'),
    translate('pre_approve_visitor.tomorrow')
  ];

  int selectedCompamyName = 0;
  int selectedDeliveryCompanyName = 0;
  int selectedDay = 0;
  int selectedNext = 0;
  String deliveryCompanyName = "";
  String companyName = "";
  String dayName = "";
  String enterInNextText = "";

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
          getTranslate(context, 'pre_approve_visitor.visitors'),
          style: semibold18Black33,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding * 2.0),
        children: [
          Text(
            getTranslate(context, 'pre_approve_visitor.pre_approve_visitors'),
            style: semibold18Black33,
          ),
          height5Space,
          Text(
            getTranslate(context, 'pre_approve_visitor.add_visitor_detail'),
            style: medium14Grey,
          ),
          heightSpace,
          heightSpace,
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: fixPadding * 2.0,
              crossAxisSpacing: fixPadding * 2.0,
              childAspectRatio: size.width / (size.height / 2.1),
            ),
            children: [
              visitorWidget(
                size,
                "assets/preApproveVisitors/guests.png",
                getTranslate(context, 'pre_approve_visitor.add_guest'),
                () {
                  allowGuestDialog(context, size);
                },
              ),
              visitorWidget(
                size,
                "assets/preApproveVisitors/cab.png",
                getTranslate(context, 'pre_approve_visitor.add_cab'),
                () {
                  addCabDialog(context, size);
                },
              ),
              visitorWidget(size, "assets/preApproveVisitors/food-delivery.png",
                  getTranslate(context, 'pre_approve_visitor.add_delivery'),
                  () {
                addDeliveryDailog(context, size);
              }),
              visitorWidget(
                size,
                "assets/preApproveVisitors/maid.png",
                getTranslate(context, 'pre_approve_visitor.add_service'),
                () {
                  addServiceDialog(context, size);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  addServiceDialog(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(fixPadding * 2.0),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.05),
                    width: double.maxFinite,
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
                      padding: EdgeInsets.fromLTRB(
                          fixPadding * 2.0,
                          size.height * 0.07,
                          fixPadding * 2.0,
                          fixPadding * 2.0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Center(
                          child: Text(
                            getTranslate(context,
                                'pre_approve_visitor.allow_my_servicesman'),
                            style: semibold16Black33,
                          ),
                        ),
                        heightSpace,
                        heightSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(getTranslate(context,
                                'pre_approve_visitor.serviceman_name')),
                            height5Space,
                            Container(
                              width: double.maxFinite,
                              decoration: boxDecoration(),
                              child: TextField(
                                style: semibold14Black33,
                                keyboardType: TextInputType.text,
                                cursorColor: primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                  ),
                                  hintText: getTranslate(context,
                                      'pre_approve_visitor.enter_serviceman_name'),
                                  hintStyle: medium14Grey,
                                ),
                              ),
                            ),
                            heightSpace,
                            height5Space,
                            title(getTranslate(
                                context, 'pre_approve_visitor.phone_number')),
                            height5Space,
                            Container(
                              width: double.maxFinite,
                              decoration: boxDecoration(),
                              child: TextField(
                                style: semibold14Black33,
                                keyboardType: TextInputType.phone,
                                cursorColor: primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: fixPadding * 1.5),
                                  hintText: getTranslate(context,
                                      'pre_approve_visitor.enter_phone_number'),
                                  hintStyle: medium14Grey,
                                ),
                              ),
                            ),
                            heightSpace,
                            height5Space,
                            title(getTranslate(
                                context, 'pre_approve_visitor.to_enter_next')),
                            heightSpace,
                            GestureDetector(
                              onTap: () {
                                toNextEnterDialog(state);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.4,
                                    vertical: fixPadding * 1.3),
                                decoration: boxDecoration(),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        enterInNextText.isEmpty
                                            ? dayList[selectedNext]
                                            : enterInNextText,
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
                            heightSpace,
                            height5Space,
                            submitButton(context, size, () {
                              Navigator.pop(context);
                              setState(() {
                                selectedNext = 0;
                                enterInNextText = "";
                              });
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                  dialogTopImage(size, "assets/preApproveVisitors/maid.png"),
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
          },
        );
      },
    );
  }

  addDeliveryDailog(BuildContext context, Size size) {
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
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(context,
                                  'pre_approve_visitor.allow_my_delivery'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          title(getTranslate(context,
                              'pre_approve_visitor.delivery_company_name')),
                          height5Space,
                          GestureDetector(
                            onTap: () {
                              deliveryCompanyNameDialog(context, state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: deliveryCompanyName.isEmpty
                                        ? Text(
                                            getTranslate(context,
                                                'pre_approve_visitor.select_delivery_company'),
                                            style: medium14Grey,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            deliveryCompanyName,
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
                          title(getTranslate(
                              context, 'pre_approve_visitor.to_enter_next')),
                          heightSpace,
                          GestureDetector(
                            onTap: () {
                              dayDailog(state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dayName.isEmpty
                                          ? dayList[selectedDay]
                                          : dayName,
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
                          heightSpace,
                          height5Space,
                          submitButton(context, size, () {
                            Navigator.pop(context);
                            setState(() {
                              selectedDay = 0;
                              dayName = '';
                              selectedDeliveryCompanyName = 0;
                              deliveryCompanyName = "";
                            });
                          })
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(
                    size, "assets/preApproveVisitors/food-delivery.png"),
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

  dayDailog(StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedDay;

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
                    getTranslate(context, "pre_approve_visitor.to_enter_next"),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selected, dayList[index], () {
                      states(() {
                        setState(() {
                          selected = index;
                        });
                      });
                    });
                  },
                  itemCount: dayList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(context,
                          getTranslate(context, 'pre_approve_visitor.cancel'),
                          () {
                        Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(context,
                          getTranslate(context, 'pre_approve_visitor.okay'),
                          () {
                        state(() {
                          setState(() {
                            dayName = dayList[selected];
                            selectedDay = selected;
                          });
                          Navigator.pop(context);
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

  toNextEnterDialog(StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selectedday = selectedNext;

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
                    getTranslate(context, 'pre_approve_visitor.to_enter_next'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selectedday, dayList[index], () {
                      states(() {
                        setState(() {
                          selectedday = index;
                        });
                      });
                    });
                  },
                  itemCount: dayList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(context,
                          getTranslate(context, 'pre_approve_visitor.cancel'),
                          () {
                        Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(context,
                          getTranslate(context, 'pre_approve_visitor.okay'),
                          () {
                        state(() {
                          setState(() {
                            enterInNextText = dayList[selectedday];
                            selectedNext = selectedday;
                          });
                          Navigator.pop(context);
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

  addCabDialog(BuildContext context, Size size) {
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
                                  context, 'pre_approve_visitor.allow_my_cab'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          Text(
                            getTranslate(context,
                                'pre_approve_visitor.allow_mycab_enter_today_next'),
                            style: semibold16Grey,
                          ),
                          heightSpace,
                          heightSpace,
                          title(getTranslate(
                              context, "pre_approve_visitor.Add_vehicle_no")),
                          heightBox(fixPadding * 1.2),
                          Pinput(
                            defaultPinTheme: PinTheme(
                              height: 43,
                              width: 43,
                              textStyle: semibold18Black33,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: fixPadding / 4),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: blackColor.withOpacity(0.25),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          title(getTranslate(
                              context, 'pre_approve_visitor.company_name')),
                          height5Space,
                          GestureDetector(
                            onTap: () {
                              companyNameDialog(context, state);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding * 1.4,
                                  vertical: fixPadding * 1.3),
                              decoration: boxDecoration(),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: companyName.isEmpty
                                        ? Text(
                                            getTranslate(context,
                                                'pre_approve_visitor.select_company_name'),
                                            style: medium14Grey,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            companyName,
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
                          heightSpace,
                          height5Space,
                          submitButton(context, size, () {
                            Navigator.pop(context);
                            setState(() {
                              selectedCompamyName = 0;
                              companyName = '';
                            });
                          })
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size, "assets/preApproveVisitors/cab.png"),
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

  deliveryCompanyNameDialog(BuildContext context, StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedDeliveryCompanyName;

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
                    getTranslate(context, 'pre_approve_visitor.company_name'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selected, deliveryCompanyList[index], () {
                      states(() {
                        setState(() {
                          selected = index;
                        });
                      });
                    });
                  },
                  itemCount: deliveryCompanyList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(context,
                          getTranslate(context, 'pre_approve_visitor.cancel'),
                          () {
                        Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(context,
                          getTranslate(context, 'pre_approve_visitor.okay'),
                          () {
                        state(() {
                          setState(() {
                            deliveryCompanyName = deliveryCompanyList[selected];
                            selectedDeliveryCompanyName = selected;
                          });
                          Navigator.pop(context);
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

  companyNameDialog(BuildContext context, StateSetter state) {
    return showDialog(
      context: context,
      builder: (context) {
        int selected = selectedCompamyName;

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
                    getTranslate(context, 'pre_approve_visitor.company_name'),
                    style: medium18Primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                dottedDivider(),
                heightSpace,
                ColumnBuilder(
                  itemBuilder: (context, index) {
                    return selectOptionListContent(
                        index, selected, companyList[index], () {
                      states(() {
                        setState(() {
                          selected = index;
                        });
                      });
                    });
                  },
                  itemCount: companyList.length,
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    children: [
                      whiteButton(context,
                          getTranslate(context, 'pre_approve_visitor.cancel'),
                          () {
                        Navigator.pop(context);
                      }),
                      widthSpace,
                      widthSpace,
                      buttonWidget(context,
                          getTranslate(context, 'pre_approve_visitor.okay'),
                          () {
                        state(() {
                          setState(() {
                            companyName = companyList[selected];
                            selectedCompamyName = selected;
                          });
                          Navigator.pop(context);
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

  allowGuestDialog(BuildContext context, Size size) {
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
                    padding: EdgeInsets.fromLTRB(fixPadding * 2.0,
                        size.height * 0.07, fixPadding * 2.0, fixPadding * 2.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              getTranslate(context,
                                  'pre_approve_visitor.allow_my_guest'),
                              style: semibold16Black33,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          title(getTranslate(
                              context, 'pre_approve_visitor.guest_name')),
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
                                hintText: getTranslate(context,
                                    'pre_approve_visitor.enter_guest_name'),
                                hintStyle: medium14Grey,
                                suffixIcon: const Icon(
                                  Icons.contact_page_outlined,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                          heightSpace,
                          height5Space,
                          title(getTranslate(
                              context, 'pre_approve_visitor.phone_number')),
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
                                hintText: getTranslate(context,
                                    'pre_approve_visitor.enter_phone_number'),
                                hintStyle: medium14Grey,
                                suffixIcon: const Icon(
                                  Icons.phone_android,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                          heightSpace,
                          title(getTranslate(
                              context, 'pre_approve_visitor.enter_date')),
                          height5Space,
                          Container(
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
                                                    primary: primaryColor)),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: fixPadding * 1.5,
                                    vertical: fixPadding * 1.4),
                                hintText: "Today",
                                hintStyle: medium14Grey,
                                suffixIcon: Icon(
                                  Icons.date_range_outlined,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                          heightSpace,
                          InkWell(
                            onTap: () {
                              state(() {
                                setState(() {
                                  sendgatePass = !sendgatePass;
                                });
                              });
                            },
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
                                    getTranslate(context,
                                        'pre_approve_visitor.send_gate_pass_to_guest'),
                                    style: medium14Grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          submitButton(context, size, () {
                            Navigator.pop(context);
                            gatePassDialog(context, size);
                            dateController.clear();
                          }),
                          heightSpace,
                        ],
                      )
                    ],
                  ),
                ),
                dialogTopImage(size, "assets/preApproveVisitors/guests.png"),
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
          getTranslate(context, 'pre_approve_visitor.submit'),
          style: semibold18White,
        ),
      ),
    );
  }

  dialogTopImage(Size size, String image) {
    return Positioned(
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
          image,
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
                      Navigator.pop(context);
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
                        getTranslate(context, 'pre_approve_visitor.gate_pass'),
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
                                  "${getTranslate(context, 'pre_approve_visitor.guest_at')}  B-524",
                                  style: medium16Grey,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    dottedDivider(),
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
                            getTranslate(
                                context, 'pre_approve_visitor.entry_code'),
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
                            getTranslate(
                                context, 'pre_approve_visitor.show_qr_code'),
                            style: medium14Primary,
                          ),
                          heightSpace,
                          heightSpace,
                          height5Space,
                          Row(
                            children: [
                              whiteButton(
                                  context,
                                  getTranslate(
                                      context, 'pre_approve_visitor.share'),
                                  () {
                                Navigator.pop(context);
                              }),
                              widthSpace,
                              widthSpace,
                              buttonWidget(
                                  context,
                                  getTranslate(
                                      context, 'pre_approve_visitor.download'),
                                  () {
                                Navigator.pop(context);
                              })
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

  title(String title) {
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
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          color: greyColor,
          size: 22,
        ),
      ),
    );
  }

  visitorWidget(Size size, String image, String name, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.25),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: size.height * 0.07,
              width: size.height * 0.07,
            ),
            heightSpace,
            Text(
              name,
              style: semibold16Black33,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
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
}
