import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class BookedAmenitiesScreen extends StatefulWidget {
  const BookedAmenitiesScreen({super.key});

  @override
  State<BookedAmenitiesScreen> createState() => _BookedAmenitiesScreenState();
}

class _BookedAmenitiesScreenState extends State<BookedAmenitiesScreen> {
  final list = [
    {
      "image": "assets/bookAmenities/image1.png",
      "title": "Community hall",
      "date": "20 Aug 2022 -23 Aug 2022",
      "time": "12 : 00am -11 : 59pm",
      "person": "Jesika patel",
      "payText": "Paid via Debit card",
      "price": "\$60.00",
      "status": "Confirmed",
      "color": green3EColor,
    },
    {
      "image": "assets/bookAmenities/image2.png",
      "title": "Club House",
      "date": "18 Aug 2022 -19 Aug 2022",
      "time": "12 : 00am -11 : 59pm",
      "person": "Jesika patel",
      "payText": "No payment",
      "price": "Free",
      "status": "Pending",
      "color": orangeColor,
    },
    {
      "image": "assets/bookAmenities/image3.png",
      "title": "Community hall",
      "date": "16 Aug 2022 -18 Aug 2022",
      "time": "09 : 00am -10 : 59pm",
      "person": "Rashmi shah",
      "payText": "No payment",
      "price": "\$24.00",
      "status": "Canceled",
      "color": lightRedColor,
    },
    {
      "image": "assets/bookAmenities/image4.png",
      "title": "Community hall",
      "date": "15 Aug 2022 -16Aug 2022",
      "time": "12 : 00am -11 : 59pm",
      "person": "Mihir jain",
      "payText": "Paid via Debit card",
      "price": "\$60.00",
      "status": "Confirmed",
      "color": green3EColor,
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
          getTranslate(context, 'booked_amenities.booked_amenities'),
          style: semibold18Black33,
        ),
      ),
      body: amenitiesListContent(size),
      bottomNavigationBar: bookAmenityButton(),
    );
  }

  bookAmenityButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/selectAmenities');
      },
      child: Container(
        margin: const EdgeInsets.all(fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0,
          vertical: fixPadding * 1.4,
        ),
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
          getTranslate(context, 'booked_amenities.book_amenity'),
          style: semibold18White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  amenitiesListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: fixPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0, vertical: fixPadding),
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding * 1.2),
                      child: Text(
                        list[index]['title'].toString(),
                        style: semibold16Black33,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 1.3, vertical: fixPadding / 2),
                    color: list[index]['color'] as Color,
                    alignment: Alignment.center,
                    child: Text(
                      list[index]['status'].toString(),
                      style: semibold16White,
                    ),
                  ),
                ],
              ),
              heightSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.11,
                      width: size.height * 0.11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                            list[index]['image'].toString(),
                          ),
                        ),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Column(
                        children: [
                          dateTimeWidget(
                            index,
                            Icons.date_range_outlined,
                            list[index]['date'].toString(),
                          ),
                          height5Space,
                          dateTimeWidget(
                            index,
                            Icons.access_time,
                            list[index]['time'].toString(),
                          ),
                          height5Space,
                          Row(
                            children: [
                              Text(
                                list[index]['status'] == "Confirmed"
                                    ? getTranslate(context,
                                        'booked_amenities.confirmed_by')
                                    : (list[index]['status'] == "Pending"
                                        ? getTranslate(context,
                                            'booked_amenities.booked_by')
                                        : getTranslate(context,
                                            'booked_amenities.canceled_by')),
                                style: medium14Black33,
                              ),
                              Expanded(
                                child: Text(
                                  " : ${list[index]['person']}",
                                  style: medium14Black33,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              heightSpace,
              height5Space,
              DottedBorder(
                color: greyColor,
                padding: EdgeInsets.zero,
                dashPattern: const [2.5, 4.5],
                child: Container(
                  width: double.maxFinite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.2, vertical: fixPadding * 1.4),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: green3EColor,
                            size: 20.0,
                          ),
                          width5Space,
                          Expanded(
                            child: Text(
                              list[index]['payText'].toString(),
                              style: medium14Black33,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      list[index]['price'].toString(),
                      style: semibold18Primary,
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

  dateTimeWidget(int index, IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: black33Color,
        ),
        widthBox(2.0),
        Expanded(
          child: Text(
            title,
            style: medium14Black33,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
