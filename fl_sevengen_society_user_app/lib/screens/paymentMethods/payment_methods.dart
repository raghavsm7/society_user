import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';

class PaymemtMethodScreen extends StatefulWidget {
  const PaymemtMethodScreen({super.key});

  @override
  State<PaymemtMethodScreen> createState() => _PaymemtMethodScreenState();
}

class _PaymemtMethodScreenState extends State<PaymemtMethodScreen> {
  final paymentMethodList = [
    {
      "image": "assets/payment/credit.png",
      "title": translate('payment_method.credit_card'),
    },
    {
      "image": "assets/payment/debit-card.png",
      "title": translate('payment_method.debit_card'),
    },
    {
      "image": "assets/payment/paypal.png",
      "title": translate('payment_method.paypal'),
    },
    {
      "image": "assets/payment/visa.png",
      "title": translate('payment_method.visa'),
    },
    {
      "image": "assets/payment/cashback.png",
      "title": translate("payment_method.pay_cash_to_admin"),
    },
  ];

  int selectedIndex = 0;

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
          getTranslate(context, 'payment_method.select_payment_method'),
          style: semibold18Black33,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "${getTranslate(context, 'payment_method.security_deposit')} : \$50.00",
            style: semibold16Orange,
          ),
          heightSpace,
          paymentMethodListContent(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          continueButton()
        ],
      ),
    );
  }

  continueButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/creditCard');
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
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
          getTranslate(context, 'payment_method.continue'),
          style: semibold18White,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  paymentMethodListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
            padding: const EdgeInsets.all(fixPadding * 1.4),
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
            child: Row(
              children: [
                Image.asset(
                  paymentMethodList[index]['image'].toString(),
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                ),
                widthSpace,
                Expanded(
                  child: Text(
                    paymentMethodList[index]['title'].toString(),
                    style: semibold16Black33,
                  ),
                ),
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    border: selectedIndex == index
                        ? Border.all(color: primaryColor, width: 6.0)
                        : null,
                    boxShadow: [
                      selectedIndex == index
                          ? BoxShadow(
                              color: primaryColor.withOpacity(0.1),
                              blurRadius: 12.0,
                              offset: const Offset(0, 6),
                            )
                          : BoxShadow(
                              color: shadowColor.withOpacity(0.2),
                              blurRadius: 6.0,
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: paymentMethodList.length,
    );
  }
}
