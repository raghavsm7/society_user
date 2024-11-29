import 'package:dotted_border/dotted_border.dart';
import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentList = [
    {
      "title": "Maintenance charge June 2022",
      "isNew": true,
      "price": "\$15.00",
      "date": "5 June, 03.30 pm",
      "status": "Paid",
      "color": lightGreenColor,
    },
    {
      "title": "Security Deposite",
      "isNew": true,
      "price": "\$50.00",
      "date": "10 June, 02 :58 pm",
      "status": "Pending",
      "color": orangeColor,
    },
    {
      "title": "Society welfare funs",
      "isNew": true,
      "price": "\$20.00",
      "date": "10 June, 02 :58 pm",
      "status": "Failed",
      "color": lightRedColor,
    },
    {
      "title": "Maintenance charge June 2022",
      "isNew": false,
      "price": "\$15.00",
      "date": "5 June, 03.30 pm",
      "status": "Paid",
      "color": lightGreenColor,
    },
    {
      "title": "Maintenance charge June 2022",
      "isNew": false,
      "price": "\$15.00",
      "date": "5 June, 03.30 pm",
      "status": "Paid",
      "color": lightGreenColor,
    }
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
          getTranslate(context, 'payment.payment'),
          style: semibold18Black33,
        ),
      ),
      body: paymentListContent(),
    );
  }

  paymentListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: fixPadding),
      itemCount: paymentList.length,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2.0, vertical: fixPadding),
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
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding * 1.5,
                          vertical: fixPadding * 1.4),
                      child: Text(
                        paymentList[index]['title'].toString(),
                        style: semibold16Primary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  paymentList[index]['isNew'] == true
                      ? Container(
                          color: primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: fixPadding * 1.3,
                              vertical: fixPadding / 2),
                          child: Text(
                            getTranslate(context, 'payment.new'),
                            style: semibold12White,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              DottedBorder(
                padding: EdgeInsets.zero,
                color: greyColor,
                dashPattern: const [2.5, 4.5],
                child: Container(
                  width: double.maxFinite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paymentList[index]['price'].toString(),
                            style: medium16Black33,
                            overflow: TextOverflow.ellipsis,
                          ),
                          height5Space,
                          Text(
                            "${getTranslate(context, 'payment.due_date')} : ${paymentList[index]['date']}",
                            style: medium14Black33,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    paymentList[index]['status'] == "Paid"
                        ? Row(
                            children: [
                              const Icon(
                                Icons.list_alt,
                                color: primaryColor,
                                size: 16,
                              ),
                              width5Space,
                              Text(
                                getTranslate(context, 'payment.receipt'),
                                style: semibold14Primary,
                              )
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.payments_outlined,
                                color: primaryColor,
                                size: 16,
                              ),
                              width5Space,
                              Text(
                                getTranslate(context, 'payment.pay_now'),
                                style: semibold14Primary,
                              )
                            ],
                          )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  paymentList[index]['status'] == "Paid"
                      ? Navigator.pushNamed(context, '/success')
                      : Navigator.pushNamed(context, '/paymentMethods');
                },
                child: Container(
                  padding: const EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    color: paymentList[index]['color'] as Color,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    paymentList[index]['status'].toString(),
                    style: semibold16White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
