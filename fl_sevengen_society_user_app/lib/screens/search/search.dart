import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final recentSearchList = [
    "Wade warren (block A-302)",
    "Esther Howard (block B-102)",
    "Jenny Wilson (block C-101)",
    "Robert Fox (Block A - 202)"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          heightSpace,
          height5Space,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
            child: Row(
              children: [
                backButton(context),
                searchField(),
              ],
            ),
          ),
          recentSearchList.isEmpty ? const SizedBox() : recentSearchTitle(),
          recentSearchListConent(),
        ],
      ),
    );
  }

  recentSearchListConent() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: fixPadding / 2, bottom: fixPadding * 1.5),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: fixPadding / 2, horizontal: fixPadding * 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "#",
                  style: medium14Grey,
                ),
                widthSpace,
                Expanded(
                  child: Text(
                    recentSearchList[index].toString(),
                    style: medium14Grey,
                  ),
                )
              ],
            ),
          );
        },
        itemCount: recentSearchList.length,
      ),
    );
  }

  backButton(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: black33Color,
      ),
    );
  }

  searchField() {
    return Expanded(
      child: Container(
        margin: languageValue == 4
            ? const EdgeInsets.only(left: fixPadding * 2.0)
            : const EdgeInsets.only(right: fixPadding * 2.0),
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
          cursorColor: primaryColor,
          style: semibold16Black33,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslate(context, 'search.search'),
            hintStyle: semibold16Grey,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.mic_none),
          ),
        ),
      ),
    );
  }

  recentSearchTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              getTranslate(context, 'search.recent_search'),
              style: semibold16Black33,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                recentSearchList.clear();
              });
            },
            child: Text(
              getTranslate(context, 'search.clear_all'),
              style: semibold14Grey,
            ),
          )
        ],
      ),
    );
  }
}
