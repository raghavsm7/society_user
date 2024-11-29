import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class SelectAmenitiesScreen extends StatefulWidget {
  const SelectAmenitiesScreen({super.key});

  @override
  State<SelectAmenitiesScreen> createState() => _SelectAmenitiesScreenState();
}

class _SelectAmenitiesScreenState extends State<SelectAmenitiesScreen> {
  final amenitiesList = [
    {
      "image": "assets/selectAmenities/image1.png",
      "title": "Community hall",
      "price": "\$20",
      "status": "Paid"
    },
    {
      "image": "assets/selectAmenities/image2.png",
      "title": "Club house",
      "price": "Free",
      "status": "Free"
    },
    {
      "image": "assets/selectAmenities/image3.png",
      "title": "Swimming Pool",
      "price": "\$20",
      "status": "Paid"
    },
    {
      "image": "assets/selectAmenities/image4.png",
      "title": "Common plot",
      "price": "Free",
      "status": "Free"
    },
    {
      "image": "assets/selectAmenities/image5.png",
      "title": "Guest house",
      "price": "\$15",
      "status": "Paid"
    },
    {
      "image": "assets/selectAmenities/image6.png",
      "title": "Tennis room",
      "price": "Free",
      "status": "Free"
    },
    {
      "image": "assets/selectAmenities/image7.png",
      "title": "Indoor theather",
      "price": "\$20",
      "status": "Paid"
    },
    {
      "image": "assets/selectAmenities/image8.png",
      "title": "Roof lounge areas",
      "price": "\$10",
      "status": "Paid"
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          getTranslate(context, 'select_amenities.select_amenity'),
          style: semibold18Black33,
        ),
      ),
      body: amenitiesListContent(),
    );
  }

  amenitiesListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: fixPadding),
      itemCount: amenitiesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/bookAmenitiesProceed');
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: 65.00,
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
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 65.0,
                  height: 65.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        amenitiesList[index]['image'].toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              amenitiesList[index]['title'].toString(),
                              style: medium16Primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(3.0),
                            Text(
                              amenitiesList[index]['price'] == "Free"
                                  ? amenitiesList[index]['price'].toString()
                                  : "${amenitiesList[index]['price']} ${getTranslate(context, 'select_amenities.per_day')}",
                              style: medium14Grey,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixPadding * 1.5),
                        child: Text(
                          amenitiesList[index]['status'].toString(),
                          style: amenitiesList[index]['price'] == "Free"
                              ? semibold16Orange
                              : semibold16Green3E,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
