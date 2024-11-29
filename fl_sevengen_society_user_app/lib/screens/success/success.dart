import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => onWillPop(),
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              backgroundImage(),
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(fixPadding * 2.0),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        logo(size),
                        heightSpace,
                        height5Space,
                        paymentText(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        paymentDetails(),
                        heightSpace,
                        heightSpace,
                        height5Space,
                        downloadButton()
                      ],
                    ),
                  ),
                  backToHomeButton()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  paymentText() {
    return Text(
      getTranslate(context, 'success.payment_successful'),
      style: semibold20Black33,
      textAlign: TextAlign.center,
    );
  }

  logo(Size size) {
    return Center(
      child: Image.asset(
        "assets/success/success.png",
        height: size.height * 0.12,
        width: size.height * 0.12,
      ),
    );
  }

  paymentDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.25),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          statusText(),
          divider(),
          detailText(getTranslate(context, 'success.amount_paid'), "\$50.00"),
          divider(),
          detailText(getTranslate(context, 'success.paid_on'), "5 june, 2022"),
          divider(),
          detailText(getTranslate(context, 'success.paid_via'), "Credit card"),
          divider(),
          detailText(
              getTranslate(context, 'success.transaction_id'), "DF12345678910"),
        ],
      ),
    );
  }

  backgroundImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        "assets/splash/image.png",
        opacity: const AlwaysStoppedAnimation(0.1),
        width: double.maxFinite,
        fit: BoxFit.cover,
      ),
    );
  }

  backToHomeButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/bottomBar');
      },
      child: Text(
        getTranslate(context, 'success.back_to_home'),
        style: semibold16Primary,
      ),
    );
  }

  downloadButton() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.4, horizontal: fixPadding * 2.5),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(color: shadowColor.withOpacity(0.25), blurRadius: 6.0)
          ],
        ),
        child: Text(
          getTranslate(context, 'success.download_receipt'),
          style: semibold18Primary,
        ),
      ),
    );
  }

  divider() {
    return Container(
      width: double.maxFinite,
      height: 1,
      color: greyD4Color,
    );
  }

  detailText(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 1.5, vertical: fixPadding * 1.8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: medium16Black33,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            detail,
            style: medium16Black33,
          )
        ],
      ),
    );
  }

  statusText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 1.5, vertical: fixPadding * 1.8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              getTranslate(context, 'success.security_deposit'),
              style: medium16Black33,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            getTranslate(context, 'success.paid'),
            style: semibold16Green3E,
          )
        ],
      ),
    );
  }

  onWillPop() {
    Navigator.pushNamed(context, '/bottomBar');
  }
}
