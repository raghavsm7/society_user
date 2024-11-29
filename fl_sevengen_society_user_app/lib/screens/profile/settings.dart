import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          getTranslate(context, 'settings.settings'),
          style: semibold18Black33,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          optionWidget(Icons.person_outline,
              getTranslate(context, 'settings.edit_profile'), () {
            Navigator.pushNamed(context, '/editProfile');
          }),
          optionWidget(
              CupertinoIcons.globe, getTranslate(context, 'settings.language'),
              () {
            Navigator.pushNamed(context, '/language');
          }),
          optionWidget(Icons.help_outline_outlined,
              getTranslate(context, 'settings.get_support'), () {
            Navigator.pushNamed(context, '/getSupport');
          }),
          optionWidget(Icons.list_alt,
              getTranslate(context, 'settings.terms_and_condition'), () {
            Navigator.pushNamed(context, '/termsAndCondition');
          }),
          optionWidget(Icons.privacy_tip_outlined,
              getTranslate(context, 'settings.privacy_policy'), () {
            Navigator.pushNamed(context, '/privacyPolicy');
          }),
          optionWidget(Icons.logout, getTranslate(context, 'settings.logout'),
              () {
            logoutDialog(context);
          }, color: lightRedColor, iconColor: lightRedColor),
        ],
      ),
    );
  }

  logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          insetPadding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 4.5, vertical: fixPadding * 2.0),
          backgroundColor: whiteColor,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: primaryColor,
                      size: 35,
                    ),
                    heightSpace,
                    Text(
                      getTranslate(context, 'settings.logout'),
                      style: semibold18Primary,
                    ),
                    heightSpace,
                    Text(
                      getTranslate(context, 'settings.logout_text'),
                      style: semibold16Black33,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 1.2),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: blackColor.withOpacity(0.2),
                              blurRadius: 6.0,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          getTranslate(context, 'settings.no'),
                          style: semibold18Black33,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 1.2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: blackColor.withOpacity(0.2),
                              blurRadius: 6.0,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          getTranslate(context, 'settings.yes'),
                          style: semibold18White,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  optionWidget(IconData icon, String title, Function() onTap,
      {Color color = black33Color, Color iconColor = primaryColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 0.8, horizontal: fixPadding),
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: f6f3Color,
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            widthSpace,
            Expanded(
              child: Text(
                title,
                style: medium15Black33.copyWith(color: color),
              ),
            ),
            widthSpace,
            const Icon(
              Icons.arrow_forward_ios,
              color: black33Color,
              size: 18.0,
            )
          ],
        ),
      ),
    );
  }
}
