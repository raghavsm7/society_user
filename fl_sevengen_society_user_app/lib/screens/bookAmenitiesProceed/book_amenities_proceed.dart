import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookAmenitiesProceedScreen extends StatefulWidget {
  const BookAmenitiesProceedScreen({super.key});

  @override
  State<BookAmenitiesProceedScreen> createState() =>
      _BookAmenitiesProceedScreenState();
}

class _BookAmenitiesProceedScreenState
    extends State<BookAmenitiesProceedScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

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
          getTranslate(context, 'book_amenities_proceed.book_amenity'),
          style: semibold18Black33,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: fixPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          amenittDetail(size),
          heightSpace,
          heightSpace,
          height5Space,
          title(getTranslate(context, 'book_amenities_proceed.select_dates')),
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              children: [
                fromDateField(context),
                widthSpace,
                widthSpace,
                toDateField(context),
              ],
            ),
          ),
          title(getTranslate(context, 'book_amenities_proceed.select_time')),
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              children: [
                fromTimeField(context),
                widthSpace,
                widthSpace,
                toTimeField(context),
              ],
            ),
          ),
          dottedDivider(),
          Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              children: [
                totaldays(),
                heightSpace,
                amountTopay(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: proceedToPayButton(),
    );
  }

  proceedToPayButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/creditCard');
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
          getTranslate(context, 'book_amenities_proceed.proceed_to_pay'),
          style: semibold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  amountTopay() {
    return Row(
      children: [
        Expanded(
          child: Text(
            getTranslate(context, 'book_amenities_proceed.amount_to_pay'),
            style: semibold15Primary,
          ),
        ),
        const Text(
          "\$60.00",
          style: semibold15Primary,
        )
      ],
    );
  }

  totaldays() {
    return Row(
      children: [
        Expanded(
          child: Text(
            getTranslate(context, 'book_amenities_proceed.total_day'),
            style: semibold15Grey,
          ),
        ),
        Text(
          "3 ${getTranslate(context, 'book_amenities_proceed.day')}",
          style: semibold15Grey,
        )
      ],
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

  fromTimeField(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'book_amenities_proceed.from'),
            style: semibold15Black33,
          ),
          heightSpace,
          Container(
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
            child: TextField(
              readOnly: true,
              style: semibold14Black33,
              controller: fromTimeController,
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme:
                            const ColorScheme.light(primary: primaryColor),
                      ),
                      child: child!),
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    fromTimeController.text = pickedTime.format(context);
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    getTranslate(context, 'book_amenities_proceed.select_time'),
                hintStyle: semibold14Grey,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: fixPadding,
                  vertical: fixPadding * 1.4,
                ),
                suffixIcon: const Icon(
                  Icons.access_time,
                  size: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  toTimeField(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, "book_amenities_proceed.to"),
            style: semibold15Black33,
          ),
          heightSpace,
          Container(
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
            child: TextField(
              readOnly: true,
              style: semibold14Black33,
              controller: toTimeController,
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme:
                            const ColorScheme.light(primary: primaryColor),
                      ),
                      child: child!),
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    toTimeController.text = pickedTime.format(context);
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    getTranslate(context, 'book_amenities_proceed.select_time'),
                hintStyle: semibold14Grey,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: fixPadding,
                  vertical: fixPadding * 1.4,
                ),
                suffixIcon: const Icon(
                  Icons.access_time,
                  size: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  toDateField(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'book_amenities_proceed.to'),
            style: semibold15Black33,
          ),
          heightSpace,
          Container(
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
            child: TextField(
              readOnly: true,
              style: semibold14Black33,
              controller: toDateController,
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
                            const ColorScheme.light(primary: primaryColor),
                      ),
                      child: child!),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("dd MMMM yyyy").format(pickedDate);

                  setState(() {
                    toDateController.text = formattedDate;
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    getTranslate(context, 'book_amenities_proceed.select_date'),
                hintStyle: semibold14Grey,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: fixPadding,
                  vertical: fixPadding * 1.4,
                ),
                suffixIcon: const Icon(
                  Icons.date_range_outlined,
                  size: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  fromDateField(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'book_amenities_proceed.from'),
            style: semibold15Black33,
          ),
          heightSpace,
          Container(
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
            child: TextField(
              readOnly: true,
              style: semibold14Black33,
              controller: fromDateController,
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
                            const ColorScheme.light(primary: primaryColor),
                      ),
                      child: child!),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("dd MMMM yyyy").format(pickedDate);

                  setState(() {
                    fromDateController.text = formattedDate;
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    getTranslate(context, 'book_amenities_proceed.select_date'),
                hintStyle: semibold14Grey,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: fixPadding,
                  vertical: fixPadding * 1.4,
                ),
                suffixIcon: const Icon(
                  Icons.date_range_outlined,
                  size: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  title(String title) {
    return Container(
      width: double.maxFinite,
      color: const Color(0xFFEFEFEF),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      child: Text(
        title,
        style: semibold16Black33,
      ),
    );
  }

  amenittDetail(Size size) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
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
        children: [
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
                  child: Text(
                    "Community hall",
                    style: semibold16Black33,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2.3, vertical: fixPadding / 2),
                color: green3EColor,
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'book_amenities_proceed.paid'),
                  style: semibold16White,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 1.2, vertical: fixPadding),
            child: Row(
              children: [
                Container(
                  height: size.height * 0.11,
                  width: size.height * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/bookAmenities/image1.png",
                      ),
                    ),
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text:
                              "${getTranslate(context, 'book_amenities_proceed.maximum_Capacity')} :",
                          style: medium14Grey,
                          children: [
                            TextSpan(
                              text:
                                  "50 ${getTranslate(context, 'book_amenities_proceed.person')}",
                              style: medium14Black33,
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5Space,
                      Text.rich(
                        TextSpan(
                          text:
                              "${getTranslate(context, 'book_amenities_proceed.book_before_least')} :",
                          style: medium14Grey,
                          children: [
                            TextSpan(
                              text:
                                  "2 ${getTranslate(context, 'book_amenities_proceed.days')}",
                              style: medium14Black33,
                            )
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5Space,
                      Text(
                        "\$20.00 ${getTranslate(context, 'book_amenities_proceed.per_day')}",
                        style: medium14Black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
